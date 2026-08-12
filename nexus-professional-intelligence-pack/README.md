# NEXUS Professional Intelligence Pack

**v1.0.0 — READY FOR HUMAN REVIEW. Not installed, not deployed.**

Twenty modular Agent Skills that help an assistant architect, supervise, review, secure, verify,
troubleshoot and improve NEXUS — a long-term AI platform intended to mature from a personal
assistant into a human-supervised digital-business operating system.

Built to the [Agent Skills open standard](https://agentskills.io/specification): a directory per
skill, each containing a `SKILL.md` with YAML frontmatter and Markdown instructions. The standard
is supported across ChatGPT, OpenAI Codex, Claude, GitHub Copilot, Cursor, Gemini CLI and others,
so these skills install wherever that format is read.

---

## What this is

Twenty specialist departments inside one organization — not twenty rephrasings of "think
carefully."

Each skill owns a bounded class of problems, knows when it should *not* be involved, carries a
repeatable workflow, states what evidence would prove its work is done, and hands off explicitly
when the task crosses into another lane.

### Why it exists

An assistant running a business over years fails in specific, predictable ways:

- it reports work as finished that was never checked,
- it builds competently for a market that does not want the thing,
- it accumulates features until nothing can be changed safely,
- it remembers something that used to be true and acts on it with full confidence,
- it grows revenue while losing money on every customer,
- it makes forty individually-sensible changes and ends up slower, costlier, and no better,
- and it gradually acquires enough capability that a single injected instruction matters.

Each skill in this pack exists because one of those failures is expensive and a generic assistant
does not reliably avoid it.

### What it is not

It grants no autonomy. It bypasses no safety control. It promises no business outcome. The revenue
stages in `shared/MATURITY-STAGES.md` describe the conditions a system is built for, not results
anyone can deliver. Read `SECURITY-REVIEW.md` §7 before installing — the short version is that
this pack is instructions, not enforcement.

---

## The twenty skills

**Platform and engineering**

| Skill | Owns |
| --- | --- |
| `nexus-systems-architect` | Boundaries, contracts, failure domains, migrations, ADRs |
| `ai-agent-orchestration-engineer` | Planners, workers, state machines, retries, escalation, model routing |
| `skill-architecture-engineer` | The skill registry: routing, loading, versioning, admission, deprecation |
| `verification-reliability-engineer` | Whether "done" is actually done, on evidence |
| `security-permission-architect` | Least privilege, secrets, risk classification, injection defense |
| `github-code-review-engineer` | What actually changed in the diff, versus what was claimed |
| `context-token-efficiency-engineer` | Context and token cost, without cutting verification |

**Data, operations and delivery**

| Skill | Owns |
| --- | --- |
| `knowledge-memory-engineer` | Memory with provenance, timestamps, confidence and expiry |
| `devops-observability-engineer` | Deploys, environments, monitoring, rollback, backups |
| `testing-qa-engineer` | Test strategy, edge cases, failure injection, release gates |
| `professional-web-app-engineering` | Commercial-quality websites, apps and APIs |
| `data-analytics-engineer` | Definitions, data quality, cohorts, attribution, honest numbers |

**Business**

| Skill | Owns |
| --- | --- |
| `business-systems-architect` | How the business runs after launch: SOPs, bottlenecks, automation |
| `market-competitive-intelligence` | Does the market exist, on dated primary evidence |
| `product-strategy-pmf` | What to build, what to cut, has fit been found |
| `growth-marketing-intelligence` | Distribution: SEO, content, social, paid, email, partnerships |
| `sales-conversion-systems` | Turning arrivals into revenue, ethically |
| `finance-unit-economics` | Whether it makes money. Decision support only — never moves money |
| `product-project-management` | Decomposition, dependencies, honest status |
| `recursive-improvement-evaluation` | Whether the new version is measurably better |

---

## How they cooperate

Each skill is authoritative inside its lane and advisory everywhere else. One skill leads; others
contribute a named section rather than a competing analysis.

```text
Architecture      → Security review → Implementation → Testing → Verification
Business research → Product strategy → Finance → Growth → Analytics → Recursive improvement
Any change        → Verification → Human approval where the risk class requires it
```

Two orderings are load-bearing:

- **Research precedes product strategy.** Deciding what to build on assumptions you invented is
  the failure the arrangement is designed to prevent.
- **Verification terminates every chain that produces a change.** Nothing reaches COMPLETED
  without it, and the producer never verifies its own work.

Full routing, conflict priority, and near-miss pairs: `ROUTING-MATRIX.md`.

## How automatic activation is meant to work

Only the `name` and `description` of each skill are resident at all times; the body loads when the
skill activates, and reference files load only when a task needs them. So **the description is the
entire routing signal**, and every one in this pack states four things: what the skill does, when
to use it, the concrete trigger concepts, and when *not* to use it — naming the skill that owns
those cases instead.

That negative space is what prevents the common failure of a catalog where everything activates
for everything. Descriptions here run 803–896 characters against a 1024 limit, and every one
carries explicit non-triggers.

You should not have to remember skill names. Ordinary requests should route on their own:

```text
"Review the next NEXUS upgrade and check whether Claude's implementation is safe."
  → nexus-systems-architect + security-permission-architect
  + github-code-review-engineer + verification-reliability-engineer

"Research an online business opportunity and tell me if the economics could scale."
  → market-competitive-intelligence → product-strategy-pmf → finance-unit-economics

"Build the professional website architecture for this business."
  → professional-web-app-engineering, routing into product, testing, security, analytics
```

---

## Installing

**Creation is not installation. Installation is not activation.** Nothing here has been installed
anywhere. Do this deliberately, after reading `SECURITY-REVIEW.md`.

**ChatGPT** (Business, Enterprise, Edu and Healthcare plans) — add skills through the Skills
interface in your workspace settings; upload the skill folder or its zip. Availability and the
exact flow vary by plan and change over time, so follow OpenAI's current Skills documentation
rather than instructions written here.

**Codex, Claude Code, Cursor, Copilot, Gemini CLI, OpenCode and other standard-compliant hosts** —
copy the skill directories into the host's skills path:

```bash
cp -R skills/<skill-name> <host-skills-directory>/
```

**Install selectively.** You do not need all twenty. Each is self-contained and none references
another's files. Start with the lanes matching your current work — the engineering seven, or the
business six — and add others when a gap appears. Twenty resident descriptions is a real
per-request cost, and unused skills are pure overhead.

Before installing, configure host permissions to match `MANIFEST.md`. The pack assumes it cannot
move money, publish, or delete; if the host allows those, the pack's rules are policy rather than
protection.

## Testing

```bash
python3 validate.py
```

Checks all twenty skills against the specification and the pack's own rules: frontmatter position
and syntax, name conformance and directory match, description limits, required sections, reference
resolution and depth, duplicate names, body size, and prohibited claim language. Read-only,
standard library only, no network.

Then run `EVALUATION-SUITE.md` — fifteen scenarios covering activation, non-activation, multi-skill
routing, skill conflicts, architecture review, security-sensitive requests, agent-implementation
review, business analysis, website projects, repair loops, efficiency, memory provenance, financial
decision support, growth strategy, and improvement comparison. Each defines expected activations,
expected non-activations, workflow, pass criteria and fail conditions.

**These have not been run.** Until they are, this pack's routing accuracy is unmeasured, and the
pack says so rather than implying otherwise.

## Updating

- Change **one skill at a time**, and bump only that skill's version.
- Re-run `validate.py`.
- Re-run the affected scenarios **and those of adjacent skills** — sharpening one description
  shifts traffic to and from its neighbors.
- Record the change, its reason, and its measured effect in `CHANGELOG.md`.
- Never edit all twenty because one is wrong. That destroys your ability to attribute any change in
  behavior.

## Removing a skill

Delete its directory, or disable it in the host. Nothing else needs changing — no skill depends on
another skill's files. Update `MANIFEST.md` and note the removal and its reason in `CHANGELOG.md`.

Removal is maintenance, not loss. A skill that has not routed correctly in months is taxing every
request.

## Diagnosing wrong activation

| Symptom | Cause | Fix |
| --- | --- | --- |
| Skill did not fire | Description lacks the user's vocabulary, or the task looked simple enough to handle directly | Add the missing trigger concepts. Do not broaden into adjacent work |
| Skill fires too often | Description is abstract, or has no negative space | Add explicit non-triggers naming the right skill. This is the quieter and more damaging error |
| Two skills fight | Boundary defect, not a precedence problem | Sharpen the split until routing is obvious; edit both descriptions to name each other |
| A description edit made things worse | Multiple elements changed at once | Revert; change one element at a time; re-test neighbors |
| Everything activates | Catalog too large, or descriptions drifted into describing excellence | Measure per-skill value; retire the lowest |

Routing claims need evidence: run the prompt, observe the activation, three times. "This
description should work" settles nothing.

## Preventing skill bloat

The catalog degrades predictably — every skill taxes every request, safe descriptions activate for
everything, overlapping skills fight, and nobody ever removes anything.

Four rules hold it back. Admit a skill only when there is a real capability gap, a repeatable task
class, a description that separates it cleanly from every existing skill, and a benefit exceeding
its always-on cost. Treat overlap as a defect to fix rather than manage. Measure routing accuracy
rather than assuming it. Retire on evidence.

`skill-architecture-engineer` owns this and can be pointed at the catalog directly.

---

## Contents

```text
nexus-professional-intelligence-pack/
├── README.md              this file
├── MANIFEST.md            per-skill version, triggers, permissions, resources, risk, evaluation
├── ROUTING-MATRIX.md      task type → primary + supporting, conflict priority, near-miss pairs
├── SECURITY-REVIEW.md     threat model, findings with evidence, residual risk, verdict
├── EVALUATION-SUITE.md    15 scenarios with pass criteria and fail conditions
├── CHANGELOG.md           semantic versioning history
├── validate.py            specification validator — read-only, stdlib only, no network
├── shared/                normative rules, read by the owner, never by a skill
│   ├── GOVERNANCE.md          human authority, risk classes, standing controls, precedence
│   ├── EVIDENCE-STANDARD.md   status vocabulary, evidence tiers E1–E5, repair loops
│   ├── HANDOFF-PROTOCOL.md    handoff packet, chains, escalation, non-activation
│   └── MATURITY-STAGES.md     Stage 1–4 and the stage rule
└── skills/                20 self-contained skill directories
    └── <skill-name>/
        ├── SKILL.md
        └── references/    (5 skills carry one)
```

`shared/` is deliberately **not** referenced from inside any `SKILL.md`. The specification requires
skill references to stay within the skill directory, and a skill installed alone must be complete.
Each skill restates the rules it enforces; `shared/` is the single place those rules get edited.

## Governance

Permanent, and not negotiable by any skill in this pack:

- The human owner holds final authority.
- Planning is not execution. Discussion is not approval.
- Where command-gated execution is required, work begins only on the explicit initiation command.
- GREEN / YELLOW / RED classification is enforceable; RED needs individual human approval.
- Guardian stays supervisory; Watchdog stays independent; Verifier stays independent.
- Workspace restrictions, audit logging and emergency stop are enforceable.
- Financial transactions and irreversible actions stay with the human.
- No skill may bypass, weaken, or design around any of the above.

Full text: `shared/GOVERNANCE.md`.
