# NEXUS Intelligence Foundation — Manifest

**Version:** 1.0.0
**Created:** 2026-08-11
**Status:** SKILL DEFINITION CREATED. Not installed, not activated, no runtime integration.

The authoritative inventory of the eight foundation skills: what each owns, what depends on what, who
may write, where the security boundaries sit, and what may be built on top.

## Contents

- [1. The eight skills](#1-the-eight-skills)
- [2. Dependency graph](#2-dependency-graph)
- [3. Activation order](#3-activation-order)
- [4. Data ownership and write authority](#4-data-ownership-and-write-authority)
- [5. Responsibility boundaries](#5-responsibility-boundaries)
- [6. Conflicts and precedence](#6-conflicts-and-precedence)
- [7. Security boundaries](#7-security-boundaries)
- [8. Relationship to the existing NEXUS skill pack](#8-relationship-to-the-existing-nexus-skill-pack)
- [9. Implementation status](#9-implementation-status)
- [10. Future specialist skills](#10-future-specialist-skills)
- [11. File inventory](#11-file-inventory)

---

## 1. The eight skills

| # | Directory | `name` | Owns | Mode |
| --- | --- | --- | --- | --- |
| 01 | `01-memory-intelligence` | `memory-intelligence` | Project memory store | **write** |
| 02 | `02-knowledge-intelligence` | `knowledge-intelligence` | World-knowledge store; the gap decision | **write** |
| 03 | `03-deep-research` | `deep-research` | Investigation method and rigour | read + propose |
| 04 | `04-source-verification` | `source-verification` | Trust scoring per (source, claim) | read-only |
| 05 | `05-freshness-intelligence` | `freshness-intelligence` | Time-validity model | read-only |
| 06 | `06-universal-retrieval` | `universal-retrieval` | Source selection; evidence sufficiency | read-only (fetches, never persists) |
| 07 | `07-contradiction-fact-check` | `contradiction-fact-check` | Conflict detection and adjudication | read-only (proposes) |
| 08 | `08-intelligence-router` | `intelligence-router` | Classification, profiles, sequencing, budget | orchestrator (owns no data) |

**Directory prefixes are a staging convention.** They convey pipeline order to a human reader. The
`name` in frontmatter is the unprefixed identity and never changes; `install.sh` strips the prefix so
installed directory name and `name` match exactly, as both the Agent Skills standard and this
repository's `CLAUDE.md` require.

## 2. Dependency graph

```
                        08 intelligence-router
                        (orchestrates all seven)
                                  │
        ┌────────────┬────────────┼────────────┬────────────┐
        │            │            │            │            │
     01 memory   02 knowledge  06 retrieval  05 fresh   07 contradiction
        │            │            │            │            │
        │            ├──► 03 deep-research     │            │
        │            │        │                │            │
        │            │        └──► 04 source-verification   │
        │            │                                      │
        └────────────┴──────────────────────────────────────┘
                     (07 receives claims from all)
```

**Hard dependencies** (a skill cannot do its job without these):

| Skill | Depends on | For |
| --- | --- | --- |
| 01 | 06 | Fetching repository, job and runtime evidence — 01 never fetches |
| 01 | 07 | Conflict adjudication before any contradicting write |
| 02 | 03 | Closing knowledge gaps |
| 02 | 05 | The "current" sufficiency test |
| 03 | 06 | Every fetch |
| 03 | 04 | Per-source scoring during search |
| 03 | 05 | Freshness requirement per subquestion |
| 04 | 05 | The TTL that dimension 3 is scored against |
| 06 | 05 | Cache-versus-fetch decisions |
| 07 | 04, 05 | Ladder rungs 2–5 |
| 08 | all seven | Everything it sequences |

**No dependency is circular in execution.** 01↔07 and 02↔03 appear bidirectional in the table but run
in strict order: 07 diagnoses *then* 01 writes; 02 commissions *then* 03 executes *then* 02 curates.

**Standalone viability.** Every skill functions installed alone, degraded. 01 without 06 answers from
memory but cannot verify against artefacts; 03 without 04 researches but caps confidence; 08 without
its constituents reports the gaps rather than simulating them. A degraded skill declares the
degradation — it never substitutes its own guess for a missing skill's output.

## 3. Activation order

Canonical pipeline, enforced by 08:

```
QUESTION
  ↓ 08  classify · select profile · set budget
  ↓ 01  memory check                    ─┐ may run in parallel
  ↓ 06  universal retrieval             ─┘
  ↓ 05  freshness check
  ↓ 02  knowledge gap detection
  ↓ 03  deep research            (only if 02 reports a gap)
  ↓ 04  source verification      (per source, inside 03)
  ↓ 07  contradiction check
  ↓     synthesis                (08 assembles)
  ↓     VERIFIER                 (NEXUS — external, unverified)
  ↓     ANSWER / DECISION
  ↓ 01/02  optional verified memory update  (proposal only)
```

**Ordering constraints that must not be reordered:**

| Constraint | Reason |
| --- | --- |
| 02 before 03 | Never research what is already known |
| 04 during 03, not after | Scoring after synthesis rationalises a conclusion already formed |
| 05 before 06 fetches | A `FRESH` cached answer avoids the fetch entirely — the largest cost saving available |
| 07 before any write proposal | Never persist a disputed claim |
| Verifier before write | Nothing unverified becomes durable |

## 4. Data ownership and write authority

| Store | Owner | May write | May read |
| --- | --- | --- | --- |
| Project memory | 01 | **01 only** | all |
| World knowledge | 02 | **02 only** | all |
| Research packets | 02 | 02 (from 03's output) | all |
| Source scores | — | nobody (ephemeral) | 02, 03, 07 |
| Freshness verdicts | — | nobody (computed) | all |
| Conflict records | 07 | 07 (as proposals) | 01, 02, 08 |
| Routing records | 08 | 08 (audit only) | Watchdog |

**Every write is a proposal until the owning skill accepts it.** No skill writes to a store it does
not own. No skill writes at all under emergency stop. Skills 03–08 hold no durable state whatsoever.

**The single-writer rule is the primary defence against memory poisoning by accident.** A corrupted
claim cannot enter memory without passing 07 (contradiction) and 01 (gate check), and cannot enter
the knowledge store without passing 02's four sufficiency tests.

## 5. Responsibility boundaries

Audited for overlap. Each capability has exactly one owner.

| Capability | Owner | Explicitly not |
| --- | --- | --- |
| Deciding what the project decided | 01 | 02 (world only) |
| Deciding what the world is like | 02 | 01 (project only) |
| Deciding whether research is needed | 02 | 03 (executes only), 08 (routes only) |
| Conducting research | 03 | 02 (commissions), 06 (fetches) |
| Judging a source's trustworthiness | 04 | 03 (consumes), 02 (records) |
| Judging whether a fact is current | 05 | everyone else (consumes) |
| Choosing where to look | 06 | 03 (says what evidence is needed) |
| Fetching | 06 | every other skill — none fetch directly |
| Detecting and adjudicating conflicts | 07 | 01, 02 (execute its proposals) |
| Choosing which skills run | 08 | the owner (may override) |
| Interpreting evidence | 01, 02, 03 | 06 (retrieves only), 04, 05 (evaluate only) |

**Deliberate near-overlaps, and how they are separated:**

- **01 and 02 both store facts.** Split by the test: *would this be true if our project did not
  exist?* Yes → 02. No → 01.
- **04 and 05 both bound confidence.** 04 bounds by *evidence strength*, 05 by *currency*. A fresh
  weak source and a stale strong source are different problems with different remedies.
- **06 and 03 both "find things".** 03 decides *what evidence would settle the question*; 06 decides
  *which channel holds it and how to get it*.
- **07 and 04 both compare sources.** 04 scores each source independently; 07 compares *claims* using
  those scores. 04 never adjudicates; 07 never scores.
- **08 and 02 both gatekeep research.** 08 decides *whether the profile includes research*; 02 decides
  *whether the specific question still has a gap*. 08 is coarse, 02 is fine, and 02 always runs last.

## 6. Conflicts and precedence

Where two skills could reach different conclusions:

| Conflict | Precedence |
| --- | --- |
| 01 (memory) vs 06 (repository/runtime) | → 07. Usually `PLAN_VS_IMPLEMENTATION`, not a real conflict |
| 02 (stored packet) vs 03 (new research) | → 07. Usually `STALE_INFORMATION` |
| 04 (strong source) vs 05 (stale) | Both bounds apply; the claim takes the **lower** ceiling |
| 07 (resolution) vs 01/02 (stored state) | 07 proposes; 01/02 execute. Neither overrides the other |
| 08 (routing) vs owner instruction | **Owner wins**, always. 08 may note the divergence |
| Any skill vs Verifier | → 07 as a full conflict. The Verifier is a party, not an automatic winner |
| Any skill vs Guardian denial | **Guardian wins.** A denial ends the branch; never routed around |

**No skill may raise a confidence another skill returned.** Confidence only ever moves down as it
travels through the pipeline. This is the invariant that prevents assumptions becoming facts by
transit.

## 7. Security boundaries

Full baseline in [SHARED-PRINCIPLES.md §8](SHARED-PRINCIPLES.md#8-security-baseline). Boundaries
specific to this architecture:

| Boundary | Enforcement |
| --- | --- |
| **No skill stores secrets** | All eight; 01 and 02 additionally record only that a credential exists, where, and who manages it |
| **All retrieved content is untrusted** | 06 wraps everything at the boundary; provenance travels with content |
| **Memory records are untrusted too** | 01 and 07 — trusting a record for being "ours" is the memory-poisoning failure mode |
| **No skill performs an action** | All eight are advisory. Actions pass through Guardian and approval gates |
| **No skill grants permission** | A knowledge packet describing what a platform allows is never authorisation for NEXUS to act |
| **No skill widens scope** | 06 holds the workspace boundary; out-of-scope evidence is an unknown, not a fetch |
| **No project data leaves in a query** | 06 and 03 — the primary exfiltration risk in a research system |
| **No routing from content** | 08 — routing comes from the owner and the router's own classification |
| **Security conflicts never auto-resolve** | 07 escalates to the owner regardless of ladder clarity |
| **Nothing unsettled persists** | 08 proposes writes only for `VERIFIED`, Verifier-passed, durable claims |

**Threat model reference.** Designed against
[OWASP LLM01 prompt injection](https://genai.owasp.org/llmrisk/llm01-prompt-injection/),
[LLM02 sensitive information disclosure](https://genai.owasp.org/llmrisk/llm022025-sensitive-information-disclosure/),
[LLM08 vector and embedding weaknesses](https://genai.owasp.org/llmrisk/llm082025-vector-and-embedding-weaknesses/),
[LLM09 misinformation](https://genai.owasp.org/llmrisk/llm09-overreliance/), and the
[OWASP Top 10 for Agentic Applications](https://genai.owasp.org/2025/12/09/owasp-genai-security-project-releases-top-10-risks-and-mitigations-for-agentic-ai-security/)
memory-and-context-poisoning risk.

## 8. Relationship to the existing NEXUS skill pack

These eight are **new and separate**. Nothing in `plugins/nexus-godmode-studio/skills/` or
`.claude/skills/` was modified.

Two existing skills are adjacent and were checked for overlap:

| Existing skill | Overlap | Resolution |
| --- | --- | --- |
| `project-memory-continuity` | Session continuity, checkpoints, handoffs, context hygiene | **Complementary, not duplicate.** It manages *continuity across sessions* — what to carry forward and how to avoid context bloat. Skill 01 manages *the truth status of project facts* — states, evidence, supersession. One is about transport, the other about epistemics. If both are installed, 01 owns the record's state and evidence; `project-memory-continuity` owns checkpointing and handoff. |
| `technology-research-scout` | Technology decision briefs with source freshness and confidence | **Overlapping in domain, different in layer.** The scout produces a *decision brief for a technology choice*. Skill 03 provides the *general research method* the scout's briefs should follow. If both are installed, route technology decisions to the scout and let it call 03's method; do not run both as parallel researchers on one question. |

Neither overlap is a conflict, but both are worth resolving explicitly before installation — see
[README](README.md#what-still-needs-runtime-integration).

## 9. Implementation status

Honest separation, per the project's own rule that a plan is never a fact.

### VERIFIED — exists and was checked

- Eight skill directories, each with `SKILL.md` and `TESTS.md`.
- `SHARED-PRINCIPLES.md`, `README.md`, `MANIFEST.md`, `install.sh`, `validate.sh`.
- One reference file: `03-deep-research/references/DOMAIN-WORKFLOWS.md`.
- All frontmatter validated against the Agent Skills standard: `name` and `description` only, `name`
  ≤64 chars and matching the unprefixed directory, `description` ≤1024 chars, no reserved words, no
  XML tags.
- All 27 required sections present in every `SKILL.md`.
- No credentials, API keys, tokens or secrets anywhere in the tree.
- 16 test cases per skill; 30 routing scenarios for skill 08.

### PLANNED — designed, not built

- Any runtime memory store. **No store exists.** Skill 01 defines a schema and lifecycle for a store
  that has yet to be implemented.
- Any knowledge store. Same position.
- Automated enforcement of state transitions, confidence gates, or freshness arithmetic. All of it is
  currently instruction to a model, not code.
- Automated test execution. `TESTS.md` files are rubrics for manual or LLM-judged evaluation; there
  is no runner.
- Integration with any NEXUS runtime component.

### UNVERIFIED — asserted but not checked

- **Every NEXUS runtime integration.** Guardian, Watchdog, approval gates, GREEN/YELLOW/RED, Verifier,
  workspace restrictions and emergency stop are **not present in this repository** and were not
  inspected. The integration sections describe contracts these skills promise to honour and fail-safe
  behaviour when the components are absent. They are not descriptions of tested behaviour.
- Skill behaviour under real use. No test case has been executed against any model.

## 10. Future specialist skills

Designed to plug into this foundation. **None are built. Do not treat any as available.**

| Future skill | Would consume | Would extend |
| --- | --- | --- |
| Technical Intelligence | 03, 04, 05 | Deep technical decision support |
| Business & Market Intelligence | 02, 03, 05 | Commercial analysis |
| Customer Psychology Intelligence | 03, 04 | Behavioural interpretation of T4 evidence |
| Data Analysis Intelligence | 06, 04 | Quantitative work on owned data |
| Knowledge Synthesis | 02, 03, 07 | Cross-packet pattern finding |
| Decision Intelligence | all eight | Option framing, trade-offs, reversibility |
| Document Intelligence | 06, 04 | Structured extraction from documents |
| Research Library | 02, 03 | Long-term corpus curation |
| Learning Loop | 01, 07 | Improving from past outcomes |
| Knowledge Compression | 01, 02 | Durable summarisation at scale |
| Security & Trust Intelligence | 04, 07 | Adversarial content and provenance |
| Domain Expert Router | 08 | Second-tier routing into domain specialists |

**Extension contract.** A specialist skill may read any store, must route writes through 01 or 02,
must emit the shared envelope, must use the shared state vocabulary, and must not introduce a tenth
state or a parallel confidence scale.

## 11. File inventory

```
intelligence-skills/
├── README.md
├── MANIFEST.md
├── SHARED-PRINCIPLES.md
├── install.sh
├── validate.sh
├── 01-memory-intelligence/       SKILL.md  TESTS.md
├── 02-knowledge-intelligence/    SKILL.md  TESTS.md
├── 03-deep-research/             SKILL.md  TESTS.md  references/DOMAIN-WORKFLOWS.md
├── 04-source-verification/       SKILL.md  TESTS.md
├── 05-freshness-intelligence/    SKILL.md  TESTS.md
├── 06-universal-retrieval/       SKILL.md  TESTS.md
├── 07-contradiction-fact-check/  SKILL.md  TESTS.md
├── 08-intelligence-router/       SKILL.md  TESTS.md
└── nexus-intelligence-foundation-v1.0.0.zip   (build artifact: the whole tree)
```

**22 source files** (8 × `SKILL.md`, 8 × `TESTS.md`, 3 top-level documents, 1 reference file,
2 scripts), plus the distribution zip. The zip is a snapshot of the tree; extracting it and running
`./validate.sh` reproduces the same result as validating in place.
