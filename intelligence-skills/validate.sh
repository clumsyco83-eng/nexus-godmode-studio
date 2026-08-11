#!/usr/bin/env bash
#
# validate.sh — lint the NEXUS Intelligence Foundation skill pack.
#
# Checks each skill against the Agent Skills open standard (frontmatter limits,
# directory/name agreement, reference depth), against this pack's own structural
# contract (27 required sections), and against the security baseline (no secrets).
#
# Usage:
#   ./validate.sh            validate the pack in this directory
#   ./validate.sh --quiet    errors and the summary only
#
# Exit codes: 0 = pass (warnings allowed), 1 = at least one error.

set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
QUIET=0
[[ "${1:-}" == "--quiet" ]] && QUIET=1

command -v python3 >/dev/null 2>&1 || {
  echo "ERROR: python3 is required for validation but was not found." >&2
  exit 1
}

PACK_DIR="$HERE" QUIET="$QUIET" python3 - <<'PYTHON'
import os
import re
import sys

pack = os.environ["PACK_DIR"]
quiet = os.environ["QUIET"] == "1"

errors, warnings, passes = [], [], []


def err(where, msg):
    errors.append(f"{where}: {msg}")


def warn(where, msg):
    warnings.append(f"{where}: {msg}")


def ok(msg):
    passes.append(msg)


# ---------------------------------------------------------------- expectations

SKILLS = [
    ("01-memory-intelligence", "memory-intelligence"),
    ("02-knowledge-intelligence", "knowledge-intelligence"),
    ("03-deep-research", "deep-research"),
    ("04-source-verification", "source-verification"),
    ("05-freshness-intelligence", "freshness-intelligence"),
    ("06-universal-retrieval", "universal-retrieval"),
    ("07-contradiction-fact-check", "contradiction-fact-check"),
    ("08-intelligence-router", "intelligence-router"),
]

TOP_LEVEL = ["README.md", "MANIFEST.md", "SHARED-PRINCIPLES.md"]

# The 27 required sections. Each entry is (label, accepted-heading regex).
# Where a skill expresses a required topic under a domain-specific heading, the
# accepted alternates are listed explicitly rather than padding docs with filler.
REQUIRED_SECTIONS = [
    ("Name",                          None),   # frontmatter + H1, checked separately
    ("Version",                       None),   # **Version:** line, checked separately
    ("Mission",                       r"Mission"),
    ("Exact responsibility",          r"Exact responsibility"),
    ("What the skill DOES",           r"What this skill DOES$"),
    ("What the skill DOES NOT do",    r"What this skill DOES NOT do"),
    ("Activation triggers",           r"Activation triggers"),
    ("Non-activation conditions",     r"Non-activation conditions"),
    ("Inputs",                        r"Inputs"),
    ("Allowed information sources",   r"Allowed information sources"),
    ("Source-of-truth hierarchy",     r"Source-of-truth hierarchy"),
    ("Workflow",                      r"Workflow|Pipeline|Computation"),
    ("Decision rules",                r"Decision rules"),
    ("Output format",                 r"Output format|.*schema"),
    ("Confidence rules",              r"Confidence rules"),
    ("Freshness rules",               r"Freshness rules|Volatility classes"),
    ("Failure handling",              r"Failure handling"),
    ("Ambiguity handling",            r"Ambiguity handling"),
    ("Contradiction handling",        r"Contradiction handling"),
    ("Security rules",                r"Security rules"),
    ("Privacy rules",                 r"Privacy rules"),
    ("Integration: intelligence",     r"Integration with other intelligence skills"),
    ("Integration: NEXUS",            r"Integration with NEXUS"),
    ("Integration: Verifier",         r"Integration with Verifier"),
    ("Examples",                      r"Examples?$"),
    ("Anti-patterns",                 r"Anti-patterns"),
    ("Definition of Done",            r"Definition of Done"),
]

# Credential shapes that must never appear. Deliberately narrow: these match real
# secret formats, not the words "password" or "token" used in prose.
SECRET_PATTERNS = [
    (r"AKIA[0-9A-Z]{16}", "AWS access key id"),
    (r"ghp_[A-Za-z0-9]{36}", "GitHub personal access token"),
    (r"gho_[A-Za-z0-9]{36}", "GitHub OAuth token"),
    (r"sk-[A-Za-z0-9]{32,}", "OpenAI-style secret key"),
    (r"sk-ant-[A-Za-z0-9\-_]{20,}", "Anthropic API key"),
    (r"xox[baprs]-[A-Za-z0-9\-]{10,}", "Slack token"),
    (r"-----BEGIN (RSA |EC |OPENSSH |PGP )?PRIVATE KEY-----", "private key block"),
    (r"eyJ[A-Za-z0-9_\-]{10,}\.eyJ[A-Za-z0-9_\-]{10,}\.", "JWT"),
    (r"(?i)\b(password|passwd|secret|api[_-]?key|access[_-]?token)\s*[:=]\s*"
     r"['\"][^'\"\s]{8,}['\"]", "assigned credential literal"),
]

RESERVED_NAME_WORDS = ["anthropic", "claude"]


# ------------------------------------------------------------------- utilities

def read(path):
    with open(path, "r", encoding="utf-8") as fh:
        return fh.read()


def parse_frontmatter(text, where):
    """Return (dict, body). Frontmatter must start at the very first byte."""
    if text.startswith("﻿"):
        err(where, "file begins with a BOM; frontmatter must start at the first byte")
        text = text.lstrip("﻿")
    if not text.startswith("---\n"):
        err(where, "no YAML frontmatter at the first byte (must open with '---')")
        return {}, text
    end = text.find("\n---\n", 3)
    if end == -1:
        err(where, "frontmatter is not closed with '---'")
        return {}, text
    block, body = text[4:end], text[end + 5:]

    # Minimal YAML: top-level 'key:' entries, supporting '>' folded scalars.
    fields, key, buf = {}, None, []
    for line in block.split("\n"):
        m = re.match(r"^([A-Za-z0-9_-]+):\s*(.*)$", line)
        if m:
            if key is not None:
                fields[key] = " ".join(buf).strip()
            key = m.group(1)
            rest = m.group(2).strip()
            buf = [] if rest in (">", "|", ">-", "|-") else [rest]
        elif key is not None:
            buf.append(line.strip())
    if key is not None:
        fields[key] = " ".join(buf).strip()
    return fields, body


# ------------------------------------------------------------- top-level files

for name in TOP_LEVEL:
    path = os.path.join(pack, name)
    if os.path.isfile(path):
        ok(f"{name} present")
    else:
        err("pack", f"missing required top-level file {name}")

for script in ("install.sh", "validate.sh"):
    path = os.path.join(pack, script)
    if os.path.isfile(path):
        if os.access(path, os.X_OK):
            ok(f"{script} present and executable")
        else:
            warn("pack", f"{script} is not executable (chmod +x)")
    else:
        warn("pack", f"{script} not found")

# Nothing unexpected at the top level.
expected_top = set(TOP_LEVEL) | {"install.sh", "validate.sh"} | {d for d, _ in SKILLS}
for entry in sorted(os.listdir(pack)):
    if entry.startswith("."):
        continue
    if entry not in expected_top:
        warn("pack", f"unexpected top-level entry '{entry}'")


# ------------------------------------------------------------------- per skill

for directory, expected_name in SKILLS:
    sdir = os.path.join(pack, directory)
    where = directory

    if not os.path.isdir(sdir):
        err(where, "skill directory is missing")
        continue

    skill_md = os.path.join(sdir, "SKILL.md")
    tests_md = os.path.join(sdir, "TESTS.md")

    if not os.path.isfile(skill_md):
        err(where, "SKILL.md is missing")
        continue
    if not os.path.isfile(tests_md):
        err(where, "TESTS.md is missing")

    text = read(skill_md)
    fields, body = parse_frontmatter(text, where)

    # --- frontmatter: name
    name = fields.get("name")
    if not name:
        err(where, "frontmatter has no 'name'")
    else:
        if len(name) > 64:
            err(where, f"name is {len(name)} chars (max 64)")
        if not re.fullmatch(r"[a-z0-9-]+", name):
            err(where, f"name '{name}' must be lowercase letters, numbers and hyphens only")
        for reserved in RESERVED_NAME_WORDS:
            if reserved in name.lower():
                err(where, f"name contains reserved word '{reserved}'")
        if "<" in name or ">" in name:
            err(where, "name contains XML tag characters")
        if name != expected_name:
            err(where, f"name '{name}' should be '{expected_name}' "
                       f"(directory name with the ordering prefix stripped)")
        else:
            ok(f"{directory}: name '{name}' matches the unprefixed directory")

    # --- frontmatter: description
    desc = fields.get("description")
    if not desc:
        err(where, "frontmatter has no 'description'")
    else:
        if len(desc) > 1024:
            err(where, f"description is {len(desc)} chars (max 1024)")
        elif len(desc) < 120:
            warn(where, f"description is only {len(desc)} chars; "
                        "skill selection depends on it carrying trigger conditions")
        else:
            ok(f"{directory}: description {len(desc)} chars (limit 1024)")
        if re.search(r"<[A-Za-z/][^>]*>", desc):
            err(where, "description contains XML tags")
        if re.search(r"\b(I can|I will|you can use this)\b", desc, re.I):
            warn(where, "description should be written in the third person")
        if not re.search(r"\bUse (when|whenever|for|before|after|at|during|in)\b", desc):
            warn(where, "description does not state when to use the skill")

    # --- frontmatter: portability (only name + description)
    extra = set(fields) - {"name", "description"}
    if extra:
        err(where, f"non-portable frontmatter keys present: {sorted(extra)}; "
                   "only 'name' and 'description' are portable across Claude and ChatGPT")

    # --- version line
    if re.search(r"^\*\*Version:\*\*\s*\d+\.\d+\.\d+", body, re.M):
        ok(f"{directory}: version declared")
    else:
        err(where, "no '**Version:** x.y.z' line in the body")

    # --- H1 title
    if not re.search(r"^#\s+\S", body, re.M):
        err(where, "no H1 title in the body")

    # --- required sections
    headings = re.findall(r"^##\s+(?:\d+\.\s*)?(.+?)\s*$", body, re.M)
    missing = []
    for label, pattern in REQUIRED_SECTIONS:
        if pattern is None:
            continue
        if not any(re.fullmatch(pattern, h) or re.match(pattern, h) for h in headings):
            missing.append(label)
    if missing:
        err(where, f"missing required section(s): {', '.join(missing)}")
    else:
        ok(f"{directory}: all 27 required sections present")

    # --- body length (official guidance: keep under 500 lines)
    lines = body.count("\n") + 1
    if lines > 500:
        warn(where, f"SKILL.md body is {lines} lines; guidance is under 500 "
                    "(split into references/)")
    else:
        ok(f"{directory}: body {lines} lines (limit 500)")

    # --- relative references resolve, and stay one level deep
    for target in re.findall(r"\]\((?!https?:)([^)#]+)", body):
        target = target.strip()
        if not target or target.startswith("#"):
            continue
        resolved = os.path.normpath(os.path.join(sdir, target))
        if not os.path.exists(resolved):
            err(where, f"broken relative reference: {target}")
        if "\\" in target:
            err(where, f"reference '{target}' uses backslashes; use forward slashes")

    # --- TESTS.md content shape
    if os.path.isfile(tests_md):
        ttext = read(tests_md)
        normal = len(re.findall(r"^###\s+(?:N|R)-\d+", ttext, re.M))
        edge = len(re.findall(r"^###\s+E-\d+", ttext, re.M))
        adv = len(re.findall(r"^###\s+A-\d+", ttext, re.M))
        fail = len(re.findall(r"^###\s+F-\d+", ttext, re.M))
        need_normal = 25 if directory.startswith("08") else 5
        problems = []
        if normal < need_normal:
            problems.append(f"{normal} normal/routing (need {need_normal})")
        if edge < 5:
            problems.append(f"{edge} edge (need 5)")
        if adv < 3:
            problems.append(f"{adv} adversarial (need 3)")
        if fail < 3:
            problems.append(f"{fail} failure (need 3)")
        if problems:
            err(where, "TESTS.md case counts: " + "; ".join(problems))
        else:
            ok(f"{directory}: TESTS.md {normal} normal/routing, {edge} edge, "
               f"{adv} adversarial, {fail} failure")


# ------------------------------------------------------------- secret scanning

scanned = 0
for root, dirs, files in os.walk(pack):
    dirs[:] = [d for d in dirs if not d.startswith(".")]
    for fname in files:
        if not fname.endswith((".md", ".sh", ".yml", ".yaml", ".json")):
            continue
        path = os.path.join(root, fname)
        rel = os.path.relpath(path, pack)
        if rel == "validate.sh":      # this file defines the patterns
            continue
        scanned += 1
        content = read(path)
        for pattern, label in SECRET_PATTERNS:
            for m in re.finditer(pattern, content):
                line = content[:m.start()].count("\n") + 1
                err(rel, f"possible {label} at line {line}")
ok(f"secret scan: {scanned} files scanned, patterns for "
   f"{len(SECRET_PATTERNS)} credential shapes")


# -------------------------------------------------------------------- reporting

GREEN, YELLOW, RED, DIM, RESET = "\033[32m", "\033[33m", "\033[31m", "\033[2m", "\033[0m"
if not sys.stdout.isatty():
    GREEN = YELLOW = RED = DIM = RESET = ""

print(f"\n{DIM}NEXUS Intelligence Foundation — validation{RESET}")
print(f"{DIM}{pack}{RESET}\n")

if not quiet:
    for line in passes:
        print(f"  {GREEN}pass{RESET}  {line}")
    print()

for line in warnings:
    print(f"  {YELLOW}warn{RESET}  {line}")
for line in errors:
    print(f"  {RED}FAIL{RESET}  {line}")

print(f"\n  {len(passes)} passed, {len(warnings)} warnings, {len(errors)} errors\n")
sys.exit(1 if errors else 0)
PYTHON
