#!/usr/bin/env python3
"""
Validate the NEXUS Professional Intelligence Pack against the Agent Skills specification.

Read-only. No network access, no imports beyond the standard library, no side effects.
Run from anywhere:  python3 validate.py [pack_directory]

Checks performed:
  1.  SKILL.md exists in every skill directory
  2.  Frontmatter opens at the very first byte, no BOM, closed with ---
  3.  `name` present, 1-64 chars, lowercase alphanumeric with single hyphens,
      no leading/trailing/consecutive hyphen, and equal to the directory name
  4.  `description` present, non-empty, at most 1024 characters
  5.  No frontmatter keys outside the spec's allowed set
  6.  No duplicate skill names across the pack
  7.  SKILL.md body under 500 lines and roughly under the 5,000-token guidance
  8.  Every relative markdown link inside a skill resolves to a real file
  9.  Skill-internal references stay one level deep and never escape the skill root
 10.  Prohibited overclaiming language absent from all pack files
"""

import os
import re
import sys

ALLOWED_KEYS = {"name", "description", "license", "compatibility", "metadata", "allowed-tools"}
NAME_RE = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")
LINK_RE = re.compile(r"\[[^\]]*\]\(([^)]+)\)")

# Language the pack forbids: unbounded-capability and guaranteed-outcome claims.
PROHIBITED = [
    r"\bunlimited\b", r"\bunstoppable\b", r"\ball-powerful\b", r"\bomnipotent\b",
    r"\bnever fails?\b", r"\bguaranteed (?:success|results?|profits?|revenue|income)\b",
    r"\bwill make you (?:rich|money)\b", r"\bfully autonomous\b", r"\bno human (?:needed|required)\b",
]

MAX_NAME = 64
MAX_DESC = 1024
MAX_BODY_LINES = 500
MAX_BODY_BYTES = 20000  # ~5,000 tokens at ~4 bytes/token


class Report:
    def __init__(self):
        self.errors = []
        self.warnings = []

    def error(self, where, msg):
        self.errors.append(f"{where}: {msg}")

    def warn(self, where, msg):
        self.warnings.append(f"{where}: {msg}")


def parse_frontmatter(raw, where, rep):
    """Return (fields, body) or (None, None). Handles scalar and folded (>) values."""
    if raw.startswith("﻿"):
        rep.error(where, "file begins with a BOM; frontmatter must start at the first byte")
        return None, None
    if not raw.startswith("---\n"):
        rep.error(where, "frontmatter must open with '---' at the very first byte")
        return None, None

    end = raw.find("\n---\n", 3)
    if end == -1:
        rep.error(where, "frontmatter is not closed with '---'")
        return None, None

    block = raw[4:end + 1]
    body = raw[end + 5:]

    fields, key, folded = {}, None, []
    for line in block.split("\n"):
        if not line.strip():
            continue
        if line.startswith((" ", "\t")):          # continuation of a folded value
            if key:
                folded.append(line.strip())
            continue
        if key and folded:                        # flush previous folded value
            fields[key] = " ".join(folded)
            folded = []
        if ":" not in line:
            rep.error(where, f"unparseable frontmatter line: {line!r}")
            continue
        k, v = line.split(":", 1)
        key, v = k.strip(), v.strip()
        if v in (">", "|", ">-", "|-"):
            folded = []
        else:
            fields[key] = v.strip("'\"")
            key = None
    if key and folded:
        fields[key] = " ".join(folded)

    return fields, body


def check_skill(skill_dir, rep, seen_names):
    name_expected = os.path.basename(skill_dir)
    path = os.path.join(skill_dir, "SKILL.md")
    where = f"skills/{name_expected}/SKILL.md"

    if not os.path.isfile(path):
        rep.error(f"skills/{name_expected}", "missing SKILL.md")
        return

    with open(path, encoding="utf-8") as fh:
        raw = fh.read()

    fields, body = parse_frontmatter(raw, where, rep)
    if fields is None:
        return

    extra = set(fields) - ALLOWED_KEYS
    if extra:
        rep.error(where, f"frontmatter keys outside the spec: {sorted(extra)}")

    name = fields.get("name")
    if not name:
        rep.error(where, "missing required field 'name'")
    else:
        if len(name) > MAX_NAME:
            rep.error(where, f"name is {len(name)} chars, max {MAX_NAME}")
        if not NAME_RE.match(name):
            rep.error(where, f"name {name!r} must be lowercase alphanumeric with single hyphens")
        if name != name_expected:
            rep.error(where, f"name {name!r} does not match directory {name_expected!r}")
        if name in seen_names:
            rep.error(where, f"duplicate skill name {name!r}")
        seen_names.add(name)

    desc = fields.get("description")
    if not desc:
        rep.error(where, "missing required field 'description'")
    else:
        if len(desc) > MAX_DESC:
            rep.error(where, f"description is {len(desc)} chars, max {MAX_DESC}")
        low = desc.lower()
        if "do not use" not in low and "don't use" not in low:
            rep.warn(where, "description states no negative triggers ('Do not use ...')")
        if len(desc) < 120:
            rep.warn(where, f"description is only {len(desc)} chars; may be too vague to route")

    lines = body.count("\n")
    if lines > MAX_BODY_LINES:
        rep.error(where, f"body is {lines} lines, over the {MAX_BODY_LINES}-line guidance")
    if len(body.encode()) > MAX_BODY_BYTES:
        rep.warn(where, f"body is {len(body.encode())} bytes, over the ~5,000-token guidance")

    # Required internal sections
    required = [
        "Purpose", "Trigger Conditions", "Do Not Trigger When", "Required Inputs",
        "Operating Principles", "Step-by-Step Workflow", "Decision Framework",
        "Verification Requirements", "Failure Handling", "Security / Permission Rules",
        "Handoff Rules", "Output Format", "Examples", "Anti-Patterns", "Completion Criteria",
    ]
    for section in required:
        if f"## {section}" not in body:
            rep.error(where, f"missing required section '## {section}'")

    # Relative links must resolve, stay inside the skill, and stay one level deep
    for target in LINK_RE.findall(body):
        if target.startswith(("http://", "https://", "#", "mailto:")):
            continue
        if target.startswith("/") or target.startswith(".."):
            rep.error(where, f"link {target!r} escapes the skill root")
            continue
        if target.count("/") > 1:
            rep.error(where, f"link {target!r} is more than one level deep")
        if not os.path.isfile(os.path.join(skill_dir, target)):
            rep.error(where, f"unresolved reference: {target}")


def check_language(pack, rep):
    """Flag overclaiming language, except where the line is prohibiting it.

    The pack necessarily quotes the banned vocabulary in the rules that ban it. A line is
    treated as a prohibition when, with the matched phrase removed, it still contains a
    negation or rejection cue. This is a lint, not a proof: a genuine violation on a line
    that happens to contain "not" would be missed, so the security review reads these
    files directly rather than relying on this check alone.
    """
    negation = re.compile(
        r"\b(never|no|not|reject|prohibit\w*|forbid\w*|avoid|without|claims? of|refus\w+)\b",
        re.IGNORECASE,
    )
    for root, dirs, files in os.walk(pack):
        dirs[:] = [d for d in dirs if d not in {".git", "__pycache__"}]
        for fn in files:
            if not fn.endswith(".md"):
                continue
            full = os.path.join(root, fn)
            rel = os.path.relpath(full, pack)
            with open(full, encoding="utf-8") as fh:
                text = fh.read()
            lines = text.split("\n")
            for pattern in PROHIBITED:
                for m in re.finditer(pattern, text, re.IGNORECASE):
                    idx = text[:m.start()].count("\n")
                    line = lines[idx]
                    remainder = line.replace(m.group(0), " ")
                    if negation.search(remainder):
                        continue  # the line forbids the phrase rather than claiming it
                    rep.error(f"{rel}:{idx + 1}", f"prohibited claim language: {m.group(0)!r}")


def main():
    pack = os.path.abspath(sys.argv[1] if len(sys.argv) > 1 else os.path.dirname(__file__) or ".")
    skills_dir = os.path.join(pack, "skills")
    rep = Report()

    if not os.path.isdir(skills_dir):
        print(f"FAIL: no skills/ directory in {pack}")
        return 1

    skill_dirs = sorted(
        os.path.join(skills_dir, d) for d in os.listdir(skills_dir)
        if os.path.isdir(os.path.join(skills_dir, d))
    )

    seen = set()
    for d in skill_dirs:
        check_skill(d, rep, seen)
    check_language(pack, rep)

    for required in ("README.md", "MANIFEST.md", "ROUTING-MATRIX.md",
                     "SECURITY-REVIEW.md", "EVALUATION-SUITE.md", "CHANGELOG.md"):
        if not os.path.isfile(os.path.join(pack, required)):
            rep.error(required, "required pack document is missing")

    print(f"Validated {len(skill_dirs)} skills in {pack}\n")
    for w in rep.warnings:
        print(f"  WARN  {w}")
    for e in rep.errors:
        print(f"  ERROR {e}")

    print()
    if rep.errors:
        print(f"FAIL — {len(rep.errors)} error(s), {len(rep.warnings)} warning(s)")
        return 1
    print(f"PASS — 0 errors, {len(rep.warnings)} warning(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
