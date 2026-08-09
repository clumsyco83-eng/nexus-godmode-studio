---
name: token-optimizer-v2
description: >
  Minimize Claude Code token usage, context bloat, repeated reads, noisy tool output, and
  unnecessary agent work without reducing correctness. Use for coding, debugging, repository
  work, long sessions, large codebases, expensive MCP/tool workflows, or whenever context and
  usage efficiency matter. Apply narrow-first context loading, delta inspection, progressive
  disclosure, concise output, model/effort routing, session hygiene, and evidence-based verification.
---

# Token Optimizer v2

## Mission

Complete the requested work with the **lowest practical context and token cost** that still preserves correctness, security, maintainability, and meaningful verification.

Optimize information flow, not quality.

## Non-Negotiables

Never save tokens by:
- skipping required tests or security checks,
- guessing instead of inspecting necessary evidence,
- hiding failures,
- truncating the only useful diagnostic data,
- weakening user requirements,
- avoiding necessary architecture work,
- declaring success without verification.

## Core Operating Loop

For each task:

1. **Scope** — identify the exact outcome and keep unrelated work out.
2. **Budget** — choose low, medium, or high context/reasoning depth based on risk.
3. **Reuse** — use valid existing context, memory, checkpoints, and architecture maps first.
4. **Delta** — inspect changed files, diffs, errors, and modified symbols before whole files.
5. **Target** — search or navigate directly to the relevant symbol/section.
6. **Expand only on evidence** — widen context only when the current evidence is insufficient.
7. **Implement minimally** — make the smallest correct change consistent with project architecture.
8. **Verify efficiently** — targeted checks first; broader checks only when risk requires them.
9. **Checkpoint if needed** — preserve only durable state for continuation.
10. **Stop** — when the requested outcome is proven complete.

## Context Loading Ladder

Prefer this order:

1. Current valid task context.
2. Compact project memory/checkpoint.
3. Architecture map or relevant ADR.
4. `git diff`, changed files, failing output, or recent commits.
5. Code-intelligence/symbol navigation when available.
6. Targeted grep/search.
7. Relevant line range or small file section.
8. Full relevant file.
9. Immediate dependency/consumer.
10. Wider subsystem.
11. Repository-wide scan only when genuinely required.

Do not load unrelated code "just in case."

## Progressive Context Rules

- Start narrow and widen only after a concrete unanswered question appears.
- Read exact functions, components, routes, schemas, or configuration sections when possible.
- Do not reread unchanged files already understood unless new evidence makes the old understanding unreliable.
- Summarize large, stable files after first inspection rather than repeatedly loading them.
- Avoid generated output, build artifacts, vendor trees, lockfiles, large logs, and binaries unless directly relevant.

## Delta Mode

When continuing work, ask first: **what changed since the last known-good state?**

Prefer:
- `git status`,
- `git diff`,
- changed symbols,
- recent commits,
- new failures,
- newly modified configuration,
- user-requested deltas.

Treat unchanged, previously verified code as stable unless evidence suggests otherwise.

## No-Repeat Rule

Do not repeat a read, search, test, explanation, plan, or tool call unless at least one is true:

- the underlying state changed,
- the previous result was incomplete,
- verification requires repetition,
- a new hypothesis needs different evidence.

Repeated activity without new information is token waste.

## Tool Output Economy

Prefer high-signal outputs.

- Use targeted test commands before full suites.
- Ask tools for failures, summaries, exact fields, or bounded ranges where safe.
- Filter giant logs before bringing them into context.
- Preserve enough surrounding lines to diagnose root causes.
- Do not dump entire command outputs when only a small subset is relevant.
- Prefer machine-readable or concise CLI output when available.

For detailed policies on CLI, MCP, hooks, code intelligence, subagents, and teams, read
[references/REFERENCE.md](references/REFERENCE.md) only when those mechanisms are relevant.

## Skill Activation Budget

Skills remain in conversation context after invocation, so **do not load every available skill preemptively**.

Invoke another skill only when it materially changes how the current task should be handled.

Prefer:
- Token Optimizer + one active specialist,
- adding Principal Architecture only for structural decisions,
- adding security/release/testing specialists only when their domain is actually reached.

Avoid stacking overlapping skills with duplicate instructions.

## Project Instruction Hygiene

Keep always-loaded project instructions small.

- Put only broadly applicable, non-obvious rules in `CLAUDE.md`.
- Put conditional workflows and deep domain guidance in skills.
- Avoid file-by-file descriptions that Claude can discover cheaply.
- Keep volatile status out of permanent instructions.
- Prefer compact architecture maps and topic memory over monolithic context.

## Session Hygiene

One session should have one coherent workstream whenever practical.

When context becomes polluted:
- preserve the current goal, modified files, decisions, tests, and unresolved blocker,
- then use a clean context/session when possible rather than carrying unrelated history forever.

If the same issue has required **two failed correction cycles**, stop accumulating failed approaches. Reassess assumptions, checkpoint the durable facts, and use a cleaner investigation path.

When compaction is used, preserve at minimum:
- current goal,
- files changed,
- important decisions,
- exact failing checks,
- tests already run,
- remaining work.

## Memory / Continuity Discipline

Keep memory high-signal.

Persist:
- architecture decisions,
- stable commands,
- durable conventions,
- known non-obvious pitfalls,
- unresolved blockers,
- compact checkpoints.

Do not persist:
- transient logs,
- temporary hypotheses,
- superseded failures,
- obvious facts easily rediscovered from code,
- large copied file contents.

Use topic files for detailed knowledge rather than bloating startup memory.

## Token / Effort Budgeting

### Low
Use for:
- typo/copy changes,
- renames,
- small isolated fixes,
- obvious configuration edits.

Behavior:
- minimal exploration,
- no formal plan unless needed,
- targeted verification.

### Medium
Use for:
- normal features,
- multi-file fixes,
- refactors,
- integrations,
- ordinary debugging.

Behavior:
- brief plan,
- focused dependency inspection,
- targeted tests plus relevant integration check.

### High
Reserve for:
- architecture,
- security-sensitive changes,
- migrations,
- difficult root-cause debugging,
- multi-system changes,
- irreversible/high-blast-radius decisions.

Behavior:
- deeper evidence gathering,
- explicit risk analysis,
- stronger independent verification.

Use the cheapest adequate model/effort for delegated work when configuration permits. Do not downgrade work whose risk requires stronger reasoning.

## Subagent Economy

Use a subagent when the side task would otherwise flood the main context with:
- repository exploration,
- documentation research,
- large logs,
- broad test output,
- independent review.

Do **not** spawn a subagent for a tiny lookup that is cheaper to do directly.

A subagent should return:
- conclusion,
- supporting evidence,
- exact relevant files/symbols,
- unresolved uncertainty,
- no giant transcript unless requested.

Use agent teams only when parallel independence justifies their multiplied context cost.

## Verification Economy

Verification is mandatory but proportional.

Prefer:
1. syntax/type check for touched code,
2. targeted tests for changed behavior,
3. integration/build check when boundaries changed,
4. broader regression suite when risk or project policy requires it,
5. fresh-context review for high-risk or long autonomous changes.

Do not rerun broad suites repeatedly when nothing relevant changed.

## Context-Cost Decision Test

Before a large read, broad search, new skill, MCP tool, or subagent, ask internally:

**What specific uncertainty will this remove, and is that information worth the context cost?**

If there is no specific uncertainty, do not spend the context.

## Measurement Mode

When the user explicitly wants to optimize or compare usage:

- inspect Claude Code usage/context diagnostics when available,
- identify major contributors such as long context, large skill loads, MCP/tool results, agent work, or repeated reads,
- change one high-impact behavior at a time,
- compare results rather than claiming unmeasured savings.

Do not promise a fixed percentage reduction unless measured in that environment.

## Stop Conditions

Stop when:
- the requested outcome is implemented,
- necessary evidence has been gathered,
- proportional verification passes,
- no blocking issue remains,
- additional exploration has low expected value.

More context is not automatically better context.

## Behaviour Summary

**Narrow first. Reuse what is known. Inspect deltas. Load on demand. Delegate noise. Verify proportionally. Stop when proven done.**
