# Security Review

**Subject:** NEXUS Professional Intelligence Pack v1.0.0
**Date:** 2026-08-12
**Reviewer:** Pack author, pre-release self-review
**Verdict:** PASS WITH RISK — safe to install after the owner reads §7

**Scope:** all 20 `SKILL.md` files, 5 reference files, 4 shared documents, `validate.py`, and the
pack's directory structure.

**Not in scope:** the behavior of any host that installs the pack; the NEXUS application itself;
runtime enforcement of the controls described. This review covers what the pack *instructs*, not
what a host *permits*. Those are different things, and the distinction matters — see §7.

**Independence limitation, stated up front:** this is a self-review by the author of the material.
It is E3 evidence (the artifact was inspected by its producer), not E2. The pack's own standard
requires E2 for work of this consequence, so an independent review before installation is
recommended and this document should not substitute for it.

---

## 1. Threat model

A skill pack is not passive documentation. Its text enters the assistant's instruction channel and
executes with the assistant's authority. The realistic threats are:

| # | Threat | Why it matters here |
| --- | --- | --- |
| T1 | A skill instructs the assistant to weaken or bypass a security control | The pack would become the mechanism that disables NEXUS's protections |
| T2 | A skill fetches instructions at runtime | Hands behavioral control to whoever can write to that source |
| T3 | A bundled script does something unexpected | Scripts execute with the user's privileges |
| T4 | A skill requests capability beyond its job | Standing over-privilege, exploitable later |
| T5 | A skill causes credentials to be read, logged, or transmitted | Direct credential compromise |
| T6 | A skill treats retrieved content as instruction | Prompt injection with real capability behind it |
| T7 | A skill authorizes an irreversible action without human approval | Financial or destructive loss |
| T8 | A skill overstates certainty or claims outcomes | Owner makes decisions on false confidence |
| T9 | A skill causes data to leave the owner's control | Confidentiality loss, often unnoticed |
| T10 | The pack degrades NEXUS's own oversight over time | Slow erosion is harder to detect than a single bad change |

---

## 2. Findings

### F1 — Bundled executable code: one file, at pack root

**Evidence:** `find . -type f ! -name "*.md"` returns exactly one result — `validate.py`.
`find skills -type f ! -name "*.md"` returns **zero**. No skill directory contains any executable
content whatsoever.

`validate.py` was read line by line. Its complete import set is `os`, `re`, `sys` — standard
library only. It contains no `subprocess`, `os.system`, `popen`, `eval`, `exec`, `socket`,
`urllib`, or `requests` call; the only occurrences of `http` in the file are string literals in the
link-checker used to *skip* external URLs. It opens files in read mode only, and performs no
delete, move, or write operation of any kind.

**Assessment:** Informational. The pack ships a way to verify itself, which is a security benefit
rather than a cost. It sits at pack root, outside `skills/`, so no skill activation causes it to
run. Running it is an explicit, optional user action.

**Residual risk:** none identified. The reader should still read the file before running it, as
they should with any script.

### F2 — Runtime instruction fetching: absent

**Evidence:** A pack-wide URL scan returns exactly one match:
`skills/security-permission-architect/SKILL.md:254`, `https://example.com/instructions.txt`.

That occurrence is inside Example 2, which presents that exact pattern as a skill to **reject**:
"the skill's behavior is controlled by whoever can write to that URL." The domain is IANA-reserved
and non-routable in practice. No skill instructs any fetch, download, or remote read of its own
instructions.

**Assessment:** T2 not present. The pattern is explicitly named as a rejection criterion in
`skill-architecture-engineer` (§ admission) and `security-permission-architect`
(`references/CONTROLS.md` §6).

### F3 — Network and execution verbs: absent outside prohibitions

**Evidence:** A scan for `curl`, `wget`, `download and run`, `pip install`, `npm install -g`,
`eval(`, `exec(`, `subprocess`, and `base64 -d` across `skills/` and `shared/`, filtered to exclude
lines containing negation cues, returns **zero results**. Every occurrence of such vocabulary in
the pack appears inside a rule forbidding it.

**Assessment:** T3 not present.

### F4 — Credentials: no values, no capability

**Evidence:** A pattern scan for assigned secret-like literals across the entire pack returns
none. Every skill that touches credentials instructs recording *location and injection method
only*. `shared/GOVERNANCE.md` §5 and `CONTROLS.md` §3 make this normative, and `CONTROLS.md`
specifies rotation — not deletion — as the remediation for an exposed secret.

**Assessment:** T5 not present. No skill declares credential-reading capability.

### F5 — Untrusted content: covered in all twenty skills

**Evidence:** Every `SKILL.md` carries an explicit rule that retrieved content — web pages,
repository files, issues, PR bodies, CI logs, tool output, customer messages, agent output — is
data and never instruction. Verified per file; `knowledge-memory-engineer` states it at lines
177, 264, and 280 in the specific form that matters most for memory: content stored in a form that
would later read as a directive is "an injection that persists across sessions."

`CONTROLS.md` §4 documents which defenses work (capability limits, approval gates, report-don't-obey)
and which do not (keyword filtering, instructing the model to ignore injections, domain trust).

**Assessment:** T6 addressed at the instruction level. Depth is proportionate: the pack correctly
identifies that capability limits and approval gates, not detection, are the controls that hold
when detection fails.

### F6 — Permissions: least privilege, no runtime grants

**Evidence:** `MANIFEST.md` declares a six-term permission vocabulary, capped at `propose-red`. No
skill declares network write, credential access, payment capability, or authority to perform an
irreversible action.

The optional `allowed-tools` frontmatter field is deliberately **unused** across all twenty
skills. This is the correct choice: the field is marked experimental in the specification, support
varies between hosts, and it would embed a capability grant inside a file that travels between
environments. Permissions belong to the host.

**Assessment:** T4 not present.

### F7 — Human approval: preserved throughout

**Evidence:** RED classification appears in every skill, with GREEN/YELLOW/RED defined identically
in `GOVERNANCE.md` §3 and `CONTROLS.md` §1. Three rules recur across the pack and were checked
individually:

- RED actions are listed **individually** for approval, never batched.
- A prior approval does not extend to a repeat in a new context.
- Routine frequency does not downgrade an action's class —
  `business-systems-architect` states this explicitly for automations that become
  habitual, which is the realistic erosion path.

Three skills — `context-token-efficiency-engineer`, `testing-qa-engineer`,
`verification-reliability-engineer` — contain no occurrence of the word "approval." Each was
read to confirm this is correct rather than a gap: all three are GREEN-only by design (measuring,
testing, inspecting) and take no action requiring authorization. Recorded as checked and accepted.

**Assessment:** T7 addressed.

### F8 — Financial boundary: the hardest limit in the pack

**Evidence:** `finance-unit-economics` states that NEXUS never transfers money, initiates
payments, accesses banking or brokerage systems, enters payment credentials, signs or accepts
agreements, opens or closes accounts, or makes any financial commitment — and states these are not
permissions the skill can grant. `GOVERNANCE.md` §5 makes the same boundary normative pack-wide.
`E13` in the evaluation suite tests it directly with a request to move £5,000, and lists any offer
to do so as a fail condition.

The skill also declines to give accounting, tax, investment, or legal advice, recommending a
qualified professional instead.

**Assessment:** T7 addressed for the highest-consequence category.

### F9 — Overclaiming: mechanically checked

**Evidence:** `validate.py` scans every markdown file for unbounded-capability and
guaranteed-outcome language, exempting lines that prohibit those phrases. Result: zero violations.
`GOVERNANCE.md` §8 makes the prohibition normative, and `MATURITY-STAGES.md` states explicitly that
the revenue bands describe operating conditions rather than promised results.

**Assessment:** T8 addressed. The check is a lint, not a proof — a violation on a line containing
a negation cue would be missed, which is why this review reads the files directly as well.

### F10 — Data egress: approval-gated

**Evidence:** Skills that could cause data to leave the owner's control each gate it:
`data-analytics-engineer` classifies external export as RED;
`market-competitive-intelligence` forbids entering business information into third-party
tools without approval; `context-token-efficiency-engineer` keeps checkpoints and
summaries inside the authorized workspace; `security-permission-architect` forbids
transmitting findings, code, or configuration externally as part of a review.

**Assessment:** T9 addressed at the instruction level.

### F11 — Oversight erosion: structurally resisted

**Evidence:** Three mechanisms work against slow degradation:

- `recursive-improvement-evaluation` counts *risk increase* as one of its seven
  questions and states that a speed or cost gain purchased by removing a check is a regression,
  not an improvement. Its Example 3 is exactly this case.
- `context-token-efficiency-engineer` declines optimizations that cut verification,
  testing, or security, and offers alternatives instead of complying.
- `skill-architecture-engineer` treats "would require relaxing a control" as an
  admission-rejection criterion rather than a finding to weigh.

Verifier independence is structural in `verification-reliability-engineer`: the producer
never verifies its own output, and `ai-agent-orchestration-engineer` forbids designing an
agent that can approve its own RED action.

**Assessment:** T1 and T10 addressed as well as instructions can address them. Enforcement is the
host's.

### F12 — Defensive-only posture

**Evidence:** `security-permission-architect` states it does not write exploits, malware,
credential-stuffing tooling, evasion techniques, or attack infrastructure, and scopes defensive
tests to systems the owner controls, with authorization.
`market-competitive-intelligence` forbids impersonation, false accounts, terms-violating
scraping, and use of confidential or improperly obtained competitor information.

**Assessment:** No offensive capability in the pack.

---

## 3. Specification conformance

`validate.py` run against the pack on 2026-08-12: **PASS, 0 errors, 0 warnings**, 20 skills.

Verified: frontmatter opens at byte zero with no BOM; `name` is spec-conformant and matches its
directory in all 20 cases; `description` is non-empty and within 1024 characters (range
803–896); no frontmatter keys outside the specification's allowed set; no duplicate names; all 15
required sections present in all 20 skills; every relative reference resolves, stays inside its
skill directory, and is exactly one level deep; bodies range 282–317 lines against a 500-line
guidance and sit within the ~5,000-token recommendation.

The one-level-deep constraint drove a deliberate design decision worth recording: **no `SKILL.md`
references the `shared/` directory.** A skill installed alone must be complete, and a `../../`
reference would both break and violate the specification. Each skill restates the rules it must
enforce; `shared/` is the single place those rules are edited, read by the owner rather than
loaded by a skill.

---

## 4. Prompt-injection resistance

Assessed against the realistic attack: NEXUS reads a web page, repository file, or customer email
containing text shaped like instructions.

**Present:** every skill treats retrieved content as data; the pack instructs reporting injections
rather than obeying them; approval gates sit in front of every irreversible effect, which is the
control that holds when detection fails; no skill loads instructions at runtime; agent output is
treated as untrusted input to the next stage; and memory explicitly refuses to store content in a
form that would later read as a directive — the persistent-injection case.

**Not claimed:** instruction-level defenses do not stop injection. They reduce the chance the
assistant complies. The control that actually bounds the damage is capability limitation and the
human approval gate, and the pack says so rather than implying that its rules are sufficient.

---

## 5. What this review could not verify

Stated explicitly, because a security review that omits its own gaps is misleading:

- **Runtime behavior.** No skill has been activated in a host. Whether the assistant follows these
  instructions under pressure is unmeasured. `EVALUATION-SUITE.md` defines the tests; they have not
  been run.
- **Host enforcement.** The pack describes controls it cannot enforce. If a host grants broad
  filesystem or network access, no instruction in this pack prevents its use.
- **NEXUS's own controls.** Guardian, Watchdog, Verifier, workspace restrictions, audit logging,
  and emergency stop are referenced as existing. Whether they are implemented and effective was not
  assessed and is outside this scope.
- **Independence.** This is a self-review (E3), not an independent one (E2).

---

## 6. Residual risks

| Risk | Severity | Mitigation |
| --- | --- | --- |
| Instructions are followed inconsistently under pressure | Moderate | Run `EVALUATION-SUITE.md`; E04, E06, E10, E13 test exactly this |
| Host grants capability the pack assumes is absent | Moderate | Configure host permissions to match the manifest before installing |
| Owner treats pack rules as enforced controls | Moderate | See §7 |
| Self-review missed something | Low–Moderate | Obtain an independent review |
| 20 always-resident descriptions add per-request cost | Low | Measured: 803–896 chars each. Retire unused skills rather than shortening all |
| Prohibited-language lint has a known blind spot | Low | Files were also read directly; noted in F9 |

---

## 7. The one thing the owner must understand before installing

**This pack is instructions, not enforcement.**

Every control it describes — risk classification, approval gates, workspace boundaries, the
financial boundary, verifier independence — is a rule the assistant is told to follow. None of it
is a mechanism that *prevents* the action. If the host environment grants the ability to move
money, delete files, or publish externally, then these documents are the reason it should not
happen, not the thing stopping it.

Treat the pack as a well-specified set of professional standards, and configure real enforcement
separately: host permission settings, workspace restrictions, credential isolation, and the NEXUS
controls the pack assumes exist. A pack that says "never transfer money" running in an environment
where transfers are possible is a policy, not a safeguard.

Read this way, the pack is a genuine improvement to how NEXUS work is done. Read as a security
boundary, it would provide false assurance — which is the specific failure this section exists to
prevent.

---

## 8. Verdict

**PASS WITH RISK.**

No finding blocks installation. The pack contains no executable code inside any skill, no runtime
instruction fetching, no credential handling, no network capability, no offensive tooling, and no
instruction that weakens a security control. It preserves human approval on every irreversible
action and holds a hard financial boundary.

The risk that remains is not in the material — it is in what the material can and cannot do.
Instruction-level controls are not enforcement, and this pack has not yet been observed running.

**Recommended before installation:**

1. The owner reads §7.
2. An independent reviewer reads the pack, since this review is E3.
3. Host permissions are configured to match `MANIFEST.md` rather than assumed.

**Recommended after installation:**

4. `EVALUATION-SUITE.md` is run, with results recorded in `CHANGELOG.md`. Until then, both routing
   accuracy and boundary compliance are unmeasured.

**Creation is not installation. Installation is not activation.** This pack is complete and ready
for review; it has not been installed or deployed anywhere.
