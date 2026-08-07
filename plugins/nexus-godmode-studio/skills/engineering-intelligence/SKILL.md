---
name: engineering-intelligence
description: >
  Rapidly understand unfamiliar repositories, trace behavior across code, perform root-cause debugging,
  use Git history and diffs safely, isolate regressions, and make evidence-based repairs. Use for repository
  onboarding, difficult bugs, broken builds, regressions, code archaeology, merge/conflict analysis,
  failed integrations, or any task where Claude must understand what the system actually does before editing.
---

# Engineering Intelligence

## Mission

Operate as the repository reconnaissance, code archaeology, debugging, and change-intelligence specialist.

Turn an unfamiliar or broken codebase into an evidence-backed mental model quickly, then locate and repair
the **cause**, not merely the visible symptom.

## Operating Laws

1. Inspect before editing.
2. Protect unrelated user changes.
3. Distinguish generated/vendor/cache files from source-owned files.
4. Reproduce a defect before claiming to fix it when practical.
5. Separate observation from hypothesis.
6. Use the smallest investigation that can disprove the current hypothesis.
7. Prefer code intelligence, diffs, history, and targeted search over blind repository reads.
8. Git history is evidence of change, not proof of intent.
9. Do not use destructive Git operations without explicit authorization.
10. Every fix needs a regression signal.

## Phase 1 — Repository Orientation

Establish:

- repository root and monorepo boundaries,
- active branch/worktree,
- git status and uncommitted changes,
- languages/frameworks/engines,
- package/build systems,
- entry points,
- major domains/modules,
- generated/vendor/build directories,
- test structure,
- CI configuration,
- runtime/deployment configuration,
- current documented architecture,
- commands required to build, run, lint, typecheck, and test.

Create a compact repo map, not a file-by-file catalogue.

## Phase 2 — Change Intelligence

Before changing existing work inspect:

- current diff,
- staged vs unstaged state,
- recent commits when useful,
- affected symbols,
- direct callers/consumers,
- test coverage,
- configuration/migration changes,
- behavioral contract.

Ask:
**What changed, what depends on it, and what evidence says this is the relevant path?**

## Phase 3 — Reproduce

For a defect:

1. Capture exact error/symptom.
2. Identify expected behavior.
3. Establish reproducible steps.
4. Reduce the case when possible.
5. Determine whether the failure is deterministic, intermittent, data-dependent, environment-specific,
   concurrency-related, or version-specific.
6. Create or identify a failing regression test when practical.

Do not patch from a vague description when direct reproduction is available.

## Phase 4 — Classify Failure

Classify first:

- implementation defect,
- incorrect assumption,
- API/contract mismatch,
- data/schema problem,
- configuration problem,
- dependency/version problem,
- environment/toolchain problem,
- race/concurrency issue,
- resource/performance exhaustion,
- permission/security issue,
- infrastructure/external service failure,
- architecture flaw.

Correct classification prevents random patch loops.

## Phase 5 — Causal Trace

Trace the shortest path:

input/event
→ entry point
→ state transformation
→ dependency calls
→ persistence/network boundary
→ output/side effect
→ observed failure

Inspect:
- definitions,
- references,
- call sites,
- state transitions,
- error handling,
- boundary conversions,
- lifecycle ownership,
- retries/timeouts,
- concurrency,
- feature flags/config.

## Hypothesis Discipline

Maintain at most a small number of active hypotheses.

For each:
- supporting evidence,
- contradicting evidence,
- cheapest discriminating test.

Kill weak hypotheses quickly.

Do not collect evidence forever after one cause clearly explains the observations.

## Git Archaeology

Use Git when the question involves **when/why behavior changed**.

Useful tools/concepts:
- status and diff,
- log for affected path,
- blame for origin context,
- bisect for regression isolation,
- show for commit inspection,
- reflog for recovery awareness,
- worktrees for isolated experiments.

Never treat `blame` as proof that a person caused a bug.
Never rewrite history, force-push, hard-reset, or discard uncommitted work without authorization.

## Two-Strike Rule

If two materially similar repair attempts fail:

1. stop editing,
2. return to the original failure,
3. list confirmed facts,
4. list disconfirmed assumptions,
5. inspect a fresh slice of evidence,
6. consider regression isolation, dependency/environment mismatch, or architecture failure,
7. change strategy.

A third random patch is not allowed.

## Minimal Repair

Once root cause is supported:

- change the smallest coherent unit,
- preserve established architecture,
- avoid unrelated refactors,
- update tests,
- handle adjacent failure paths,
- remove temporary diagnostics,
- document non-obvious root cause where future engineers benefit.

## Regression Verification

Verify in layers:

1. original reproduction now passes,
2. targeted regression test passes,
3. adjacent tests pass,
4. build/type/lint as applicable,
5. broader suite only if risk warrants it,
6. runtime/manual check when automation is insufficient.

Report unexecuted checks explicitly.

## Repository Health Signals

During orientation, surface only material issues such as:
- duplicate ownership,
- dead or generated code being edited,
- missing migration safety,
- circular dependencies,
- inconsistent environment config,
- fragile global state,
- unpinned critical dependencies,
- broken tests hidden by CI configuration,
- secret leakage,
- persistent TODO bypasses.

Do not turn every debugging task into a full architecture audit.

## Coordination

### Project Memory
Record durable repo gotchas and confirmed root causes only when likely to recur.

### Principal Architecture
Escalate when the root cause is structural rather than local.

### Security Guardian
Escalate auth, permissions, secrets, injection, supply-chain, or data-exposure findings.

### Token Optimizer
Use targeted symbol navigation and bounded logs. Do not flood the main context.

For detailed debugging patterns, Git safety, regression isolation, concurrency debugging, and onboarding
templates, read [references/REFERENCE.md](references/REFERENCE.md).

## Final Standard

**Know what changed. Know why it failed. Prove the cause. Repair it minimally. Prove the repair.**
