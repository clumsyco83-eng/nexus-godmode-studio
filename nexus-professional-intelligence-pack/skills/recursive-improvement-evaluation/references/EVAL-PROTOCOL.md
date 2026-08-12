# Evaluation Protocol

Reference material for the Recursive Improvement & Evaluation Engineer.

## Contents

1. Designing an evaluation set
2. Variance and how many runs
3. Scoring rubrics
4. A/B protocol
5. Regression detection
6. Complexity accounting
7. Evaluating skill routing
8. Postmortem structure

---

## 1. Designing an evaluation set

A good evaluation set discriminates — it produces different results for genuinely different
versions. A set where everything passes regardless tells you nothing and costs money to run.

Compose it from four groups:

- **Representative cases (50–60%)** — drawn from real tasks the system actually receives, not
  invented ones. Real tasks are messier and expose more.
- **Hard cases (20–30%)** — the ones that have failed before, sit at the edge of capability, or
  involve ambiguity. Improvements show up here first.
- **Control cases (10–20%)** — tasks the change should *not* affect. If these move, something
  unintended happened, and that is often the most valuable finding.
- **Known-failure cases** — things that currently fail. Whether they now pass is the clearest
  possible signal.

Size: 30–50 cases is usually enough to see a real effect while staying affordable. Fewer than 20
makes variance dominate.

**Refresh the set periodically.** A set optimized against for months stops predicting real
performance — improvements start transferring to the benchmark rather than to the work. Rotate in
new real tasks and retire cases everything passes.

Keep a held-out portion the change was not designed against. Tuning against the full set and then
reporting on it measures fit to the set, not capability.

---

## 2. Variance and how many runs

Most measures in agentic systems are non-deterministic. The first job is to find out how much they
move on their own.

**Establish variance before comparing anything:** run the baseline 3–5 times on the full set and
record the spread, not just the mean.

```text
baseline: 7.2, 7.5, 6.9, 7.4, 7.1   →  mean 7.22, range 6.9–7.5, spread ±0.3
```

A new version scoring 7.4 is inside that range. It has not been shown to be better.

**Rule of thumb:** a difference smaller than the baseline's observed range is not a result. A
difference roughly twice the spread is worth acting on. Between those, run more.

For deterministic measures — token counts, latency under fixed conditions, pass/fail on fixed
inputs — fewer runs suffice, but still run more than once; environments vary.

Report the number of runs and the spread with every figure. A single number with no spread is not
interpretable and invites over-reading.

---

## 3. Scoring rubrics

Where quality is judged rather than measured, the rubric must be written before the runs and
applied identically to both versions.

A workable rubric:

- **3–5 dimensions maximum**, each independently scorable.
- **Anchored levels** — describe what a 1, 3, and 5 look like concretely, with examples.
- **Blind scoring** — the scorer should not know which version produced the output. Knowing
  produces a consistent bias toward the new version.
- **Same scorer or same procedure** across both versions.

Anchors matter more than the scale. "Quality: 1–5" without anchors produces scores that drift
between sessions and cannot be compared across time.

Where an automated judge is used, validate it once against human judgment on a sample. An unvalidated
judge measures its own preferences, which may be uncorrelated with what matters.

---

## 4. A/B protocol

For changes that reach real users or real tasks:

- **Randomize assignment**, and check the groups are comparable on the dimensions that matter.
- **Decide the sample size and duration in advance**, from the baseline rate and the smallest
  difference worth detecting.
- **Do not stop early because the result looks good.** Early peeking at a running test inflates
  false positives substantially — an early lead frequently reverses.
- **One change per test.** Two changes give an unattributable result.
- **Define the decision rule before starting:** what result leads to what action.
- **Run through a full cycle** — a week that omits the weekend, or a month that omits payday, is
  not representative.

Where volume is too low for a readable test, say so and make only the changes that do not require
statistical confirmation: clarity fixes, obvious defects, removing friction. Do not run an
underpowered test and report its result as a finding.

---

## 5. Regression detection

Aggregate improvement routinely conceals category failure. Check case by case, every time.

The comparison to make is a per-case matrix:

```text
                    new: pass    new: fail
baseline: pass         38            4      ← the 4 are regressions
baseline: fail          6            2      ← the 6 are gains
```

Net +2 looks like a modest improvement. Four things that used to work now do not, and if they
share a category — structured output, long inputs, a particular language — the change has broken a
capability rather than improved a metric.

**Always look at what the regressions have in common.** A pattern is a defect; scattered
regressions are more likely noise, and repeated runs will tell you which.

Regressions in control cases — the ones the change should not have touched — are the strongest
signal that something unintended happened.

---

## 6. Complexity accounting

Complexity is a real cost, paid continuously, and it is the cost most often left out of an
improvement claim.

Count what the change adds:

- components, services, or dependencies to maintain and update,
- new failure modes, and whether they fail loudly or silently,
- new configuration or state,
- new attack surface,
- knowledge required to debug it at 2am,
- reduced reversibility.

Then ask: **would this change be accepted if the gain were half as large?** If not, the gain is
marginal relative to the cost, and the honest answer is usually revert.

Complexity compounds. Ten changes each adding "just a little" produce a system nobody fully
understands, where the eleventh change is dangerous and the twelfth is impossible. This is why
within-variance changes are reverted rather than kept — each is individually harmless and
collectively fatal.

---

## 7. Evaluating skill routing

Routing accuracy is measured, not asserted.

Build a set of realistic prompts, labelled with the skill that should activate:

- **Should-trigger prompts (8–10 per skill)** — varied phrasing, formal and casual, including
  cases where the user never names the domain.
- **Should-not-trigger prompts (8–10)** — near-misses that share vocabulary but need a different
  skill. These are the valuable ones; obviously-unrelated prompts test nothing.

Run each several times — routing is non-deterministic — and record the trigger rate rather than a
single outcome.

```text
accuracy = (correct activations + correct non-activations) / total
```

Report both error types separately. Over-activation and under-activation have different causes and
different fixes: over-activation usually means the description lacks negative space;
under-activation usually means it lacks the user's vocabulary.

**Re-test neighbors after any description change.** Sharpening one skill's description reliably
shifts traffic to and from adjacent skills, and a fix for one can regress two others.

---

## 8. Postmortem structure

Written after a failure, aimed at the system rather than the person.

```text
INCIDENT:  <what happened>
IMPACT:    <who or what was affected, and for how long>
TIMELINE:  <detection → response → resolution, with times>

WHAT FAILED
  <the immediate technical or process cause>

WHY IT WAS NOT CAUGHT
  <the missing control — this is the important section>

WHY IT WAS NOT CAUGHT SOONER
  <detection gap>

CONTRIBUTING CONDITIONS
  <what made this failure possible or likely>

WHAT CHANGES
  <specific control, test, alert, or process change — each with an owner>

WHAT DOES NOT CHANGE
  <explicitly, so effort is not spent on unrelated hardening>

VERIFICATION
  <how we will know the change works — often a test that reproduces the failure>
```

The most valuable section is *why it was not caught*. The immediate cause is usually
uninteresting and unlikely to recur in the same form; the missing control is what allows the next,
different failure through.

Never name individuals as causes. "The deploy was not reviewed" is actionable; "X did not review
the deploy" produces defensiveness and worse reporting next time — which costs far more than the
original incident.
