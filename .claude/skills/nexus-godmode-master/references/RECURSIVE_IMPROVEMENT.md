# 🔁 Recursive Improvement — Advanced Reference

## 1. Evaluator–Optimizer Pattern

Anthropic describes an evaluator–optimizer workflow where one model/result is evaluated and feedback drives
another improvement pass. It is most useful when evaluation criteria are clear and iteration produces
demonstrable improvement.

Source:
https://www.anthropic.com/engineering/building-effective-agents

NEXUS adapts this into:

**Produce → Measure → Critique → Improve → Re-measure → Stop**

## 2. Improvement Target

Each cycle needs exactly one primary target, such as:
- correctness,
- latency,
- readability,
- conversion clarity,
- UX friction,
- security,
- test coverage,
- originality,
- maintainability.

Trying to improve everything simultaneously makes causality unclear.

## 3. Baseline

Before improving, capture a baseline:
- failing/passing tests,
- latency,
- bundle size,
- issue count,
- rubric score,
- screenshot,
- task success rate,
- user-flow steps.

Without a baseline, "better" is often subjective.

## 4. Delta Requirement

A cycle must state:

- previous state,
- change,
- new evidence,
- measurable/observable improvement,
- any regression.

If no meaningful delta exists, stop.

## 5. Pareto Pass

Prioritize the few changes likely to create most value.

Do not spend the final 80% of effort on the last 2% of cosmetic polish unless the product context truly demands it.

## 6. Regression Envelope

Every improvement must preserve:
- previously passing acceptance tests,
- architecture invariants,
- security properties,
- user constraints.

If it breaks them, revert or redesign.

## 7. Local Maximum Escape

If two cycles yield minimal gain:
- stop tuning the same solution,
- reconsider the problem framing or solution family,
- return to Supermind or High Wizard only if the expected value justifies it.

Do not endlessly micro-optimize a weak foundation.

## 8. Improvement Memory

Persist only durable lessons:
- recurring failure pattern,
- validated architecture gotcha,
- stable test/eval improvement.

Do not persist:
- temporary scores,
- every rejected wording,
- raw reviewer chatter.

## 9. Default Cycle Budget

- 0 — trivial/mechanical
- 1 — standard
- 2 — important
- 3 — master/high-stakes

Beyond 3 requires a blocker or explicit user request.

## 10. Termination Test

Ask:

**If we stop now, is there a material user/business/technical reason the result is not ready?**

If no, finish.
