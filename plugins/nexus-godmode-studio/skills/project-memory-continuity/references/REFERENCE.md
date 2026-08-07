# Project Memory / Continuity — Advanced Reference

## 1. Recommended Directory

Use an existing project documentation convention when available. Otherwise:

```text
.claude/project-memory/
├── INDEX.md
├── CURRENT_STATE.md
├── ARCHITECTURE_MAP.md
├── DECISIONS.md
├── GOTCHAS.md
├── WORKSTREAMS.md
└── HANDOFF.md
```

Only create files that add value.

`INDEX.md` should remain extremely small and tell Claude which topic file to read for which need.

## 2. Memory Record Schema

Use a compact structure:

```markdown
### <short title>
Type: FACT | DECISION | CONSTRAINT | GOTCHA | ISSUE
Scope: <repo/subsystem/env/branch>
Status: ACTIVE | SUPERSEDED | NEEDS-RECHECK
Evidence: <file:symbol / test / commit / explicit user decision>
Reconsider when: <trigger, if applicable>

<1-5 sentences>
```

Avoid prose journals.

## 3. Staleness Classes

### Stable
Architecture invariant, canonical command, durable product decision.
Recheck only when related systems change.

### Conditional
Provider behavior, package/version behavior, environment configuration.
Recheck when dependency/version/environment changes.

### Volatile
Current incident, temporary branch state, deployment status.
Keep in `CURRENT_STATE.md`, not permanent memory.

### Expired
No longer useful or contradicted.
Delete or mark superseded.

## 4. Evidence Strength

Prefer:
1. passing/failing automated test,
2. current source code,
3. reproducible runtime behavior,
4. official project configuration,
5. explicit user/owner decision,
6. maintained docs,
7. previous memory,
8. hypothesis.

Never upgrade a hypothesis into a fact merely because it was repeated.

## 5. Auto-Memory Guidance

Claude Code supports project-specific auto-memory. Use it for:
- recurring corrections,
- non-obvious preferences,
- patterns that should survive sessions,
- pointers to deeper project notes.

Keep the always-loaded memory index concise. When detailed knowledge grows, link to topic files rather
than placing everything in the auto-loaded file.

Do not store:
- secrets,
- private credentials,
- raw logs,
- huge pasted code,
- volatile status,
- information that belongs in version-controlled project docs.

## 6. CLAUDE.md Guidance

`CLAUDE.md` is team-facing instruction, not chronological memory.

Add a rule when:
- Claude repeatedly makes the same mistake,
- the rule applies across many tasks,
- the rule is difficult to infer from code,
- violating it is costly.

Do not add:
- temporary task state,
- one-off bug notes,
- every directory description,
- generic coding advice Claude already knows.

## 7. Architecture Map Format

Keep it compact:

```markdown
# Architecture Map

## Entry points
- API: ...
- App: ...
- Worker: ...

## Domains
- Accounts — owns ...
- Billing — owns ...
- Recommendations — owns ...

## Critical contracts
- ...

## Data ownership
- ...

## External systems
- ...

## Invariants
- ...
```

Point to real files rather than duplicating implementation.

## 8. Decision Log Format

```markdown
## ADR-012 — Use transactional outbox for payment events
Status: Accepted
Context: ...
Decision: ...
Why: ...
Alternatives: ...
Consequences: ...
Reconsider when: event volume or infrastructure model changes materially.
```

## 9. Gotchas Format

The highest-signal memory often consists of project-specific gotchas.

Good:
- "`subscriptions.created_at` is not entitlement order; use `version`."
- "Staging webhook UI can show 200 before downstream processing; verify `payment_events`."
- "Generated API clients live under `src/generated`; edit the schema, never generated files."

Bad:
- "Be careful."
- "Write good tests."
- "Use clean code."

## 10. Workstream Ledger

For parallel work:

```markdown
| Workstream | Branch/worktree | Owner | Scope | Status | Depends on |
|---|---|---|---|---|---|
| auth-refresh | feat/auth-refresh | agent-a | auth client | in progress | none |
```

Remove completed entries after merge.

## 11. Handoff Template

```markdown
# Handoff

## Mission
...

## Verified current state
...

## Changes made
- ...

## Verification
- command → result

## Known issues
- ...

## Do not undo
- ...

## External blockers
- ...

## Next action
1. ...
```

## 12. Memory Audit

When continuity becomes confusing:

1. enumerate memory files,
2. find duplicates/contradictions,
3. compare against current code and git,
4. mark stale items,
5. collapse repeated notes,
6. update index,
7. ensure current state is branch-aware,
8. remove anything that does not change future decisions.

## 13. Security and Privacy

Never persist:
- API keys,
- passwords,
- auth cookies,
- private signing material,
- secret environment values,
- production tokens,
- sensitive user records.

Record **where a secret is configured**, not its value.

## 14. Research Basis

This skill incorporates current Claude Code guidance that:
- skills should use progressive disclosure,
- project `CLAUDE.md` should capture durable team rules,
- auto-memory can preserve project-specific learnings,
- a notes directory can improve project continuity.

Primary references:
- https://claude.com/blog/lessons-from-building-claude-code-how-we-use-skills
- https://support.claude.com/en/articles/14554000-claude-code-power-user-tips
