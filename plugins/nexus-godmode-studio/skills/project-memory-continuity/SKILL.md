---
name: project-memory-continuity
description: >
  Preserve high-signal project knowledge across Claude Code sessions, compaction, handoffs, branches,
  long-running work, and multiple agents without bloating context. Use when a project will continue
  beyond the current task, when Claude is resuming prior work, when architecture or product decisions
  must survive future sessions, or when repeated rediscovery is wasting tokens. Maintain compact,
  source-aware memory, checkpoints, decision records, current-state notes, and stale-memory cleanup.
---

# Project Memory / Continuity

## Mission

Act as the project's **institutional memory**.

Preserve the smallest set of durable facts that allows a future Claude Code session, human engineer,
or delegated agent to resume work correctly without rereading the entire repository or replaying old
conversations.

Memory must improve future decisions, not become a second codebase.

## Prime Rules

1. **Code and verified runtime behavior remain primary truth.**
2. Memory summarizes durable knowledge; it does not override current evidence.
3. Keep always-loaded memory small and high-signal.
4. Put detailed knowledge in topic files loaded only when needed.
5. Record decisions with rationale and reconsideration triggers.
6. Separate verified facts from assumptions, plans, and unresolved hypotheses.
7. Never persist secrets, credentials, private keys, access tokens, or sensitive personal data.
8. Delete or supersede stale memory instead of endlessly appending.
9. Preserve branch/worktree context when concurrent work exists.
10. Optimize continuity for both humans and AI agents.

## Memory Layers

Use the project's available memory mechanisms deliberately.

### Shared repository instructions
Use `CLAUDE.md` only for durable rules that should influence most work:
- canonical build/test commands,
- non-obvious conventions,
- critical architecture constraints,
- project-wide do/don't rules,
- durable environment quirks.

Do not turn `CLAUDE.md` into a project diary.

### Claude auto-memory
When available, use auto-memory for compact project-specific learnings, corrections, preferences,
and recurring gotchas. Keep the index concise and point to topic files for details.

### Project continuity notes
For long-running projects, prefer a project-owned directory such as `.claude/project-memory/`,
`docs/project-memory/`, or the repository's existing documentation convention.

Recommended files:
- `CURRENT_STATE.md`
- `ARCHITECTURE_MAP.md`
- `DECISIONS.md`
- `GOTCHAS.md`
- `WORKSTREAMS.md`
- `HANDOFF.md`

Do not create all files if the project does not need them.

## What Deserves Memory

Persist information when it is:
- durable,
- non-obvious,
- costly to rediscover,
- likely to affect future work,
- supported by code, tests, docs, or an explicit user decision.

Good examples:
- architecture boundaries,
- source-of-truth locations,
- important public contracts,
- migration constraints,
- canonical commands,
- non-obvious environment setup,
- recurring failure causes,
- user-approved product decisions,
- known debt with remediation trigger,
- unfinished critical work,
- release blockers.

Bad examples:
- raw logs,
- temporary stack traces,
- speculative guesses,
- entire file contents,
- transient TODO chatter,
- one-off command output,
- facts easily discovered in seconds,
- superseded plans.

## Memory Write Protocol

Before writing memory:

1. Identify the fact or decision.
2. Classify it as:
   - VERIFIED FACT
   - DECISION
   - CONSTRAINT
   - GOTCHA
   - OPEN ISSUE
   - NEXT ACTION
3. Attach evidence or source where practical:
   - file/symbol,
   - test,
   - commit,
   - ADR,
   - explicit user decision.
4. State scope:
   - repository-wide,
   - subsystem,
   - environment,
   - branch/worktree.
5. Add a reconsideration trigger when the information can become stale.
6. Write the shortest version that preserves meaning.

## Current-State Checkpoint

For substantial sessions maintain a compact checkpoint:

- Mission / current objective
- Current branch or worktree
- Current phase
- Completed work
- Files/modules changed
- Important decisions
- Verification performed
- Known failures/blockers
- Uncommitted or risky state
- Next critical-path action

The checkpoint should be readable in under a minute.

## Resume Protocol

When resuming:

1. Read the compact checkpoint/index first.
2. Check git status, current branch/worktree, and recent delta.
3. Verify that remembered facts still match the repository.
4. Load only topic memory relevant to the current task.
5. Mark or repair stale memory immediately.
6. Continue from the next critical-path action.

Do not trust old memory blindly.

## Conflict Resolution

When memory conflicts with current evidence, use this order:

1. explicit current user instruction,
2. verified current code/runtime/test evidence,
3. current architecture decision record,
4. maintained repository documentation,
5. recent checkpoint,
6. older memory.

Record meaningful corrections so the same conflict does not recur.

## Decision Records

For important decisions record:

- Decision
- Context
- Why
- Alternatives considered
- Consequences
- Owner/source of decision
- Date or commit if useful
- Reconsider when

Do not create heavyweight ADRs for trivial choices.

## Branch / Worktree Awareness

Never merge continuity from independent branches as if all work is already integrated.

Track:
- branch/worktree,
- base commit when important,
- files owned by the workstream,
- whether changes are merged,
- pending conflicts or dependencies.

A future session must be able to tell **what is real in main** versus **what only exists in a branch**.

## Memory Hygiene

Periodically:
- remove duplicate notes,
- collapse repeated gotchas,
- mark superseded decisions,
- delete obsolete setup instructions,
- archive completed workstreams,
- keep indexes short,
- verify linked files still exist.

Memory quality matters more than memory volume.

## Compaction Resilience

Before a long session is compacted or handed off, preserve:
- mission,
- modified files,
- exact unresolved error,
- important decisions,
- tests already run,
- external blockers,
- next step.

Do not rely on conversational history as the only storage for critical project state.

## Handoff Standard

A handoff must allow another competent engineer or agent to answer:

- What are we building?
- What is currently true?
- What changed?
- What is verified?
- What remains?
- What should I not accidentally undo?
- What is the next best action?

If those cannot be answered, continuity is incomplete.

## Coordination

### Godmode
Godmode owns mission progress. This skill preserves durable execution state.

### Principal Architecture
Persist architecture constitution, invariants, ADRs, evolution stage, and major debt.

### Token Optimizer
Load memory progressively. Never pull the full archive into context when one topic file is enough.

### Engineering Intelligence
Use repository evidence to validate or correct memory.

For advanced schemas, stale-memory rules, auto-memory guidance, and handoff templates, read
[references/REFERENCE.md](references/REFERENCE.md).

## Final Standard

**Remember less, but remember the right things accurately.**
