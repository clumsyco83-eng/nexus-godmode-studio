# Security Guardian — Advanced Reference

## 1. OWASP Top 10:2025 Coverage

Explicitly consider when relevant:

- A01 Broken Access Control
- A02 Security Misconfiguration
- A03 Software Supply Chain Failures
- A04 Cryptographic Failures
- A05 Injection
- A06 Insecure Design
- A07 Authentication Failures
- A08 Software or Data Integrity Failures
- A09 Security Logging & Alerting Failures
- A10 Mishandling of Exceptional Conditions

Do not treat these as the complete threat model.

## 2. ASVS-Oriented Areas

For web/API applications consider:
- encoding/sanitization,
- validation/business logic,
- frontend security,
- API/web-service security,
- file handling,
- authentication,
- session management,
- authorization,
- tokens,
- OAuth/OIDC,
- cryptography,
- secure communication,
- configuration,
- data protection,
- secure architecture,
- logging/error handling.

Select assurance depth according to system risk.

## 3. API Security Questions

For every ID-bearing endpoint:
- Is object authorization checked server-side?
- Can fields be over-posted or over-returned?
- Can a lower role call an admin function?
- Are expensive operations bounded?
- Can a bot abuse a business flow?
- Can supplied URLs cause SSRF?
- Are deprecated/hidden API versions still reachable?
- Are downstream API responses validated?

## 4. Multi-Tenant Systems

Verify:
- tenant ID is derived from trusted identity/context, not only request data,
- every query is tenant-scoped,
- background jobs preserve tenant context,
- caches include tenant separation,
- object storage paths/policies isolate tenants,
- analytics/admin tools respect scope,
- support impersonation is controlled and audited.

PostgreSQL RLS can provide defense in depth, but policies must be tested and owner/bypass behavior understood.

## 5. Secret Scanning

Search defensively for:
- API key formats,
- private key blocks,
- tokens,
- passwords in config,
- connection strings,
- signed URLs,
- credentials in tests/fixtures,
- secrets in mobile/web build configs.

If a real secret is found:
1. avoid repeating it,
2. identify exposure scope,
3. recommend rotation/revocation,
4. remove from history only with an authorized plan,
5. add prevention controls.

## 6. Dependency Review

Assess:
- direct and transitive dependencies,
- version pinning,
- maintainer activity,
- critical CVEs/advisories,
- install/build scripts,
- compromised/deprecated package risk,
- unexpected ownership changes,
- binary provenance,
- CI action references.

A vulnerability is material when it is reachable and relevant, not merely present in an unused dev package.

## 7. CI/CD Security

Check:
- least-privilege tokens,
- protected environments,
- branch protections,
- untrusted PR secret access,
- pinned third-party actions,
- immutable artifacts,
- promotion vs rebuild,
- signing/provenance where justified,
- approval gates for production,
- audit logs.

## 8. File Upload

Verify:
- size limits,
- content-type and signature validation,
- safe generated filenames,
- storage outside executable paths,
- malware scanning where risk warrants,
- image/document parser safety,
- decompression limits,
- authorization for read/write/delete,
- no path traversal.

## 9. SSRF / Outbound Requests

For user-controlled URLs:
- prefer allowlisted destinations,
- block metadata/internal ranges,
- validate redirects,
- enforce schemes,
- resolve DNS carefully,
- set timeouts/size limits,
- isolate credentials,
- treat response as untrusted.

## 10. Logging and Error Handling

Errors returned to clients should be useful but not leak:
- stack traces,
- SQL,
- file paths,
- secret values,
- internal service topology.

Internally preserve correlation IDs and structured diagnostic context.

## 11. Security Tests

High-value tests:
- unauthorized object access,
- role escalation attempts,
- tenant crossover,
- token expiry/revocation,
- replay/idempotency,
- malformed input,
- rate/resource limits,
- dependency failure fail-closed behavior,
- sensitive log redaction,
- secret absence in client bundle.

## 12. Severity Calibration

Consider:
- exploitability,
- required privileges,
- exposure,
- affected users/data,
- persistence,
- blast radius,
- compensating controls,
- detectability,
- business consequence.

Suggested qualitative levels:
- Critical — systemic compromise, broad auth bypass, destructive/high-value exposure.
- High — serious reachable breach with limited preconditions.
- Medium — meaningful weakness requiring constraints/preconditions.
- Low — limited impact/hard-to-exploit weakness.
- Informational — hardening/visibility issue.

## 13. AI / Agent Security Boundary

When AI is present, additionally review:
- prompt injection crossing into privileged tools,
- untrusted retrieved content,
- tool allowlists,
- data exfiltration paths,
- approval for destructive actions,
- model output validation before execution,
- secret exposure to model/tool context,
- indirect prompt injection from web/files,
- tenant isolation in retrieval/memory.

Coordinate detailed AI reliability with AI Systems Engineer.

## 14. Research Basis

Primary references:
- https://owasp.org/Top10/
- https://owasp.org/API-Security/editions/2023/en/0x11-t10/
- https://cornucopia.owasp.org/taxonomy/asvs-5.0
- https://csrc.nist.gov/pubs/sp/800/218/final
- https://csrc.nist.gov/projects/ssdf

OWASP Top 10:2025 specifically elevates software supply-chain failures and exceptional-condition handling,
so this skill treats both as first-class review areas.
