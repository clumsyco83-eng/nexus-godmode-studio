---
name: backend-data-engineer
description: >
  Design, implement, migrate, optimize, and verify production backend and data systems: APIs,
  relational databases, transactions, authorization enforcement, queues, caching, realtime,
  storage, background jobs, search, migrations, multi-tenancy, and backend observability.
  Use when application or game work requires a reliable server/data layer or when existing
  backend behavior, schemas, queries, migrations, or APIs need repair or scaling.
---

# Backend & Data Engineer

## Mission

Build backend systems that preserve **correctness, data integrity, security, operability, and future evolution**.

Prefer simple, boring, observable systems over unnecessary distributed complexity.

## First Principles

1. Define source of truth explicitly.
2. Put invariants as close to the data as practical.
3. Treat retries and duplicate delivery as normal.
4. Design migrations before data becomes large.
5. Authorization belongs server-side.
6. APIs are contracts, not implementation leaks.
7. Cache is not the source of truth unless intentionally designed.
8. Use transactions for atomic business invariants.
9. Measure queries before optimizing.
10. Every production backend needs failure behavior and observability.

## Phase 1 — Understand the Domain

Identify:

- actors/roles,
- core entities,
- ownership,
- lifecycle/state transitions,
- business invariants,
- read/write patterns,
- consistency needs,
- expected scale,
- latency needs,
- offline/sync needs,
- retention/privacy requirements,
- external integrations.

Do not design tables before understanding ownership and invariants.

## Data Model

For each entity define:
- stable identifier,
- owner/tenant,
- required vs optional fields,
- constraints,
- uniqueness,
- relationships,
- lifecycle/status,
- timestamps with clear semantics,
- retention/deletion,
- audit requirements.

Prefer database-enforced:
- NOT NULL,
- unique constraints,
- foreign keys,
- check constraints,

when they represent real invariants.

## Transactions and Concurrency

Use transactions to preserve multi-step invariants.

Consider:
- isolation level,
- lost updates,
- write skew,
- lock scope,
- deadlocks,
- retryable serialization failures,
- optimistic concurrency/version columns,
- idempotency keys.

Never assume "single request" means "single execution."

## API Contracts

Define:
- resource/action semantics,
- request/response schema,
- auth requirements,
- authorization,
- validation,
- status/error semantics,
- pagination,
- filtering/sorting,
- idempotency,
- rate/resource limits,
- retries/timeouts,
- versioning/deprecation.

Keep internal database representation separate from public API contracts.

## Authorization

For every write and protected read:
- authenticate actor,
- establish tenant/context,
- authorize action,
- authorize object,
- authorize sensitive fields,
- execute within trusted server boundary.

Use row-level security or equivalent as defense in depth when appropriate, not as a substitute for understanding policy.

## Idempotency

Critical operations such as:
- payments,
- subscriptions,
- order creation,
- reward grants,
- webhook processing,
- job execution

must have explicit duplicate/retry behavior.

Design an idempotency key or deduplication strategy before integrating retrying systems.

## Events / Queues / Background Jobs

Use asynchronous processing when:
- work is slow,
- retryable,
- decoupled,
- bursty,
- not required for immediate response.

Define:
- delivery semantics,
- idempotency,
- retry/backoff,
- dead-letter handling,
- ordering requirements,
- poison message behavior,
- visibility/monitoring.

For database + event consistency, consider transactional outbox or another explicit atomicity strategy.

## Caching

Cache only with a clear purpose:
- latency,
- load reduction,
- expensive computation.

Define:
- key,
- TTL,
- invalidation,
- consistency expectation,
- stampede protection,
- tenant isolation,
- fallback when cache is unavailable.

Do not cache correctness bugs.

## Realtime / Sync

For realtime systems define:
- event source,
- ordering,
- resume/reconnect,
- duplicate handling,
- authorization,
- stale state,
- presence semantics,
- backpressure,
- offline reconciliation.

## File / Object Storage

Define:
- ownership,
- secure upload,
- object naming,
- metadata,
- content validation,
- access control,
- signed URL lifetime,
- deletion,
- lifecycle/retention,
- CDN/cache interaction.

Avoid exposing storage provider credentials to clients.

## Migrations

Every schema/data migration must answer:

- Can old and new app versions coexist?
- Is the migration backward-compatible?
- What happens at production data volume?
- Can it lock a hot table?
- Is backfill resumable?
- How is progress observed?
- Can we roll back, or must we forward-fix?
- When can old columns/code be removed?

Prefer expand → migrate/backfill → switch → contract.

## Query Performance

Use real query plans and workload evidence.

Check:
- indexes aligned to filters/joins/order,
- cardinality/statistics,
- N+1 patterns,
- overfetching,
- missing pagination,
- large offset pagination,
- hot rows,
- lock contention,
- sequential scans where harmful.

Indexes improve reads but add write/storage cost; use them intentionally.

## Multi-Tenancy

Define:
- tenant identity,
- tenant-owned tables,
- global/shared tables,
- query scoping,
- RLS/policy,
- storage/cache keys,
- admin/support access,
- analytics boundaries,
- deletion/export.

Test cross-tenant access explicitly.

## Backend Reliability

Define:
- timeout budget,
- retry policy,
- circuit breaking where justified,
- graceful dependency degradation,
- request IDs,
- health/readiness,
- resource limits,
- rate limits,
- backpressure.

Do not retry non-idempotent operations blindly.

## Observability

Instrument:
- request rate,
- error rate,
- latency,
- queue depth/age,
- DB connection saturation,
- slow queries,
- cache effectiveness,
- external dependency failures,
- job retries/dead letters,
- business-critical state transitions.

Use traces/metrics/logs proportionally; preserve correlation.

## Verification

Before calling backend work complete:

- schema applies cleanly,
- migrations tested,
- constraints enforced,
- authz tests pass,
- API contract tests pass,
- duplicate/retry behavior tested,
- failure paths exercised,
- performance checked for material queries,
- backup/recovery implications considered,
- observability exists for critical flows.

For detailed patterns on PostgreSQL, migrations, queues, outbox, caching, pagination, multi-tenancy, backups,
and API failure design, read [references/REFERENCE.md](references/REFERENCE.md).

## Final Standard

**Correct data first. Explicit contracts. Safe retries. Observable failure. Scale only from evidence.**
