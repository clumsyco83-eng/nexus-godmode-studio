# Evidence Standard — Normative Rules

The single normative source for what counts as evidence, what work status words mean, and when a
claim of completion is permitted. Skills restate the parts they enforce.

The rule this document exists to enforce: **an agent's statement that a task succeeded is not
evidence that it succeeded.**

---

## 1. Status vocabulary

These six words have fixed meanings across the pack. Using one loosely is a reporting defect.

| Status | Means | Does not mean |
| --- | --- | --- |
| **PLANNED** | Designed or scoped. Nothing has been done. | That anyone agreed to it. |
| **APPROVED** | The owner explicitly authorized this specific work. | That it has started. |
| **IN PROGRESS** | Work has begun and is not finished. | That it is nearly done. |
| **BLOCKED** | Work cannot proceed until a named dependency, decision, or approval resolves. | That it failed. |
| **VERIFIED** | Acceptance criteria were checked against observed evidence by something other than the producer. | That it shipped. |
| **COMPLETED** | Verified *and* delivered into its intended state. | That it will keep working. |

A status may never advance because time passed, because an agent said so, or because the work
"should" be done. It advances on evidence.

## 2. Evidence tiers

Ranked by how hard the evidence is to fake or misread. Prefer the highest tier the situation
allows, and state which tier a claim rests on when the claim is consequential.

| Tier | Evidence | Example |
| --- | --- | --- |
| **E1 — Observed execution** | The thing was run and its real output captured. | Test output, build log, HTTP response, screenshot of the running feature, query result. |
| **E2 — Independent inspection** | A second party read the actual artifact. | Reviewer read the diff; Verifier re-ran the acceptance check. |
| **E3 — Artifact inspection** | The artifact itself was examined, by the producer. | Reading the file that was written; the diff as produced. |
| **E4 — Instrument report** | A tool reported a result without the raw output being seen. | "CI is green" with no log; a summary line. |
| **E5 — Assertion** | Someone said it works. | An agent's completion message. |

**E5 is never sufficient on its own for any consequential claim.** E4 is acceptable only for
low-risk, easily reversible work, and only when the instrument is trusted and its failure mode is
loud.

## 3. Acceptance criteria

Criteria must be written before the work, and must be checkable by someone who did not do the
work.

A usable criterion names:

- the observable behavior or state,
- the exact check that produces the observation,
- the result that counts as pass,
- the result that counts as fail.

"Login works" is not a criterion. "POST /session with valid credentials returns 200 and a
Set-Cookie header; with an invalid password returns 401 and no cookie" is.

Criteria that cannot fail are not criteria. If no realistic input produces a fail, the check is
decorative.

## 4. Failure classification

When verification fails, classify before repairing. Repairing the wrong class wastes the retry
budget.

| Class | Signature | Response |
| --- | --- | --- |
| **Specification** | The criteria were wrong or ambiguous. | Fix the criteria, re-approve if scope changed. |
| **Implementation** | Code does not do what was intended. | Repair, then re-verify. |
| **Environment** | Config, credentials, network, versions. | Fix the environment; do not patch the code around it. |
| **Flake** | Non-deterministic; passes and fails on identical input. | Do not retry blindly. Find the source of non-determinism or quarantine with a record. |
| **Regression** | Previously passing behavior now fails. | Stop forward work; isolate the change that caused it. |
| **Harness** | The verification itself is broken. | Fix the check before trusting any result from it. |

## 5. Repair loops

Bounded, and the bound is real.

- Fix the diagnosed cause, not the symptom the error message mentions.
- Re-run the *same* check that failed, plus a regression signal.
- **Three attempts on the same failure is the default ceiling.** After the third, stop and
  escalate with what was tried, what was observed, and the current hypothesis.
- Two consecutive attempts that change nothing observable means the diagnosis is wrong. Return to
  diagnosis rather than trying a fourth variation.
- Never widen the change to make a check pass. Never weaken, skip, or delete a check to make it
  pass — that is the single most damaging move available and it destroys the signal permanently.

## 6. Confidence

State confidence for consequential conclusions, and tie it to evidence rather than to fluency.

- **High** — E1 or E2 evidence; alternatives were tested; failure modes considered.
- **Moderate** — evidence supports the conclusion, but a material unknown remains.
- **Low** — sparse or conflicting evidence, or a load-bearing assumption is unverified.

Always state what would raise or lower confidence. A conclusion with no falsifier is not
decision-ready.

## 7. Rollback criteria

Written before deployment, not after an incident.

Name: the signal that triggers rollback, the threshold, who or what decides, the procedure, the
expected time to restore, and what data could be lost. If a change cannot be rolled back, that
fact is stated explicitly and raises the approval bar to RED.

## 8. Fact / inference / assumption

Every consequential report distinguishes:

- **FACT** — observed and cited to its source or output.
- **INFERENCE** — derived from facts, with the derivation visible.
- **ASSUMPTION** — taken as true without verification; flagged as risky if the conclusion
  changes when it is false.
- **HYPOTHESIS** — a candidate explanation, with the test that would confirm or kill it.

Blending these into confident prose is the most common way a report becomes untrustworthy.
