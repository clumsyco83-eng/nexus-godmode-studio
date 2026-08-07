# Godmode v2 — Advanced Orchestration Reference

Read only the sections relevant to the current mission.

## 1. Orchestration Is Not Maximum Activity

Godmode should optimize for successful delivery, not number of agents, tools, edits, or tokens used.

A strong orchestrator:
- reduces uncertainty before expensive execution,
- chooses one clear critical path,
- delegates only where isolation or independence helps,
- integrates results,
- establishes verification before declaring completion.

Do not confuse "full permission" with permission to bypass platform safeguards or irreversible human gates.

## 2. Mission Decomposition

For substantial work, decompose into:
- discovery,
- architecture,
- implementation units,
- integration,
- verification,
- release/handoff.

Build the smallest task graph that captures real dependencies.

Each node should have:
- input/precondition,
- deliverable,
- verification,
- dependency,
- owner,
- risk.

Do not split work so finely that coordination becomes more expensive than implementation.

## 3. Critical Path First

Prioritize tasks that unlock other work.

Defer:
- cosmetic polish that depends on unfinished structure,
- broad refactors that do not unlock the mission,
- optional optimizations before functionality is correct.

If a blocker sits on the critical path, focus recovery there instead of starting unrelated work.

## 4. Explore/Plan Depth

Use deeper plan mode when:
- requirements are ambiguous,
- multiple subsystems change,
- architecture is unfamiliar,
- rollback is difficult,
- migration/security risk is high.

Skip or shorten planning when:
- scope is obvious,
- the diff is small,
- verification is cheap,
- the change is easily reversible.

Planning itself has cost.

## 5. Verification-First Design

For important features, define how the work can fail before implementation.

Examples:
- reproduce a bug with a failing test,
- define API examples,
- identify visual reference screenshots,
- write migration invariants,
- identify security properties,
- set performance acceptance thresholds.

This closes the agentic loop because implementation can iterate against an observable signal.

## 6. Fresh-Context Review

The implementing agent is biased by its own reasoning and assumptions.

For high-risk or long work, use a fresh context to review:
- current diff,
- stated requirements,
- architecture constraints,
- tests/evidence.

Ask the reviewer to find:
- correctness gaps,
- missed requirements,
- security issues,
- unintended scope changes,
- material regression risk.

Tell the reviewer not to block on subjective style preferences.

## 7. Writer / Reviewer Pattern

Use:
- Writer: implements against acceptance criteria.
- Reviewer: sees the result/diff in fresh context.
- Writer: fixes validated findings.
- Reviewer: rechecks only affected areas.

Stop when material findings are resolved; do not create an infinite review loop.

## 8. Test-First Split Pattern

When requirements are clear and testability is strong:
- one agent/session can define tests/fixtures,
- another implements against them,
- independent review validates both.

This can reduce confirmation bias.

Do not use the pattern when tests themselves require unresolved architectural decisions.

## 9. Subagent Strategy

Subagents are ideal for self-contained work that would pollute the main context.

Good:
- "Find how auth refresh works and return relevant files and invariants."
- "Review this diff against PLAN.md for correctness gaps."
- "Analyze this 5,000-line log and return root-cause evidence."

Bad:
- "Understand the whole repository."
- "Do anything useful."
- tasks that require subagents to coordinate among themselves.

The parent orchestrator must provide a precise delegation message because subagents start with isolated context.

## 10. Agent Teams

Use teams when:
- there are several independent workstreams,
- coordination can be explicit,
- the workload is large enough to justify multiple contexts,
- integration boundaries are defined.

Avoid teams when:
- work is sequential,
- tasks edit the same files,
- one agent can complete the job efficiently,
- token budget is a priority.

Keep teams small and end workers when done.

## 11. Worktrees and Parallel Sessions

Use isolated git worktrees/sessions for:
- independent experiments,
- parallel implementation on separate modules,
- risky migrations,
- writer/reviewer flows requiring code separation.

Check for:
- merge conflicts,
- shared generated files,
- database/state conflicts,
- environment-port conflicts.

Isolation reduces accidental collisions but does not remove integration work.

## 12. Permission and Safety Model

Use available permission modes, allowlists, auto classifiers, and sandboxing rather than bypassing safety by default.

Never treat:
- user enthusiasm,
- "full permission",
- Godmode naming,

as permission for prohibited/destructive actions that still require explicit confirmation or platform authorization.

Prefer least privilege for delegated agents.

## 13. Architecture Escalation

Use Principal Architecture for:
- new service boundaries,
- data ownership,
- auth/security model,
- public APIs,
- persistence format,
- high-impact vendor choice,
- scalability strategy,
- migrations with long-term consequences.

Godmode can make routine implementation choices but should not casually override architectural invariants.

## 14. Reversible vs Irreversible Decisions

### Two-way doors
Proceed autonomously when within scope and convention.

### One-way doors
Increase scrutiny:
- articulate tradeoffs,
- identify rollback/migration,
- consult architecture,
- require stronger evidence,
- involve the user where consequences are business-level or destructive.

The goal is not indecision; it is proportional governance.

## 15. Failure Taxonomy

Classify failures:

### Implementation failure
Code does not meet known requirements.
Fix locally.

### Assumption failure
The mental model of the system is wrong.
Stop patching and re-explore.

### Environment failure
Toolchain, dependency, credentials, network, platform.
Separate from code defect.

### Architecture failure
The chosen boundary/model cannot satisfy requirements cleanly.
Escalate to architecture.

### External blocker
Approval, credential, payment, review, unavailable service.
Complete everything possible and surface exact blocker.

Correct classification prevents wasted loops.

## 16. Two-Strike Recovery

After two similar failed fixes:
- do not make a third near-identical patch,
- record observed facts,
- list disconfirmed hypotheses,
- restore or inspect known-good state if appropriate,
- use a fresh context for diagnosis,
- change strategy.

This rule prevents context from becoming an archive of contradictory attempts.

## 17. Checkpoints and Git

Claude Code conversational checkpoints are useful for rewinding agent edits, but not all external/Bash changes
are guaranteed to be captured. Git remains the durable source of code history.

Before risky work:
- inspect status,
- preserve user changes,
- avoid destructive resets,
- use commits/worktrees when appropriate.

Never overwrite unrelated uncommitted user work.

## 18. Deterministic Hooks

When an action must happen **every time**, advisory text may be insufficient.

Examples:
- run a formatter,
- block writes to protected paths,
- validate generated files,
- enforce a stop condition.

Hooks can provide deterministic enforcement.

Do not install/change hooks silently. Use them when the project/user wants deterministic automation.

## 19. Completion Evidence Ledger

For a major mission, keep a compact evidence table internally:

- requirement → evidence,
- test/build → result,
- reviewer finding → disposition,
- blocker → status.

This helps prevent "looks done" completion.

Evidence should be observable:
- exit code,
- test count,
- screenshot comparison,
- API response,
- diff,
- deployment status.

## 20. Adversarial Review Without Overengineering

Independent reviewers often find something because they are asked to find something.

Classify findings:
- **blocker** — violates requirement/security/correctness,
- **material** — meaningful maintainability/reliability risk,
- **optional** — style or speculative improvement.

Fix blockers and relevant material issues.
Do not keep expanding scope to satisfy optional reviewer preferences.

## 21. Release Gate

Before release-oriented completion, verify applicable:
- build artifacts,
- version/configuration,
- environment variables,
- migrations,
- secrets,
- signing,
- store/platform requirements,
- rollback/forward-fix plan,
- monitoring,
- known limitations.

Do not equate local success with production readiness.

## 22. Project Memory Handoff

At the end of long work, hand Project Memory/Continuity only durable state:

- mission/result,
- architecture decisions,
- changed areas,
- verified checks,
- unresolved known issues,
- important rejected approaches,
- next step.

Do not store the entire transcript.

## 23. Godmode + Token Optimizer

These skills should reinforce each other.

Godmode asks:
- what must happen next?

Token Optimizer asks:
- what is the least context/tool cost that can answer or complete it safely?

Godmode should not defeat Token Optimizer by loading every specialist or spawning unnecessary workers.

## 24. Godmode + Principal Architecture

Godmode owns execution sequencing and completion.
Principal Architecture owns structural integrity and long-term design.

If they conflict:
1. return to user requirements,
2. check architectural invariants,
3. evaluate risk/reversibility,
4. choose the simplest compliant path,
5. record major decisions,
6. continue execution.

## 25. Autonomy Standard

Autonomy means:
- making routine reversible decisions without interrupting the user,
- pursuing evidence,
- fixing failures methodically,
- completing all possible work before reporting a blocker.

Autonomy does **not** mean:
- inventing credentials,
- accepting legal terms,
- paying money,
- publishing/deleting production resources without required permission,
- bypassing security controls,
- claiming actions that did not occur.

## 26. Final Question Set

Before closing a major mission ask:

- Did we build the requested thing?
- Does the strongest available evidence show it works?
- Did we preserve architecture and user constraints?
- Did we introduce unexplained unrelated changes?
- Did we check the highest-risk failure modes?
- Is any blocker external and clearly described?
- Would a fresh reviewer agree the mission is done?
- Is the continuation state compact and usable?

If yes, finish. If not, act on the missing item.
