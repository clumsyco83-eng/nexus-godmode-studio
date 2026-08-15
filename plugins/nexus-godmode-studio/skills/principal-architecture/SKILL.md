---
name: principal-architecture
description: >
  Principal-level software and systems architecture guidance. Use before or during substantial
  application, game, platform, backend, AI, data, infrastructure, or repository work when
  long-term structure, scalability, maintainability, reliability, security, evolution,
  interoperability, or architectural governance matters. Design the simplest architecture
  appropriate for the current stage while preserving clean paths for future growth.
---

# Principal Architecture

## Mission

Design software that works today without making tomorrow unnecessarily harder.

Build the **simplest architecture appropriate for today** while preserving explicit paths for
safe evolution. Do not overengineer an early product, and do not create irreversible shortcuts
without understanding their cost.

The complete reviewed architecture playbook is preserved byte-for-byte in
[references/REFERENCE.md](references/REFERENCE.md). Load that reference when the bounded task
needs deeper guidance than this entry document.

## Architecture Responsibilities

Own structural decisions concerning:

- system and trust boundaries,
- domain/module ownership,
- APIs and contracts,
- data ownership and lifecycle,
- persistence and caching,
- authentication and authorization boundaries,
- integrations and vendor coupling,
- reliability and recovery,
- security and privacy,
- performance and scalability,
- release and deployment architecture,
- observability and testing architecture,
- AI/agent architecture,
- cost, operability, and long-term maintainability.

Architecture defines how the system should be structured. NEXUS owns task authority, execution
envelopes, approvals, budgets, safety controls, verification, and sequencing.

## 1. Understand Before Designing

Before proposing architecture determine:

- product objective and lifecycle stage,
- expected users and usage patterns,
- required platforms,
- existing codebase constraints,
- data sensitivity and compliance/privacy requirements,
- connectivity/offline requirements,
- external services,
- release/deployment environment,
- expected growth,
- team or agent development model,
- budget/cost constraints,
- non-functional requirements.

Do not design from technology preference alone.

## 2. Stage-Appropriate Architecture

### Prototype
Optimize for learning and speed while avoiding disposable chaos.

### MVP
Optimize for rapid delivery with clean internal boundaries and reversible choices.

### Production
Add proportional security, validation, backups, monitoring, stable environments, release safety,
tested migrations, and recovery procedures.

### Growth
Improve proven bottlenecks in queries, caching, queues, asynchronous work, analytics, platform
performance, service boundaries, and cost efficiency.

### Scale
Introduce stronger isolation, independent scaling, redundancy, regional strategy, and advanced
observability only when evidence requires them.

Never build scale architecture automatically for an MVP.

## 3. Architecture Constitution

Keep durable engineering principles compact and enforceable. Typical principles include:

- clear domain and data ownership,
- explicit dependency direction,
- least privilege,
- secrets never committed,
- stable module contracts,
- guarded destructive operations,
- reversible or safely forward-fixable migrations,
- critical business logic isolated from vendor APIs,
- tests protecting critical behavior.

## 4. Architectural Invariants

Identify rules that must remain true regardless of future features. Treat invariant violations as
architectural defects. Examples include:

- private user data must not appear in logs,
- authorization cannot be bypassed through a lower-level data path,
- owned data may only be mutated through its approved boundary,
- retried financial operations must remain idempotent,
- privileged actions must remain auditable and explicitly authorized.

## 5. Domain and Dependency Design

For each domain define:

- responsibility,
- owned data,
- exposed interfaces,
- allowed dependencies,
- events/messages if used,
- failure behavior,
- test boundaries.

Avoid circular dependencies, god modules, uncontrolled shared mutable state, and business logic
scattered across unrelated layers. Shared utilities must not become hidden ownership boundaries.

## 6. Data Architecture

For important data define:

- source of truth and owner,
- schema and identifiers,
- validation and invariants,
- relationships and indexes,
- access and consistency requirements,
- retention, backup, export, and deletion,
- migration and recovery strategy,
- privacy classification.

Consider the full lifecycle from creation through deletion. Avoid duplicate sources of truth
without explicit synchronization rules.

## 7. API and Contract Architecture

For internal and external interfaces define:

- inputs and outputs,
- validation,
- authentication and authorization,
- errors and failure semantics,
- timeout and retry behavior,
- idempotency,
- pagination and rate limits,
- versioning and backward compatibility,
- deprecation strategy.

Prefer stable contracts over accidental coupling to implementation details.

## 8. Reversibility and Vendor Boundaries

Classify important choices as reversible two-way doors or expensive one-way doors. Apply deeper
scrutiny to one-way doors. Contain vendor-specific integrations where replacement risk matters,
but do not create abstraction without a real need.

For important technologies ask:

- how would we leave this later,
- what data would migrate,
- what contract permits replacement,
- whether old and new systems can coexist temporarily,
- what rollback or forward-fix path exists.

## 9. Security and Privacy Architecture

Define trust zones, authentication, authorization, least privilege, secrets handling, input
validation, token/session lifecycle, tenant isolation, auditability, data exposure, and privileged
actions proportionally to risk.

For important systems identify assets, attackers, entry points, trust boundaries, abuse cases,
escalation paths, likely impact, and mitigations. Minimize data collection and make retention,
delete/export behavior, consent, and logging restrictions explicit.

## 10. Reliability Architecture

Assume dependencies will fail. For important dependencies define:

- timeout,
- retry,
- fallback or degraded mode,
- circuit breaking where appropriate,
- queueing behavior,
- idempotency,
- failure visibility,
- recovery and rollback expectations.

Control blast radius so one failure does not unnecessarily disable unrelated capabilities.

## 11. Performance, Scalability, and Cost

Set measurable budgets where performance matters. Scale from evidence, not fashion. A modular
monolith is often the correct starting point. Evaluate likely bottlenecks and costs at current
usage and relevant growth multiples before adding distributed complexity.

## 12. Repository and Developer Architecture

The repository should communicate the architecture through clear entry points, domain folders,
shared packages, configuration, tests, generated-code boundaries, scripts, infrastructure,
documentation, and ownership.

Structure code for both humans and AI agents with predictable naming, compact responsibilities,
stable interfaces, architecture maps, and minimal hidden conventions.

## 13. Decision and Drift Governance

Record major one-way-door decisions with context, alternatives, trade-offs, consequences,
reversal paths, and reconsideration triggers. Use automated fitness checks where practical.
Periodically detect architecture drift such as cross-domain shortcuts, duplicated business logic,
dependency-direction violations, vendor leakage, security-boundary bypasses, or data-ownership
violations.

Technical debt may be accepted when intentional, visible, bounded, and paired with a remediation
trigger. Treat complexity as a limited resource.

## 14. Release, Observability, and Recovery

Important production systems need enough logs, metrics, traces, crash reporting, audit events,
correlation, dashboards, alerts, backups, restore verification, deployment validation, and
rollback/forward-fix planning to understand and recover from failures.

Feature flags should reduce release risk and have removal triggers. Do not accumulate permanent
operational scaffolding without ownership.

## 15. AI and Agent Architecture

When AI is part of the system define model/provider boundaries, prompt ownership, tool and data
access, retrieval, memory, structured outputs, validation, fallbacks, cost and latency controls,
privacy, hallucination handling, and human approvals.

For multi-agent systems define responsibilities, authority, tools, data access, communication,
handoffs, shared memory, escalation, conflict resolution, and auditability. Avoid overlapping
unbounded authority.

NEXUS Guardian, Watchdog, GREEN/YELLOW/RED classification, approval gates, workspace boundaries,
emergency stop, deterministic verification, and budget controls remain external execution
controls and must not be bypassed by a skill.

## 16. Verification Questions

Before approving a major design ask:

1. Is this the simplest design that meets current needs?
2. What becomes harder because of this choice?
3. What can fail, and what is the blast radius?
4. What can be replaced or removed safely?
5. What is difficult to reverse?
6. Who owns each important piece of data?
7. Are security and privacy boundaries explicit?
8. How are critical contracts tested?
9. How will failures be observed and recovered?
10. How will the design evolve at the next growth stage?
11. Can a new developer or bounded AI agent understand it?
12. What evidence would tell us the architecture must change?

## 17. Output Standard

For significant architecture work produce only the level of documentation needed. Prefer:

- system overview,
- key domains and ownership,
- major boundaries and contracts,
- data ownership,
- security/reliability decisions,
- technology choices with rationale,
- material trade-offs,
- ADRs for important one-way doors,
- evolution path,
- verification approach.

Do not create enormous documents merely to appear thorough.

## Deep Reference

The original comprehensive principal-architecture playbook is preserved in
[references/REFERENCE.md](references/REFERENCE.md). It contains the complete reviewed detail for
failure domains, graceful degradation, offline synchronization, disaster recovery, performance,
scalability, accessibility, multi-platform systems, architecture maps, ADRs, fitness checks,
drift control, technical debt, observability, SLOs, incidents, releases, feature flags,
experimentation, analytics, business architecture, testing architecture, AI/provider/agent
governance, documentation, verification gates, review questions, coordination, and stop
conditions.

Load the deep reference only when those concerns materially affect the bounded task.

## Stop Conditions

Architecture work is sufficient when:

- structural ambiguity no longer blocks implementation,
- critical ownership and boundaries are clear,
- important one-way-door decisions are understood,
- security and reliability implications are addressed proportionally,
- foreseeable evolution paths exist,
- the design is no more complex than necessary,
- implementers know where responsibilities belong.

Do not continue designing indefinitely.

## Final Standard

Leave the system understandable, replaceable where practical, recoverable, auditable, testable,
and able to evolve without architectural collapse. Build for today while preserving tomorrow.