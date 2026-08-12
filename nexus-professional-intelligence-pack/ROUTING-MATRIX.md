# Routing Matrix

How work reaches the right skill, what supports it, who wins when several apply, and how the
result gets checked. Use this to diagnose activation problems: find the task type, compare the
expected routing against what actually happened, and the mismatch will usually point at a
description that is too broad, too narrow, or missing negative space.

Skill numbers refer to the pack order in `MANIFEST.md`.

---

## 1. Primary routing table

| Task type | Primary | Supporting | Expected handoff | Verification |
| --- | --- | --- | --- | --- |
| New NEXUS subsystem or structural change | `nexus-systems-architect` | `security-permission-architect`, `ai-agent-orchestration-engineer` | ADR → security review → implementation | Three scenarios walked, including a failure; contracts defined |
| Multi-agent workflow, delegation, job design | `ai-agent-orchestration-engineer` | `verification-reliability-engineer`, `security-permission-architect` | Design → verification placement → implementation | State machine has terminal states; recovery exercised |
| Adding, retiring, or repairing a skill | `skill-architecture-engineer` | `security-permission-architect`, `recursive-improvement-evaluation` | Description → routing tests → security review → admission | Routing tested both directions, neighbors re-tested |
| Anything claimed to be done | `verification-reliability-engineer` | the producing specialist | Evidence → verdict → status | Raw evidence at the required tier; verifier ≠ producer |
| Credentials, permissions, auth, injection, risk class | `security-permission-architect` | the specialist whose work is under review | Findings → remediation → re-test | Control attacked, not just read |
| Reviewing what a coding agent changed | `github-code-review-engineer` | `security-permission-architect`, `verification-reliability-engineer` | Diff read → findings → verification | Actual diff, deletions, and test-change counts read |
| Session or workflow cost, model routing | `context-token-efficiency-engineer` | `knowledge-memory-engineer` | Measure → optimize → confirm no quality loss | Baseline measured; quality compared after |
| What persists across sessions | `knowledge-memory-engineer` | `context-token-efficiency-engineer` | Schema → retrieval → expiry policy | Cold resume works; contradiction detection exercised |
| Moving something into real operation | `devops-observability-engineer` | `security-permission-architect`, `verification-reliability-engineer` | Readiness → RED approvals → deploy → verify | Version serving observed; rollback and restore exercised |
| What to test and how | `testing-qa-engineer` | `verification-reliability-engineer` | Strategy → suite → release gate | Every new test observed failing first |
| Building a website, app, or API for a business | `professional-web-app-engineering` | `product-strategy-pmf`, `testing-qa-engineer`, `security-permission-architect`, `data-analytics-engineer` | Requirements → IA → build → test → security → launch | Journey completed on a real device; unhappy paths exercised |
| Measuring what happened | `data-analytics-engineer` | `finance-unit-economics` | Definitions → data quality → findings | Sample sizes stated; queries reproducible |
| How the business runs after launch | `business-systems-architect` | `finance-unit-economics`, `ai-agent-orchestration-engineer` | Map → constraint → SOP → automation | SOP executed by someone other than its author |
| Does this market exist | `market-competitive-intelligence` | — (runs first, feeds others) | Evidence → product strategy → finance | Primary sources, dated; echo chains identified |
| What should we build | `product-strategy-pmf` | `market-competitive-intelligence`, `finance-unit-economics` | Riskiest assumption → MVP → fit signals | Fit thresholds set before data arrived |
| Nobody knows we exist | `growth-marketing-intelligence` | `data-analytics-engineer`, `sales-conversion-systems` | Channel choice → instrumentation → measure | Retention checked first; measured to customers, not clicks |
| People arrive but do not buy | `sales-conversion-systems` | `data-analytics-engineer`, `finance-unit-economics` | Funnel → diagnosis → offer/page → test | Checkout completed end to end on a phone |
| Does this make money | `finance-unit-economics` | `data-analytics-engineer` | Unit economics → sensitivity → decision | Inputs labelled measured or assumed; sensitivity run |
| Scoping, sequencing, status | `product-project-management` | `verification-reliability-engineer` | Decomposition → criteria → tracking | Status reflects verified evidence only |
| Did the change help | `recursive-improvement-evaluation` | the changed component's owner | Baseline → comparison → keep/iterate/revert | Both versions run on an identical set; variance measured |

---

## 2. Standard chains

```text
Architecture      → Security review → Implementation → Testing → Verification
Business research → Product strategy → Finance → Growth → Analytics → Recursive improvement
Skill design      → Security review → Routing evaluation → Admission
Agent design      → Verification placement → Implementation → Review → Verification
Operations        → RED approval → Deploy → Post-deploy verification
Any change        → Verification → Human approval where the risk class requires it
```

Two chains carry a hard ordering rule:

- **Research precedes product strategy.** Deciding what to build on market assumptions the product
  skill invented itself is the failure this pack is arranged to prevent.
- **Verification terminates every chain that produces a change.** Nothing reaches COMPLETED
  without passing through it.

---

## 3. Conflict priority

When several skills legitimately apply, resolve in this order:

1. **The owner's explicit instruction**, including a named skill.
2. **Security and verification participate rather than yield.** On a question of permission, risk
   class, or whether evidence supports a claim, `security-permission-architect` and
   `verification-reliability-engineer` are not outranked by a delivery skill. The more restrictive
   rule wins.
3. **The skill owning the primary decision leads** — the one whose absence would change the
   outcome most.
4. **Narrower scope beats broader scope.**
5. **Ties break toward fewer skills.**

The lead skill integrates; supporting skills contribute a named section rather than a competing
full analysis. Contradictions between contributors are surfaced to the owner, never averaged.

**Known deliberate tensions**, and how they resolve:

| Tension | Resolution |
| --- | --- |
| Efficiency wants to cut a check; verification requires it | Verification wins. The efficiency skill declines the optimization and offers savings elsewhere. |
| Growth wants traffic; product strategy says retention is absent | Product strategy wins. Acquisition into a leaking product amplifies the loss. |
| Delivery wants to ship; security found material risk | Security's gate holds. Shipping a known risk is the owner's decision, recorded. |
| Architecture wants structure; the stage does not warrant it | The stage rule wins unless current failure is evidenced. Evidence of failure now outranks the heuristic. |
| Testing says it passes; verification says the evidence is insufficient | Verification wins. Building the checks and judging the evidence are deliberately separate roles. |
| Project management wants to report progress; nothing is verified | Status stays IN PROGRESS. Intent is never reported as completion. |

---

## 4. Near-miss routing

The pairs most likely to misroute, and what separates them. Most activation complaints resolve to
one of these.

| If the task is… | Not this | But this |
| --- | --- | --- |
| Judging whether a claim of completion holds | `testing-qa-engineer` | `verification-reliability-engineer` |
| Designing the test suite itself | `verification-reliability-engineer` | `testing-qa-engineer` |
| Which skill should activate | `ai-agent-orchestration-engineer` | `skill-architecture-engineer` |
| Which agent handles which step at runtime | `skill-architecture-engineer` | `ai-agent-orchestration-engineer` |
| NEXUS's own internal structure | `professional-web-app-engineering` | `nexus-systems-architect` |
| A customer's website architecture | `nexus-systems-architect` | `professional-web-app-engineering` |
| Context cost inside one session | `knowledge-memory-engineer` | `context-token-efficiency-engineer` |
| What survives between sessions | `context-token-efficiency-engineer` | `knowledge-memory-engineer` |
| What the numbers were | `finance-unit-economics` | `data-analytics-engineer` |
| Whether the numbers add up to a business | `data-analytics-engineer` | `finance-unit-economics` |
| Getting people to the page | `sales-conversion-systems` | `growth-marketing-intelligence` |
| Getting people who arrived to buy | `growth-marketing-intelligence` | `sales-conversion-systems` |
| Whether one task is done | `recursive-improvement-evaluation` | `verification-reliability-engineer` |
| Whether the new version is better than the old | `verification-reliability-engineer` | `recursive-improvement-evaluation` |
| Security of a change | `github-code-review-engineer` | `security-permission-architect` (alongside, not instead) |
| Whether the diff matches what was asked | `verification-reliability-engineer` | `github-code-review-engineer` |
| Infrastructure reliability | `nexus-systems-architect` | `devops-observability-engineer` |
| Recurring business process design | `ai-agent-orchestration-engineer` | `business-systems-architect` |

---

## 5. Multi-skill scenarios

Worked routings for requests that legitimately need several skills. The lead is listed first.

**"Review the next NEXUS architecture upgrade and check whether Claude's implementation is safe."**
`nexus-systems-architect` (lead) → `security-permission-architect` →
`github-code-review-engineer` → `verification-reliability-engineer`.
Should not activate: growth, sales, finance, product strategy, market research.

**"Research an online business opportunity and tell me if its economics could scale."**
`market-competitive-intelligence` (lead) → `product-strategy-pmf` →
`finance-unit-economics`, with `business-systems-architect` if operations affect the economics.
Should not activate: any engineering skill.

**"Build the professional website architecture for this business."**
`professional-web-app-engineering` (lead) → `product-strategy-pmf` (what it must do) →
`testing-qa-engineer` → `security-permission-architect` → `data-analytics-engineer`
(instrumentation) → `devops-observability-engineer` (launch).
Should not activate: market research unless the offer itself is unvalidated.

**"Our agent keeps saying tasks are done when they aren't."**
`verification-reliability-engineer` (lead) → `ai-agent-orchestration-engineer` (the
structural fix: no self-verification) → `recursive-improvement-evaluation` (measure whether it
improved).
Should not activate: testing, unless the checks themselves are inadequate.

**"We're spending too much per task."**
`context-token-efficiency-engineer` (lead) → `ai-agent-orchestration-engineer` if the
cost is structural → `recursive-improvement-evaluation` to confirm the saving held.
Should not activate: `finance-unit-economics` unless the question is business profitability.

---

## 6. Diagnosing activation problems

**A skill did not fire when it should have.** Its description lacks the vocabulary the request
used, or the task looked simple enough to handle directly. Add the missing trigger concepts to the
description — do not broaden it into claiming adjacent work, which trades a miss for a worse
problem.

**A skill fires too often.** The description is abstract or lacks negative space. Add explicit
non-triggers naming the skill that should own those cases. Over-activation is the more damaging
error because it is quieter — nothing looks wrong, the answers are just diluted.

**Two skills fight.** This is a boundary defect, not a precedence problem. Sharpen the split until
routing is obvious and edit both descriptions to name each other. Adding a tie-break rule on top of
an ambiguous boundary preserves the defect.

**A description change made things worse.** Revert, then change one element at a time. Always
re-test the adjacent skills — sharpening one description shifts traffic to and from its neighbors.

**Everything activates.** The catalog is too large for the work, or descriptions have drifted
toward describing excellence rather than triggers. Measure per-skill value and retire the lowest.

Routing claims require evidence: the prompt was run and the activation observed. "This description
should trigger correctly" settles nothing. The protocol is in
`skills/recursive-improvement-evaluation/references/EVAL-PROTOCOL.md`, section 7.
