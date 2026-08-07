# Token Optimizer v2 — Advanced Reference

Read only the sections relevant to the active task.

## 1. Claude Code Context Economics

Treat the context window as a finite working-memory budget. Every conversation turn, file read, tool
result, invoked skill, and agent result can increase future processing cost.

High-impact practices:
- clear unrelated workstreams rather than carrying stale context,
- compact only when continuity is valuable,
- preserve exact modified files, decisions, tests, and failures during compaction,
- avoid repeatedly invoking large overlapping skills,
- keep permanent project instructions concise,
- use project memory/topic files for durable knowledge.

A clean session with a precise checkpoint can outperform a long session filled with failed approaches.

## 2. Prompt Cache Awareness

Stable repeated prefixes can benefit from prompt caching. Avoid gratuitously rewriting or reordering
persistent instructions during normal work.

Do not optimize for cache behavior at the expense of correctness, but avoid:
- constantly editing `CLAUDE.md` with temporary state,
- repeatedly injecting changing timestamps/status into global instructions,
- changing tool configuration for no reason,
- shuffling large stable instruction blocks.

Keep volatile project status in checkpoints or topic memory instead.

## 3. CLAUDE.md vs Skills vs Memory

Use the right storage layer.

### CLAUDE.md
Use for broadly applicable, non-obvious rules that should influence nearly every task:
- build/test commands,
- unusual code conventions,
- repository etiquette,
- critical environment quirks,
- durable architectural constraints.

Aim to keep it concise; move detailed workflow instructions elsewhere.

### Skills
Use for conditional procedures and specialist knowledge. Skills load on demand, but once invoked their
content stays in the session, so avoid invoking irrelevant skills.

### Auto/Project Memory
Use for compact durable learnings and continuity. Keep the startup index short and move detailed notes
into topic files loaded only when needed.

## 4. CLI vs MCP

When a mature CLI and an MCP tool can accomplish the same task with similar reliability, prefer the CLI
when it produces smaller, controllable output and avoids unnecessary tool-schema/context overhead.

Examples:
- `gh` for GitHub,
- cloud CLIs for focused infrastructure queries,
- project-native scripts for tests/builds.

Use MCP when it provides capabilities, structured access, authentication, or integrations that the CLI
cannot provide effectively.

Never disable or reconfigure user MCP servers without permission merely to save tokens.

## 5. MCP Hygiene

When MCP is used:
- call only the relevant server/tool,
- request the smallest useful result,
- avoid broad "list everything" calls,
- disable unused servers only when the user wants configuration optimization,
- keep MCP-derived context out of the main thread when a focused subagent can summarize it.

## 6. Code Intelligence First

When language-server/code-intelligence navigation is available, prefer:
- go to definition,
- find references,
- symbol search,
- type/error diagnostics,

over broad text search followed by reading multiple candidate files.

Text search remains appropriate for:
- strings,
- configuration,
- generated patterns,
- untyped/dynamic relationships,
- cross-language searches.

## 7. Preprocessing Verbose Data

Do not feed huge raw logs, test output, generated JSON, or external responses into the main context when
a deterministic preprocessing step can isolate the relevant data.

Useful preprocessing:
- grep/filter error lines,
- extract failed test names,
- parse JSON fields,
- summarize counts,
- select relevant time windows,
- cap repetitive stack traces,
- de-duplicate identical failures.

Preserve raw data outside context so it remains available if the filtered view is insufficient.

Hooks are useful when the same deterministic filtering must happen every time. Do not install hooks
silently; propose or configure them only within the user's permission model.

## 8. Subagent Routing

Subagents are valuable because they isolate noisy exploration in a separate context.

Use them for:
- unfamiliar subsystem exploration,
- large documentation research,
- verbose test/log analysis,
- independent verification,
- security review.

Do not use them when:
- the answer is already in the main context,
- the lookup is tiny,
- coordination overhead exceeds the saved context.

For economical subagents:
- give a narrow question,
- restrict tools to what is needed,
- set a turn limit where appropriate,
- use lower-cost models/effort for simple research when available,
- request a compact evidence-backed return.

## 9. Agent Team Economy

Agent teams multiply token use because each teammate has a separate context.

Use a team only when:
- tasks are genuinely independent,
- parallel execution materially reduces delivery time,
- the work is large enough to justify coordination,
- file/state collisions can be avoided.

Avoid teams for sequential tasks, small changes, or work requiring constant shared context.

Shut down completed workers and keep spawn prompts focused.

## 10. Worktree / Isolation Economy

For risky parallel experiments, isolated worktrees can prevent edit collisions and reduce expensive
recovery. Use them when independence is real.

Do not create worktrees for trivial single-threaded edits.

## 11. Model and Effort Routing

Match capability to difficulty.

- lightweight/low effort: mechanical extraction, simple searches, repetitive checks,
- normal coding model/medium effort: most implementation and debugging,
- strongest model/high effort: architecture, security, complex migrations, ambiguous root cause.

Do not use an expensive model simply because it is available.
Do not downgrade a task where reasoning quality materially affects risk.

## 12. Testing Output Strategy

Start with the smallest test that can falsify the change.

Preferred sequence:
1. focused unit/component test,
2. affected package/module tests,
3. integration/build,
4. full suite if required.

For large suites:
- capture the full output externally,
- return only failures and a bounded amount of surrounding context first,
- expand only when the failure requires it.

## 13. Two-Strike Context Reset Rule

If two materially similar correction attempts fail:
1. stop patching,
2. record confirmed facts,
3. record failed hypotheses,
4. inspect the original error again,
5. use a fresh subagent or clean session/workstream if available,
6. reformulate the task from evidence.

The purpose is not to erase learning; it is to stop carrying contradictory failed reasoning.

## 14. Context Value Scoring

For expensive context operations, assess:

- Relevance: will this directly influence the next decision?
- Novelty: is it information not already known?
- Reliability: is this source more trustworthy than the current assumption?
- Actionability: can it change implementation or verification?
- Size: how much context will it consume?

High relevance + novelty + actionability justifies the cost.
Large low-novelty reads do not.

## 15. Token Optimization Audit

When auditing a workflow, inspect:
- size of always-loaded CLAUDE.md/rules,
- number and size of invoked skills,
- repeated file reads,
- large Bash/test outputs,
- MCP usage,
- number/model/effort of subagents,
- agent teams,
- long mixed-purpose sessions,
- repeated broad searches,
- cache-breaking volatile instructions,
- over-large memory indexes.

Prioritize the largest recurring source first.

## 16. Never Claim Invisible Savings

Token use depends on model, context, caching, tool behavior, session length, and Claude Code version.

Say:
- "this should reduce context waste,"
- "this targets a major source of repeated input,"
- "measure with usage/context diagnostics."

Do not invent exact savings.
