# Engineering Intelligence — Advanced Reference

## 1. Repository Map Template

```markdown
# Repository Map
Root:
Branch/worktree:
Primary stack:
Build:
Test:
Run:
Lint/typecheck:

## Entry points
- ...

## Domains/modules
- ...

## Persistence/external boundaries
- ...

## Generated/vendor paths — do not edit
- ...

## High-risk areas
- ...
```

Keep this concise and update only when useful.

## 2. Investigation Ladder

Use in order when appropriate:

1. exact failure output,
2. changed diff,
3. symbol definition/reference,
4. direct caller/consumer,
5. targeted test,
6. config/schema,
7. recent history,
8. dependency/version,
9. broader subsystem,
10. full repo only when necessary.

## 3. Root-Cause Proof

A root cause is stronger when:
- manipulating the suspected cause reliably changes the failure,
- the causal path explains every important symptom,
- the repair fixes the reproduction,
- regression coverage prevents recurrence,
- no contradictory evidence remains.

"Changing this line made it pass" alone can still be accidental.

## 4. Bisect Strategy

Use `git bisect` when:
- the bug is a regression,
- a known-good commit exists,
- a known-bad commit exists,
- the test can be automated or evaluated reliably.

Prefer an automated script returning pass/fail.
Beware commits that do not build; use skip thoughtfully.

Do not bisect if the failure depends primarily on external state that cannot be reproduced historically.

## 5. Blame Strategy

Use blame to learn:
- which commit introduced a line,
- nearby rationale,
- related changes.

Then inspect the commit and surrounding history.

Never use blame to assign fault to a person.

## 6. Safe Git Rules

Before experiments:
- inspect `git status`,
- understand user changes,
- avoid writing over unrelated modifications.

Do not perform without explicit permission:
- `git reset --hard`,
- destructive clean,
- force push,
- history rewrite,
- deleting user branches,
- dropping stashes,
- broad checkout that overwrites changes.

Prefer:
- new branch,
- worktree,
- narrow revert,
- patch backup,
- commit after intentional scope confirmation.

## 7. Merge Conflict Resolution

For each conflict:
1. understand both sides semantically,
2. identify current desired contract,
3. inspect tests/callers,
4. resolve behavior, not markers,
5. run focused verification,
6. check for silent config/schema conflict.

Never select "ours" or "theirs" globally merely to finish the merge.

## 8. Build Failure Triage

Classify:
- syntax/compile,
- type mismatch,
- missing generated artifact,
- dependency resolution,
- toolchain version,
- environment variable,
- platform SDK,
- linker/native dependency,
- code signing,
- resource path/case sensitivity,
- test-only failure.

Fix the earliest causal error, not every downstream error line.

## 9. Data Bug Triage

Check:
- source of truth,
- schema/version,
- migration state,
- null/default semantics,
- timezone/locale,
- ordering,
- idempotency,
- duplicate event processing,
- transaction boundaries,
- stale cache,
- eventual consistency.

## 10. Concurrency Bug Triage

Look for:
- unsynchronized shared state,
- check-then-act races,
- non-idempotent retries,
- lost updates,
- lock ordering,
- stale reads,
- async lifecycle cancellation,
- double callbacks,
- event handler leaks.

Prefer deterministic stress/repro tests where possible.

## 11. Intermittent Bug Strategy

Capture:
- timestamps,
- correlation/request IDs,
- environment,
- user/session,
- input shape,
- feature flags,
- dependency latency,
- concurrency,
- resource levels.

Do not "fix" intermittent bugs by merely adding sleep/retry unless the underlying contract justifies it.

## 12. Instrumentation Discipline

Temporary diagnostics should:
- answer a specific hypothesis,
- avoid sensitive data,
- include correlation context,
- be removed or converted to durable observability after resolution.

Avoid print-debugging everywhere.

## 13. Code Intelligence

When language-server/navigation support exists, prefer:
- go-to-definition,
- find references,
- callers/callees,
- type diagnostics,
- symbol search,

before broad text search.

Use grep/text search for:
- strings,
- config,
- dynamic frameworks,
- cross-language integration,
- generated references.

## 14. Fresh-Context Review

For complex repairs, a fresh reviewer should inspect:
- original reproduction,
- root-cause explanation,
- diff,
- new regression test,
- adjacent risk.

Ask the reviewer to challenge whether the fix is causal or merely suppressive.

## 15. Durable Gotchas

After a high-value investigation, Project Memory may record:
- non-obvious source of truth,
- misleading status code,
- generated-file rule,
- build ordering constraint,
- hidden test fixture behavior,
- environment mismatch.

Do not persist every bug ever fixed.

## 16. Research Basis

This workflow aligns with current Claude Code recommendations for:
- targeted context use,
- subagents/fresh contexts for noisy investigation,
- worktree isolation for independent work,
- compounding project knowledge through concise memory.

Primary references:
- https://claude.com/blog/lessons-from-building-claude-code-how-we-use-skills
- https://support.claude.com/en/articles/14554000-claude-code-power-user-tips
- https://git-scm.com/docs
