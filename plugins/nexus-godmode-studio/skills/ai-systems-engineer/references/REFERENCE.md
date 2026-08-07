# AI Systems Engineer — Advanced Reference

## 1. Agent Complexity Ladder

Escalate only when needed:

1. deterministic code / search / rules,
2. one model call,
3. model + structured output,
4. model + retrieval,
5. model + tools,
6. single agent loop,
7. orchestrated multi-agent system.

Every step adds operational and evaluation complexity.

## 2. Eval-Driven Development

Define capability tasks before implementation when practical.

Each eval should include:
- input,
- environment/tools,
- expected property/outcome,
- grader,
- pass threshold.

Useful grader families:
- exact/regex/schema checks,
- unit/integration tests,
- static analysis,
- outcome state verification,
- rubric/model grader,
- human review.

Anthropic recommends treating agent evals as an ongoing development discipline, not a one-time benchmark.

Reference:
https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents

## 3. Tool Ergonomics

Anthropic's tool guidance emphasizes:
- implementing the right tools, not every possible tool,
- clear namespacing,
- meaningful context returned to the agent,
- token-efficient responses,
- high-quality descriptions/specs.

Reference:
https://www.anthropic.com/engineering/writing-tools-for-agents

## 4. Structured Outputs

Use strict schema adherence when provider supports it.

Schema should:
- model only necessary fields,
- use enums where domain is closed,
- distinguish nullable vs optional,
- include stable identifiers,
- avoid free-form blobs when downstream logic depends on them.

Still validate business rules after schema validation.

Reference:
https://openai.com/index/introducing-structured-outputs-in-the-api/

## 5. Agent Run Budget

Define:
- max model turns,
- max tool calls,
- max wall-clock duration where platform supports it,
- token/cost ceiling,
- recursion depth,
- retry count.

When exceeded:
- return partial status,
- checkpoint,
- escalate/handoff,
- do not loop forever.

## 6. Tool Side-Effect Classes

### Read-only
Search, fetch, inspect.

### Reversible write
Draft, create branch, write temporary file.

### Consequential write
Send message, modify production data, deploy.

### Irreversible/high-impact
Delete production data, spend money, legal submission.

Increase confirmation and verification with consequence.

## 7. RAG Evaluation

Evaluate separately:

### Ingestion
Did the right content enter the corpus?

### Retrieval
Did the correct chunks appear in top-k?

### Context construction
Was useful evidence preserved within budget?

### Generation
Did answer use evidence correctly?

### Attribution
Are citations/provenance accurate?

A generation failure and retrieval failure require different fixes.

## 8. Retrieval Security

For multi-user systems:
- apply ACL/tenant filters before or during retrieval,
- never retrieve broad data then ask the model to hide unauthorized parts,
- honor deletion/retention,
- separate public/private corpora,
- avoid embedding secret values without a lifecycle policy.

## 9. Memory Taxonomy

### Ephemeral
Current agent scratch state. Discard after run.

### Session
Conversation continuity.

### Durable user/project
Explicit long-term facts/preferences/decisions with update/delete rules.

### Knowledge
Documents/databases queried as source material.

Do not mix them.

## 10. Prompt Injection Defense

Use layered controls:
- maintain policy outside retrieved text,
- delimit untrusted content,
- prohibit untrusted content from granting permissions,
- constrain tools,
- validate arguments,
- require approval for high-impact actions,
- filter sensitive data from tool responses,
- log tool decisions.

No prompt is a perfect security boundary.

## 11. Provider Independence

Separate:
- product capability interface,
- provider adapter,
- model configuration,
- prompt templates,
- eval thresholds.

Avoid lowest-common-denominator abstractions that block useful provider features.

Make replacement possible where vendor risk/cost justifies it.

## 12. Model Routing

Example:
- lightweight model → extraction/classification,
- mid model → normal reasoning/tool workflows,
- strongest model → complex planning, high ambiguity, architecture.

Route using measured quality, not assumptions.

## 13. Fallback Design

Fallback can be:
- retry same model for transient error,
- switch provider/model,
- deterministic fallback,
- cached previous result,
- defer to queue,
- ask human,
- fail safely.

Do not silently downgrade high-risk decisions to a weak model.

## 14. Online Monitoring

Track:
- task success proxy,
- user corrections,
- refusal/safety rate,
- tool failure,
- fallback rate,
- latency percentile,
- cost distribution,
- hallucination/unsupported-claim reports,
- retrieval miss rate.

Use sampled human review for dimensions automation cannot measure reliably.

## 15. Multi-Agent Patterns

Use only when justified.

### Manager-worker
One orchestrator delegates specialized bounded tasks.

### Handoff
Agent transfers ownership to another specialist.

### Parallel reviewers
Independent agents inspect the same artifact for different properties.

### Debate/consensus
Expensive; use only when evaluated to improve outcomes.

Start simple.

OpenAI's practical agent guide similarly recommends maximizing a single agent before unnecessary multi-agent complexity.

Reference:
https://openai.com/business/guides-and-resources/a-practical-guide-to-building-ai-agents/

## 16. Agent Observability

Capture trace spans for:
- model request,
- retrieval,
- each tool,
- handoff,
- guardrail,
- final outcome.

OpenTelemetry provides vendor-neutral traces, metrics, and logs:
https://opentelemetry.io/docs/

## 17. Research Basis

Primary sources:
- https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents
- https://www.anthropic.com/engineering/writing-tools-for-agents
- https://openai.com/business/guides-and-resources/a-practical-guide-to-building-ai-agents/
- https://openai.com/index/new-tools-for-building-agents/
- https://openai.com/index/introducing-structured-outputs-in-the-api/
- https://opentelemetry.io/docs/
