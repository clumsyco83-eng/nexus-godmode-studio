# 🛡 Verification — Advanced Reference

## 1. Independent Reviewer Pattern

For important changes, use a fresh-context reviewer/subagent.

Provide:
- requirement/acceptance criteria,
- final diff/artifact,
- architecture constraints,
- verification already performed.

Do not provide long implementation debates unless needed.

Reviewer asks:
- Does it actually satisfy requirements?
- What breaks?
- What is unverified?
- What security/data risk exists?
- Is the implementation overfit to tests?
- Did scope drift?

Anthropic specifically recommends fresh subagents for unbiased review and verification before committing.

Source:
https://claude.com/blog/subagents-in-claude-code

## 2. Falsification Matrix

```text
Property | Happy path | Invalid input | Dependency failure | Retry/concurrency | Old data/client | Abuse case
```

Use only applicable columns.

## 3. Verification Pyramid

Prefer cheap deterministic evidence first:

1. schema/static/type/lint,
2. unit/property tests,
3. integration/contract tests,
4. end-to-end/runtime checks,
5. visual/device/manual validation,
6. reviewer judgment.

Do not use an expensive e2e test for something a unit test proves better.

## 4. Requirement Traceability

For complex tasks maintain:

```text
Requirement | Implementation location | Test/evidence | Status
```

This prevents features that are coded but unreachable/unverified.

## 5. Adversarial Review

A reviewer should try to find:
- negative paths,
- omitted states,
- error handling gaps,
- race/retry flaws,
- security boundary violations,
- compatibility issues,
- silent data corruption,
- accidental scope expansion.

Do not invent findings to satisfy the instruction.

## 6. False-Positive Filter

Before blocking:
- reproduce/trace the issue,
- confirm relevant execution path,
- check compensating controls,
- calibrate severity.

High-signal review beats maximum issue count.

## 7. Visual Verification

For UI/game work check:
- target viewport/device,
- loading/empty/error/disabled states,
- safe areas,
- accessibility,
- focus/touch,
- animation completion/interruption,
- screenshots/reference comparison when useful.

## 8. Production Verification

Local pass is not deployment proof.

Where applicable verify:
- environment config,
- migrations,
- artifact/version,
- secrets/identity,
- health/readiness,
- telemetry,
- rollback,
- store/platform constraints.

## 9. Eval-Driven Agent Verification

For AI/agent systems:
- build representative eval tasks,
- use code/model/human graders as appropriate,
- maintain past failures as regression cases,
- evaluate outcome, not only transcript style.

Source:
https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents

## 10. Stop Review

Stop when:
- no blockers remain,
- material findings are resolved or explicitly accepted,
- remaining feedback is optional,
- evidence satisfies acceptance criteria.

Review must not become an infinite style contest.
