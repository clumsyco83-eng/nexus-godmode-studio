# 🧠 Supermind Reasoning — Advanced Reference

Use this file only for genuinely difficult reasoning, strategy, architecture, or root-cause problems.

## 1. Representation Search

A difficult problem may become easy after changing its representation.

Try alternative representations:
- user journey,
- state machine,
- dependency graph,
- data flow,
- incentives,
- queue/flow system,
- constraint optimization,
- adversarial game,
- lifecycle,
- failure tree,
- economic unit model.

Do not force every representation. Pick the one that exposes the hidden structure.

## 2. Five-Layer Why

For an observed problem, distinguish:

1. visible symptom,
2. immediate mechanism,
3. upstream cause,
4. system condition allowing it,
5. incentive/process/architecture keeping it alive.

Fix at the lowest layer that is practical and justified.

## 3. Constraint Map

Classify constraints:

- physical/technical,
- platform/legal,
- business,
- time/budget,
- architecture,
- user behavior,
- assumed/conventional.

Challenge only assumed constraints.

## 4. Assumption Stress Test

For each material assumption ask:

- What if the opposite is true?
- What evidence would surprise us?
- Is this based on current evidence or habit?
- Can we test it cheaply?
- Is it reversible if wrong?

Prioritize assumptions by:
**impact if false × uncertainty**.

## 5. Causal vs Correlated

Before optimizing a metric or fixing a symptom:
- identify plausible confounders,
- inspect temporal order,
- seek mechanism,
- use experiments or counterfactual evidence where possible.

Do not call correlation root cause.

## 6. Decision Table

For major choices:

```text
Option | User value | Feasibility | Risk | Reversibility | Cost | Future leverage | Evidence
```

Weight only dimensions that matter.

## 7. Second-Order Review

For selected option:
- new dependencies,
- maintenance load,
- migration burden,
- abuse/failure modes,
- scaling economics,
- team/AI understandability,
- lock-in,
- future option value.

## 8. Reversibility

Separate:
- two-way doors — act quickly,
- one-way doors — research, architecture review, stronger verification.

## 9. Pre-Mortem Template

"Assume the project failed. The most likely reasons are..."

Rank 3–7 realistic failure modes.

For each:
- warning signal,
- prevention,
- fallback.

## 10. Anti-Overthinking Gate

Stop deeper reasoning when:
- decision is reversible,
- information value is low,
- experimentation is cheaper than analysis,
- one option clearly dominates,
- delay costs more than uncertainty.

Deep reasoning is not automatically better reasoning.

## 11. Output Discipline

Do not expose private chain-of-thought.

Return only:
- decision,
- concise rationale,
- material assumptions,
- evidence,
- trade-offs,
- remaining uncertainty.

## Research basis

This mode combines practical systems/decision reasoning with NEXUS Architecture and Engineering Intelligence.
Claude Code guidance favors fresh context, targeted exploration, and task-specific specialist routing rather
than accumulating every intermediate thought in one session.
