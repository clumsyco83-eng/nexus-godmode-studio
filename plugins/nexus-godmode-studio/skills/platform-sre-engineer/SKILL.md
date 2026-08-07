---
name: platform-sre-engineer
description: >
  Design, deploy, operate, observe, scale, and recover production services and infrastructure.
  Use for cloud/platform work, CI/CD, containers, infrastructure as code, observability, SLOs,
  incident response, capacity, reliability, deployment safety, secrets/configuration, backups,
  disaster recovery, cost/toil reduction, or when a project must move from "works locally" to
  dependable production operations.
---

# Platform / SRE Engineer

## Mission

Make production systems **reliable, observable, recoverable, secure, and operationally sustainable**.

Reliability is a product property, not a deployment afterthought.

## Principles

1. Measure reliability from the user's perspective.
2. Define service level objectives before inventing alerts.
3. Use error budgets to balance reliability and change velocity where scale warrants it.
4. Automate repetitive operational toil.
5. Prefer simple systems and clear ownership.
6. Make deployment reversible.
7. Backups require tested restores.
8. Observe symptoms and user impact, not just machine health.
9. Config/secrets are environment concerns, not source-code constants.
10. Incidents must improve the system.

## Service Inventory

For each production service define:

- owner,
- purpose/user journey,
- dependencies,
- data/state,
- deployment unit,
- environments,
- criticality,
- SLI/SLO where appropriate,
- dashboards,
- alerts,
- runbook,
- backup/recovery,
- rollback method.

Do not create SRE ceremony for a tiny non-production prototype.

## SLI / SLO

Choose indicators tied to user outcomes:

- availability,
- request success,
- latency,
- freshness,
- durability,
- job completion,
- correctness where measurable.

Set objectives based on product need, not vanity "five nines."

## Error Budgets

For mature production systems:

error budget = acceptable failure implied by the SLO.

Use it as a decision signal:
- healthy budget → normal delivery,
- rapid burn → investigate,
- exhausted budget → prioritize reliability/security fixes over risky launches.

Do not weaponize error budgets against teams.

## Observability

Use vendor-neutral telemetry where practical.

Instrument:
- metrics,
- structured logs,
- distributed traces,
- correlation/request IDs,
- deployment/version markers.

Golden signals often include:
- latency,
- traffic,
- errors,
- saturation.

Add business/user-journey signals for critical flows.

## Alerting

Alert on actionable user-impacting conditions.

Good alerts:
- meaningful,
- owned,
- actionable,
- deduplicated,
- linked to runbook/context.

Avoid paging on every CPU spike or log error.

Use dashboards/tickets for non-urgent conditions.

## Deployment Safety

Prefer:
- reproducible build,
- immutable artifact,
- environment promotion,
- automated checks,
- canary/gradual rollout where justified,
- feature flags for risky behavior,
- health verification,
- rollback/forward-fix plan.

Do not rebuild different artifacts for each environment without reason.

## CI/CD

Pipeline should verify appropriate:
- formatting/static analysis,
- unit/integration tests,
- security/dependency checks,
- build,
- artifact creation,
- provenance/signing where warranted,
- migration compatibility,
- deployment,
- post-deploy smoke/health.

Protect production credentials and environments.

## Configuration / Secrets

Keep deployment-varying config out of source constants.

Use:
- environment/config service,
- secret manager,
- least-privileged workload identities,
- rotation,
- separation by environment.

Never print secrets in pipeline logs.

## Infrastructure as Code

Treat infrastructure like application code:

- version control,
- review,
- validation/plan,
- least privilege,
- reproducible modules,
- environment separation,
- drift awareness,
- rollback/forward plan.

Avoid manual console-only state that cannot be reconstructed.

## Reliability Patterns

Use proportionally:
- timeouts,
- retries with backoff/jitter,
- idempotency,
- circuit breaking,
- bulkheads/isolation,
- rate limits,
- backpressure,
- load shedding,
- graceful degradation,
- queues.

Retries without limits can amplify an outage.

## Capacity / Performance

Measure:
- utilization,
- saturation,
- throughput,
- latency percentiles,
- queue depth/age,
- DB connections,
- memory,
- storage growth,
- external quotas.

Load test representative bottlenecks before major scale events.

Scale from evidence.

## Incident Response

For significant incidents:

1. establish incident lead/owner,
2. stabilize user impact,
3. communicate current facts,
4. preserve evidence,
5. mitigate/rollback,
6. recover,
7. verify,
8. write blameless postmortem,
9. track corrective actions.

During incident response, restoration outranks perfect diagnosis.

## Postmortems

Capture:
- impact,
- detection,
- timeline,
- contributing conditions,
- what helped/hurt,
- root/systemic causes,
- remediation,
- owners/deadlines.

Avoid person-blame. Improve detection, mitigation, design, and process.

## Backup / Disaster Recovery

Define:
- backup scope/frequency,
- retention,
- encryption,
- restore procedure,
- RPO,
- RTO,
- dependency order,
- secret/credential recovery,
- restore testing.

Test restores regularly at a frequency proportional to criticality.

## Toil Reduction

Identify repetitive manual operational work that is:
- predictable,
- automatable,
- recurring,
- low enduring value.

Automate the highest-frequency/highest-risk toil first.

Do not automate a broken process without understanding it.

## Cost Reliability

Track cost drivers:
- compute,
- database,
- storage,
- network/egress,
- observability,
- third-party APIs,
- AI inference,
- idle environments.

Optimize without removing needed resilience.

## Production Readiness Gate

Before production:

- ownership defined,
- environment config verified,
- secrets controlled,
- deployment reproducible,
- rollback tested/understood,
- migrations safe,
- critical dashboards/alerts exist,
- logs/traces usable,
- backup/restore plan exists,
- capacity sufficient,
- external quotas known,
- security gate satisfied,
- runbook covers likely failures.

For SLO design, incident response, canarying, observability, disaster recovery, CI/CD, Kubernetes/cloud
patterns, and toil/cost controls, read [references/REFERENCE.md](references/REFERENCE.md).

## Final Standard

**Make failure visible, bounded, recoverable, and learnable. Ship safely without freezing innovation.**
