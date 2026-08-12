# Changelog

Semantic versioning. Each skill versions independently; the pack version changes when skills are
added or removed, or when a shared normative document changes.

- **MAJOR** — a skill's ownership boundary changes, a governance rule changes, or a routing change
  breaks an existing expectation.
- **MINOR** — new capability inside an existing boundary, or a description change that measurably
  improves routing.
- **PATCH** — corrections, clarifications, and wording that does not alter behavior or routing.

Every entry records what changed, why, and what was measured. An entry with no measured effect
says so rather than implying improvement.

---

## [1.0.0] — 2026-08-12

Initial release. Twenty skills, four shared normative documents, five reference files, one
validator, and the pack-level documentation.

**Status: READY FOR HUMAN REVIEW.** Not installed, not deployed anywhere.

### Added — skills (all at 1.0.0)

Platform and engineering: `nexus-systems-architect`,
`ai-agent-orchestration-engineer`, `skill-architecture-engineer`,
`verification-reliability-engineer`, `security-permission-architect`,
`github-code-review-engineer`, `context-token-efficiency-engineer`.

Data, operations and delivery: `knowledge-memory-engineer`,
`devops-observability-engineer`, `testing-qa-engineer`,
`professional-web-app-engineering`, `data-analytics-engineer`.

Business: `business-systems-architect`, `market-competitive-intelligence`,
`product-strategy-pmf`, `growth-marketing-intelligence`,
`sales-conversion-systems`, `finance-unit-economics`,
`product-project-management`, `recursive-improvement-evaluation`.

Each carries the fifteen-section structure: Purpose, Trigger Conditions, Do Not Trigger When,
Required Inputs, Operating Principles, Step-by-Step Workflow, Decision Framework, Verification
Requirements, Failure Handling, Security / Permission Rules, Handoff Rules, Output Format,
Examples, Anti-Patterns, Completion Criteria.

### Added — shared normative documents

`shared/GOVERNANCE.md`, `shared/EVIDENCE-STANDARD.md`, `shared/HANDOFF-PROTOCOL.md`,
`shared/MATURITY-STAGES.md`.

### Added — reference files

Five skills carry deeper material, placed in `references/` so it loads only when needed:
`security-permission-architect/references/CONTROLS.md`,
`verification-reliability-engineer/references/EVIDENCE.md`,
`knowledge-memory-engineer/references/SCHEMA.md`,
`finance-unit-economics/references/FORMULAS.md`,
`recursive-improvement-evaluation/references/EVAL-PROTOCOL.md`.

The other fifteen skills carry none — depth was added where structured tables and schemas
genuinely belong outside the main body, not uniformly.

### Added — tooling and documentation

`validate.py`; `README.md`, `MANIFEST.md`, `ROUTING-MATRIX.md`, `SECURITY-REVIEW.md`,
`EVALUATION-SUITE.md`, this file.

### Design decisions worth recording

**Skills never reference `shared/`.** The Agent Skills specification requires file references to
stay within the skill directory and one level deep. A `../../shared/` reference would violate it
and would break for anyone installing a single skill. Each skill therefore restates the rules it
must enforce standalone, and `shared/` exists as the single place those rules are edited — read by
the owner, never loaded by a skill. This satisfies the intent of a shared resource without creating
a dependency that breaks on partial installation.

**`allowed-tools` is deliberately unused.** The field is experimental, support varies between
hosts, and it would embed a capability grant in a file that travels between environments.
Permissions belong to the host. `MANIFEST.md` documents what each skill's instructions authorize,
capped at `propose-red` — no skill can perform an irreversible action.

**One executable file, at pack root.** `validate.py` sits outside `skills/`, so no skill activation
runs it. `skills/` contains zero non-markdown files.

**Descriptions carry negative space.** All twenty state what the skill is *not* for and name the
skill that owns those cases. Omitting this is the main cause of catalogs where everything activates
for everything.

### Verified

`validate.py` — **PASS, 0 errors, 0 warnings**, 20 skills:

- frontmatter opens at byte zero, no BOM, correctly closed,
- `name` spec-conformant and matching its directory in all 20 cases,
- `description` non-empty and within 1024 characters (range 803–896),
- no frontmatter keys outside the specification's allowed set,
- no duplicate skill names,
- all 15 required sections present in all 20 skills,
- every relative reference resolves, stays inside its skill, and is one level deep,
- bodies 282–317 lines against a 500-line guidance, within the ~5,000-token recommendation,
- no prohibited claim language.

Security review completed and recorded in `SECURITY-REVIEW.md`: **PASS WITH RISK**. Zero
executable files inside `skills/`; no runtime instruction fetching; no network or execution verbs
outside prohibitions; no credential handling; untrusted-content rules in all twenty skills; human
approval preserved on every irreversible action; overclaiming language absent.

### Not verified

**The evaluation suite has not been run.** Routing accuracy and runtime boundary compliance are
**unmeasured**. `EVALUATION-SUITE.md` defines fifteen scenarios; running them requires the pack
installed in a host, which is the owner's decision and has not happened.

The security review is a **self-review (E3)**, not independent (E2). The pack's own standard calls
for E2 at this consequence level, so an independent review before installation is recommended.

### Next

1. Owner reads `SECURITY-REVIEW.md` §7 — the pack is instructions, not enforcement.
2. Independent security review.
3. Host permissions configured to match `MANIFEST.md`.
4. Install selectively — the lanes matching current work, not all twenty by default.
5. Run `EVALUATION-SUITE.md`; record results here with the date and pack version.
6. Fix routing defects one skill at a time, re-testing adjacent skills each time.
