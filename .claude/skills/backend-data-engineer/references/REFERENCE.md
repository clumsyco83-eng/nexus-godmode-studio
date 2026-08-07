# Backend & Data Engineer — Advanced Reference

## 1. Relational Data Invariants

Prefer constraints when the database can enforce the truth reliably:
- primary keys,
- foreign keys,
- NOT NULL,
- UNIQUE,
- CHECK.

Application-only validation is vulnerable to race conditions and bypass paths.

## 2. PostgreSQL Row-Level Security

RLS can restrict rows per role/user.

Important gotchas:
- table owners normally bypass RLS unless forced,
- roles with `BYPASSRLS` bypass policies,
- no policy after RLS enablement becomes default-deny,
- permissive policies combine with OR; restrictive policies with AND,
- referential-integrity checks can have subtle information implications,
- backups must not silently omit rows because of policy context.

Always test policies with real non-owner roles.

Reference:
https://www.postgresql.org/docs/current/ddl-rowsecurity.html

## 3. Index Strategy

PostgreSQL supports B-tree, hash, GiST, SP-GiST, GIN, BRIN, expression, partial, multicolumn, unique,
and covering/index-only patterns.

Choose indexes from query shapes, not from columns that "seem important."

Validate with `EXPLAIN` / `EXPLAIN ANALYZE` where safe.

Reference:
https://www.postgresql.org/docs/current/indexes.html

## 4. Pagination

Prefer stable deterministic ordering.

### Offset
Simple but increasingly expensive and unstable under concurrent inserts/deletes.

### Cursor/keyset
Prefer for large/high-churn collections.
Cursor should encode the ordered key(s), not arbitrary client state.

Always define tie-break ordering.

## 5. Idempotency Pattern

For external request with idempotency key:

1. validate actor and payload,
2. claim key within transactional scope,
3. if completed key exists, return previous result,
4. perform operation exactly once logically,
5. store result/state,
6. commit,
7. retries return same logical outcome.

Scope keys by actor/resource where appropriate.

## 6. Transactional Outbox

When a DB change and event publication must be atomic:

1. perform business mutation,
2. insert outbox event in same transaction,
3. commit,
4. publisher reads unsent outbox events,
5. publish,
6. mark/record delivery,
7. consumers remain idempotent.

Do not assume the broker and database share a transaction.

## 7. Webhook Processing

Webhook handler should:
- verify authenticity/signature,
- reject stale/invalid requests when protocol supports it,
- record event ID,
- deduplicate,
- enqueue/transactionally process,
- return promptly,
- tolerate retries/out-of-order events,
- verify critical state from trusted provider where needed.

Never grant irreversible entitlement from an unverified webhook body.

## 8. Zero-Downtime Migration

Use expand/contract:

### Expand
Add nullable/new column/table/index compatible with old code.

### Backfill
Chunk, checkpoint, observe, and make resumable.

### Switch
Deploy code that uses new path while old remains compatible.

### Contract
Remove old column/path only after all clients/jobs no longer depend on it.

Avoid combining incompatible schema and application switch in one irreversible deployment.

## 9. Backfills

Good backfills:
- bounded batches,
- deterministic ordering,
- resumable cursor,
- rate limiting,
- progress metrics,
- idempotency,
- dead-letter/error record,
- ability to pause.

Do not run an unbounded production rewrite from a web request.

## 10. Cache Gotchas

Avoid:
- cross-tenant keys,
- indefinite stale authorization decisions,
- cache invalidation that depends on best-effort events only,
- stampedes,
- caching errors forever,
- using cache to hide slow unsafe queries.

When cache fails, define whether system falls back, degrades, or refuses the operation.

## 11. Queue Semantics

Assume at-least-once delivery unless you can prove stronger semantics end-to-end.

Consumer:
- dedupe,
- transactionally record processing where needed,
- tolerate redelivery,
- use bounded retries,
- dead-letter poison messages,
- expose age/depth.

## 12. API Resource Consumption

Public APIs need limits around:
- request body size,
- upload size,
- pagination size,
- query complexity,
- batch count,
- CPU-intensive work,
- outbound paid operations,
- concurrency,
- timeout.

OWASP API4:2023 treats unbounded resource use as both availability and cost risk.

## 13. External API Consumption

Treat downstream data as untrusted:
- validate schema,
- verify TLS/auth,
- apply timeout,
- cap response size,
- handle retry/backoff,
- sanitize before persistence/rendering,
- avoid blindly following redirect/user URLs,
- observe dependency health.

## 14. Twelve-Factor Principles

Useful backend defaults:
- explicit dependencies,
- config separated from code,
- build/release/run separation,
- disposable processes,
- dev/prod parity,
- logs as event streams.

Adapt to modern platforms rather than applying dogmatically.

References:
- https://www.12factor.net/
- https://www.12factor.net/config
- https://www.12factor.net/logs

## 15. Backup / Restore

A backup strategy is incomplete until restore is tested.

Record:
- what is backed up,
- frequency,
- encryption,
- retention,
- restore procedure,
- RPO/RTO,
- dependencies/secrets needed to restore,
- verification after restore.

## 16. Research Basis

Primary sources:
- https://www.postgresql.org/docs/current/
- https://owasp.org/API-Security/editions/2023/en/0x11-t10/
- https://www.12factor.net/
- https://opentelemetry.io/docs/
