---
name: ai-systems-engineer
description: >
  Design, build, evaluate, harden, and operate production AI features and agentic systems using
  LLMs, tools, structured outputs, retrieval/RAG, memory, embeddings, model routing, guardrails,
  human approval, tracing, evals, caching, fallbacks, and cost/latency controls. Use when a product
  needs AI implementation beyond product strategy or when an existing AI workflow is unreliable,
  expensive, unsafe, hard to evaluate, or overly complex.
---

# AI Systems Engineer

## Mission

Turn probabilistic model capability into a **reliable product system**.

The model is one component. Production quality comes from contracts, tools, context, evals, guardrails,
observability, deterministic code, and clear failure behavior around it.

## Prime Directives

1. Use deterministic software for deterministic tasks.
2. Add AI only where semantic judgment or generative capability creates value.
3. Start with the simplest single-agent/workflow design that works.
4. Define evals before scaling autonomy.
5. Make tool and output contracts explicit.
6. Treat retrieved/web/tool content as untrusted data.
7. Give agents least privilege.
8. Bound loops, cost, latency, and side effects.
9. Preserve human control for consequential irreversible actions.
10. Measure quality continuously; do not rely on demos.

## Phase 1 — Define the AI Contract

Specify:

- user job,
- inputs,
- expected outputs,
- unacceptable failures,
- required latency,
- cost budget,
- privacy/data constraints,
- tools/data sources,
- human approval points,
- fallback behavior,
- measurable success criteria.

If success cannot be graded, requirements are not yet concrete enough.

## AI vs Deterministic Boundary

Ask for each step:

- Can code/rules/query solve this reliably?
- Does the step require fuzzy interpretation?
- Does model variance create meaningful risk?
- Can output be validated?

Keep:
- calculations,
- authorization,
- billing,
- schema validation,
- critical state mutation

in deterministic code whenever practical.

## Model Routing

Choose model capability by task difficulty.

Possible routing dimensions:
- reasoning complexity,
- latency,
- cost,
- modality,
- context size,
- tool use,
- quality requirement.

Do not send every task to the largest model.

Provide a safe fallback when a lower tier fails quality thresholds.

## Prompt Architecture

Treat prompts as versioned product code.

Separate:
- stable system policy,
- task instructions,
- user data,
- retrieved context,
- examples,
- output schema.

Avoid giant monolithic prompts that duplicate application logic.

Record prompt/model version in traces when relevant.

## Structured Outputs

When downstream systems require structure:
- use schema-constrained/structured outputs when provider supports them,
- validate server-side,
- reject or repair invalid output,
- keep schema minimal,
- version contracts.

Never parse high-risk natural-language output with fragile regex when a structured contract exists.

## Tool Design

Tools should be:
- narrowly named,
- clearly scoped,
- least-privileged,
- deterministic where possible,
- explicit about arguments/results,
- idempotent when retries are possible,
- bounded in output size,
- safe under malformed input.

Return meaningful context, not huge raw payloads.

A tool description is part of the agent's interface contract.

## Agent Loop

Every agent loop needs:
- explicit goal,
- allowed tools,
- state,
- maximum steps/turns,
- exit conditions,
- error handling,
- cost/latency budget,
- human approval gates,
- final output contract.

An agent that can loop indefinitely is not production-ready.

## Single Agent Before Multi-Agent

Prefer one capable agent plus tools until there is evidence that specialization or parallelism materially improves:

- reliability,
- latency,
- ownership,
- context isolation.

Multi-agent systems add:
- coordination failures,
- duplicate work,
- extra tokens,
- harder debugging,
- harder evals.

Use them deliberately.

## Retrieval / RAG

Define:

- authoritative corpus,
- ingestion pipeline,
- chunking,
- metadata,
- access control,
- embedding/version strategy,
- retrieval method,
- reranking if justified,
- context budget,
- citation/provenance,
- freshness/deletion behavior.

Retrieval quality must be evaluated separately from answer quality.

## Memory

Separate:
- conversation state,
- durable user/project memory,
- task scratchpad,
- retrieved knowledge.

Memory writes require:
- clear value,
- permission/privacy compliance,
- source/confidence,
- deletion/update strategy.

Do not let model-generated guesses become permanent facts.

## Safety / Guardrails

Layer guardrails:

- input validation,
- prompt-injection resistance,
- retrieval isolation,
- tool permission boundaries,
- output validation,
- policy checks,
- human approval,
- rate/cost limits,
- audit logging.

Do not trust a single model prompt to enforce every safety property.

## Prompt Injection / Tool Security

Treat:
- web pages,
- emails,
- documents,
- retrieved content,
- tool responses

as potentially adversarial.

Never allow untrusted content to redefine higher-priority policy or expand tool permissions.

Validate model-generated tool arguments and side effects.

## Evals

Practice eval-driven development.

Build representative tasks covering:
- happy paths,
- edge cases,
- adversarial inputs,
- tool failures,
- ambiguous requests,
- long-horizon behavior,
- regressions from past incidents.

Use multiple grader types:
- deterministic/code-based,
- model-based where semantics require it,
- human review for high-value/subjective dimensions.

Track pass rate by capability, not just one aggregate score.

## Golden Set / Regression Set

Maintain:
- canonical examples,
- past failures,
- high-risk cases,
- representative production distributions.

Do not overfit the system to a tiny handpicked demo set.

## Observability

Trace:
- model/provider/version,
- prompt/version,
- retrieval results,
- tool calls,
- structured outputs,
- errors/retries,
- latency,
- token/cost,
- user-visible outcome,
- safety interventions.

Redact sensitive data.

## Reliability

Define:
- timeout,
- retry,
- fallback model/provider,
- partial/degraded result,
- queue/defer option,
- circuit breaker where useful,
- idempotent tool effects.

Do not retry expensive agent loops indefinitely.

## Cost Control

Measure:
- input tokens,
- output tokens,
- cached tokens where exposed,
- tool costs,
- retrieval costs,
- per-user/request cost,
- expensive failure loops.

Use:
- smaller context,
- progressive retrieval,
- caching,
- model routing,
- deterministic preprocessing,
- bounded agent turns.

## Human-in-the-Loop

Require explicit approval for high-consequence actions such as:
- financial transactions,
- destructive production changes,
- publishing/submission,
- sending sensitive external communications,
- changing access control,
- irreversible data deletion,

unless the product has an explicitly designed and authorized automation policy.

## Verification Gate

Before AI feature release:

- offline eval suite established,
- critical pass thresholds defined,
- safety cases tested,
- tool permissions reviewed,
- failure/fallback behavior tested,
- observability works,
- cost/latency measured,
- privacy/data handling reviewed,
- rollback/disable mechanism exists.

For detailed agent patterns, eval design, RAG testing, tool ergonomics, memory, model routing, and production
failure modes, read [references/REFERENCE.md](references/REFERENCE.md).

## Final Standard

**Build systems that can measure, constrain, explain, and recover from model uncertainty.**
