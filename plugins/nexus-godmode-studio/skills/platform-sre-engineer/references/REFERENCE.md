# Platform / SRE Engineer — Advanced Reference

## 1. SLI Examples

### HTTP service
- successful eligible requests / eligible requests
- latency under threshold / eligible requests

### Async pipeline
- records processed correctly within freshness window / expected records

### Mobile backend
- user-critical API journeys succeeding within latency target

Prefer user-centered measures over server-only uptime.

## 2. SLO Design

Set SLOs that:
- reflect user expectation,
- are measurable,
- leave room for necessary change,
- distinguish critical from noncritical interactions.

100% is rarely a useful default.

Google SRE emphasizes user-focused SLOs and error budgets:
https://sre.google/resources/practices-and-processes/art-of-slos/

## 3. Error Budget Policy

Use error budgets to choose when reliability work must take priority.

A mature policy can define:
- measurement window,
- burn thresholds,
- release freeze conditions,
- exceptions for urgent security/critical fixes,
- postmortem triggers.

Reference:
https://sre.google/workbook/error-budget-policy/

## 4. Alert Quality

Page only when:
- user impact is material or imminent,
- human action is required now,
- action can improve outcome.

For everything else use:
- dashboard,
- ticket,
- trend report.

Alert fatigue is a reliability defect.

## 5. Observability

OpenTelemetry is a vendor-neutral standard for:
- traces,
- metrics,
- logs.

Use it where it reduces lock-in and improves cross-service correlation.

Reference:
https://opentelemetry.io/docs/

## 6. Deployment Patterns

### Rolling
Simple; partial mixed-version state must be compatible.

### Canary
Send small traffic share to new version, compare key signals, then expand.

### Blue/green
Maintain old/new environments, switch traffic; higher resource cost but fast rollback.

### Feature flag
Separate deploy from feature exposure.

Choose based on blast radius and system economics.

## 7. Migration Deployment

Database changes must coordinate with application rollout.

Prefer:
- backward-compatible expand,
- deploy mixed-version-safe code,
- backfill,
- switch reads/writes,
- contract later.

Never depend on instant fleet/client upgrade.

## 8. Retry Budget

For each dependency define:
- timeout,
- retryable error classes,
- max attempts,
- backoff,
- jitter,
- overall deadline,
- idempotency requirement.

Layered retries across services can multiply traffic dramatically.

## 9. Overload

When saturated:
- reject/defer low-priority work,
- queue with limits,
- shed load,
- protect critical paths,
- apply concurrency limits,
- prevent retry storms.

Capacity scaling is not the only overload control.

## 10. Incident Roles

At larger incidents separate:
- incident commander,
- operations/mitigation lead,
- communications,
- subject-matter responders.

At small scale one person can hold multiple roles, but ownership must be clear.

Google incident guidance:
https://sre.google/resources/practices-and-processes/incident-management-guide/

## 11. Blameless Postmortem

Look beyond "who changed the code."

Ask:
- why did system allow the change to cause impact?
- why did detection take this long?
- why was rollback difficult?
- what dependency made blast radius large?
- what guardrail/test/automation was missing?

## 12. Toil

Google defines toil as repetitive, predictable service-maintenance work.

Automate where recurring manual work consumes engineering time without creating durable value.

Reference:
https://sre.google/workbook/eliminating-toil/

## 13. Dev / Prod Parity

Keep development/staging/production similar enough to catch environment-specific failures without making
local development impractical.

Reference:
https://www.12factor.net/dev-prod-parity

## 14. Build / Release / Run

Separate:
- build artifact,
- release configuration,
- runtime.

Promote the same artifact between environments where practical.

## 15. Supply-Chain / Artifact Security

For serious production environments consider:
- pinned dependencies/actions,
- artifact provenance,
- immutable artifacts,
- signing,
- SBOM,
- protected build identities,
- environment-scoped secrets.

OWASP 2025 and NIST SSDF both treat build/supply-chain security as first-class.

References:
- https://owasp.org/Top10/2025/A03_2025-Software_Supply_Chain_Failures/
- https://csrc.nist.gov/pubs/sp/800/218/final

## 16. Disaster Recovery Test

A DR exercise should validate:
- backups are actually restorable,
- operators know sequence,
- dependencies/secrets are recoverable,
- DNS/traffic switch works if relevant,
- application passes integrity checks after restore,
- RPO/RTO are realistic.

## 17. Production Readiness Review

For a critical service ask:
- Who owns it?
- What breaks if it fails?
- How do we know users are impacted?
- How do we roll back?
- How do we restore data?
- What are dependency quotas?
- What is the scaling limit?
- What is the most likely operational toil?
- Are alerts actionable?

## 18. Research Basis

Primary sources:
- https://sre.google/workbook/table-of-contents/
- https://sre.google/sre-book/service-best-practices/
- https://sre.google/workbook/error-budget-policy/
- https://sre.google/resources/practices-and-processes/incident-management-guide/
- https://sre.google/workbook/eliminating-toil/
- https://opentelemetry.io/docs/
- https://www.12factor.net/
