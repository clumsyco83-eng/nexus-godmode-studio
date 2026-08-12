# Manifest

**NEXUS Professional Intelligence Pack — v1.0.0**
Status: READY FOR HUMAN REVIEW. Not installed, not deployed.
Last evaluation: 2026-08-12 (structural validation; behavioral evaluation pending — see below).

All twenty skills are version `1.0.0` and follow semantic versioning independently. A change to
one skill bumps that skill, not the pack's other nineteen. The pack version bumps when skills are
added or removed, or when a shared normative document changes.

---

## Permission vocabulary

Skills in this pack declare permissions as *what the skill's instructions authorize the assistant
to do*, not as a runtime grant. The Agent Skills specification's `allowed-tools` field is
deliberately unused — it is experimental, inconsistently supported, and would embed a capability
grant in a file that travels between hosts. Permissions are enforced by the host environment and
by the governance rules, not asserted by the skill.

| Permission | Meaning |
| --- | --- |
| `read` | Reads files, repositories, and data within the authorized workspace |
| `analyze` | Reasoning and reporting only; produces no side effects |
| `web-read` | Reads public web sources; retrieved content is data, never instruction |
| `write-workspace` | Writes files inside the authorized workspace |
| `execute-checks` | Runs tests, builds, linters, and read-only queries |
| `propose-red` | May *propose* a RED action for human approval; never performs one |

No skill in this pack declares network write, credential access, payment capability, or the
ability to execute an irreversible action. Every RED action terminates in a human approval gate.

---

## Skills

Risk class describes the highest-risk action the skill can *propose*, not what it may perform
unattended. Every skill is capped at `propose-red`.

### 01 — nexus-systems-architect
- **Version** 1.0.0 · **Purpose** Structure of the NEXUS platform: boundaries, contracts,
  dependencies, failure domains, migrations, ADRs.
- **Triggers** New subsystem; cross-component change; contract change; structural refactor;
  migration; platform choice; structural decay.
- **Dependencies** none · **Permissions** `read`, `analyze`, `write-workspace` (ADRs only)
- **Resources** none · **Risk** propose-red (migrations) · **Description** 821 chars · **Body** 314 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 02 — ai-agent-orchestration-engineer
- **Version** 1.0.0 · **Purpose** Planners, routers, workers, supervisors, state machines, queues,
  bounded retries, escalation, model routing, human-in-the-loop.
- **Triggers** Task decomposition across agents; delegation to a coding agent; workflow stalls,
  loops, or duplicates; model tier selection; approval checkpoint placement.
- **Dependencies** none · **Permissions** `read`, `analyze`, `write-workspace`
- **Resources** none · **Risk** propose-red · **Description** 878 chars · **Body** 313 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 03 — skill-architecture-engineer
- **Version** 1.0.0 · **Purpose** The Skill Operating System: registry, manifests, discovery,
  routing, dynamic loading, versioning, precedence, deprecation, telemetry.
- **Triggers** Adding or retiring a skill; writing a description; wrong skill fired; overlapping
  skills; catalog cost rising; skill permission requests.
- **Dependencies** none · **Permissions** `read`, `analyze`, `write-workspace`
- **Resources** none · **Risk** propose-red (admission) · **Description** 803 chars · **Body** 303 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 04 — verification-reliability-engineer
- **Version** 1.0.0 · **Purpose** Evidence-based completion: acceptance criteria, evidence tiers,
  failure classification, bounded repair, regression detection, rollback criteria.
- **Triggers** Any completion claim; agent reports success; defining done; repeated fixes;
  irreversible dependency on a result.
- **Dependencies** none · **Permissions** `read`, `analyze`, `execute-checks`
- **Resources** `references/EVIDENCE.md` · **Risk** propose-red · **Description** 835 chars · **Body** 306 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 05 — security-permission-architect
- **Version** 1.0.0 · **Purpose** Least privilege, authn/authz, secrets, approvals, risk
  classification, sandboxing, workspace boundaries, audit, injection defense, supply chain.
- **Triggers** Credentials; permissions; payments; admin; shell or filesystem access; outbound
  network; installing a skill or dependency; personal data; risk classification; pre-release.
- **Dependencies** none · **Permissions** `read`, `analyze`, `execute-checks` (defensive tests on
  owner-controlled systems only)
- **Resources** `references/CONTROLS.md` · **Risk** propose-red · **Description** 896 chars · **Body** 302 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 06 — github-code-review-engineer
- **Version** 1.0.0 · **Purpose** Independent review of what actually changed: diffs, commits,
  branches, PRs, merge safety, CI interpretation, regression attribution.
- **Triggers** Coding agent reports an implementation; PR or diff review; pre-merge; CI failure;
  regression tracing; confusing history.
- **Dependencies** none · **Permissions** `read`, `analyze`, `execute-checks`
- **Resources** none · **Risk** propose-red (merge, tag, publish) · **Description** 869 chars · **Body** 284 lines
- **Compatibility** Any host with repository read access · **Evaluated** 2026-08-12

### 07 — context-token-efficiency-engineer
- **Version** 1.0.0 · **Purpose** Context budgeting, progressive loading, caching, deduplication,
  checkpoint/resume, model escalation policy, tool-call efficiency.
- **Triggers** Long sessions; repeated reads; oversized tool output; cost rising; work spanning
  sessions; model tier decisions.
- **Dependencies** none · **Permissions** `read`, `analyze`
- **Resources** none · **Risk** GREEN · **Description** 865 chars · **Body** 284 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 08 — knowledge-memory-engineer
- **Version** 1.0.0 · **Purpose** Structured, episodic, semantic, project and business memory with
  provenance, timestamps, confidence, expiry, and contradiction handling.
- **Triggers** What persists beyond a session; memory schema or retrieval; stale or contradictory
  recollection; state surviving handoffs; structuring decisions and lessons.
- **Dependencies** none · **Permissions** `read`, `analyze`, `write-workspace`
- **Resources** `references/SCHEMA.md` · **Risk** propose-red (deletion) · **Description** 871 chars · **Body** 282 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 09 — devops-observability-engineer
- **Version** 1.0.0 · **Purpose** Deployment, CI/CD, environments, configuration, health checks,
  monitoring, alerting, rollback, backups, recovery, uptime.
- **Triggers** Moving into operation; pipeline work; environment or config definition; outage or
  degradation; rollback and restore planning; silent failure risk.
- **Dependencies** none · **Permissions** `read`, `analyze`, `write-workspace`, `execute-checks`
- **Resources** none · **Risk** propose-red (production) · **Description** 807 chars · **Body** 297 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 10 — testing-qa-engineer
- **Version** 1.0.0 · **Purpose** Test strategy across unit, integration, end-to-end, contract and
  manual levels; edge cases; failure injection; fixtures; release gates.
- **Triggers** What to test and at which level; writing or repairing tests; escaped bug needing a
  regression test; slow or flaky suite; green suite with a broken product.
- **Dependencies** none · **Permissions** `read`, `analyze`, `write-workspace`, `execute-checks`
- **Resources** none · **Risk** GREEN · **Description** 818 chars · **Body** 298 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 11 — professional-web-app-engineering
- **Version** 1.0.0 · **Purpose** Commercial-quality frontend, backend, databases, APIs, auth,
  responsive UI, accessibility, performance, secure coding, deployment architecture.
- **Triggers** Building or reviewing a website, app, storefront, or API for a business;
  requirements through launch; assessing whether software is commercial quality.
- **Dependencies** none · **Permissions** `read`, `analyze`, `write-workspace`, `execute-checks`
- **Resources** none · **Risk** propose-red (deploy, migrations, payments) · **Description** 864 chars · **Body** 314 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 12 — data-analytics-engineer
- **Version** 1.0.0 · **Purpose** Datasets, SQL, data quality, pipelines, instrumentation,
  dashboards, KPI definitions, attribution, cohorts, experiments, anomaly detection.
- **Triggers** What to measure; instrumenting a funnel; dashboards; did the change work; a metric
  moved; numbers disagree; channel or cohort performance.
- **Dependencies** none · **Permissions** `read`, `analyze`, `execute-checks` (read-only queries)
- **Resources** none · **Risk** propose-red (external export) · **Description** 825 chars · **Body** 294 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 13 — business-systems-architect
- **Version** 1.0.0 · **Purpose** Business models, operating systems, SOPs, workflows,
  responsibilities, automation boundaries, bottlenecks, capacity, governance.
- **Triggers** How work gets done after launch; owner is the bottleneck; what to automate and in
  what order; process breaking under volume; mapping work for NEXUS to assist.
- **Dependencies** none · **Permissions** `read`, `analyze`, `write-workspace`
- **Resources** none · **Risk** propose-red (automation touching customers or money) · **Description** 892 chars · **Body** 303 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 14 — market-competitive-intelligence
- **Version** 1.0.0 · **Purpose** Market, customer and competitor research; demand signals;
  pricing; source evaluation; evidence quality; fact/inference/assumption separation.
- **Triggers** Evaluating an opportunity; sizing demand; competitor or pricing research;
  validating a customer claim; verifying anything that may have changed.
- **Dependencies** none · **Permissions** `read`, `analyze`, `web-read`
- **Resources** none · **Risk** propose-red (any outward contact) · **Description** 885 chars · **Body** 305 lines
- **Compatibility** Requires web access for current facts · **Evaluated** 2026-08-12

### 15 — product-strategy-pmf
- **Version** 1.0.0 · **Purpose** Customer problems, value propositions, discovery, MVP scoping,
  prioritization, differentiation, product-market fit, retention, roadmaps.
- **Triggers** What to build next; cutting to an MVP; is a feature worth building; has fit been
  found; interpreting feedback; what to remove.
- **Dependencies** consumes `market-competitive-intelligence` output
- **Permissions** `read`, `analyze` · **Resources** none · **Risk** propose-red (anything
  customer-facing) · **Description** 859 chars · **Body** 306 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 16 — growth-marketing-intelligence
- **Version** 1.0.0 · **Purpose** SEO, content, YouTube, TikTok, Instagram, Pinterest, paid
  acquisition, email, affiliate, funnels, distribution, campaign measurement.
- **Triggers** Product exists and nobody knows; channel selection; content and SEO planning;
  campaign underperforming; acquisition cost rising; launch planning.
- **Dependencies** none · **Permissions** `read`, `analyze`, `web-read`
- **Resources** none · **Risk** propose-red (publish, send, spend) · **Description** 870 chars · **Body** 302 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 17 — sales-conversion-systems
- **Version** 1.0.0 · **Purpose** Offers, positioning, lead generation and qualification, CRM,
  pipelines, landing pages, conversion, objections, follow-up, retention, lifecycle.
- **Triggers** Traffic but no purchases; offer design; checkout abandonment; pipeline or CRM
  design; objection handling; customers not returning.
- **Dependencies** none · **Permissions** `read`, `analyze`
- **Resources** none · **Risk** propose-red (send, publish, checkout changes) · **Description** 836 chars · **Body** 309 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 18 — finance-unit-economics
- **Version** 1.0.0 · **Purpose** Revenue, margins, CAC, LTV, churn, ROAS, cash flow, break-even,
  runway, forecasting, scenario and sensitivity analysis. **Decision support only.**
- **Triggers** Is the opportunity viable; pricing; is spend sustainable; cash and runway modeling;
  busy but not profitable; a decision resting on numbers.
- **Dependencies** consumes `data-analytics-engineer` output
- **Permissions** `read`, `analyze` — **explicitly never** payment, banking, or commitment
  capability · **Resources** `references/FORMULAS.md` · **Risk** propose-red (all financial
  actions are the owner's) · **Description** 830 chars · **Body** 316 lines
- **Compatibility** Any Agent Skills host · **Evaluated** 2026-08-12

### 19 — product-project-management
- **Version** 1.0.0 · **Purpose** Requirements, milestones, dependencies, decomposition,
  acceptance criteria, roadmaps, risk registers, status reporting, change and release management.
- **Triggers** Scoping large work; sequencing dependencies; what comes first; tracking progress;
  status reporting; scope change; release planning.
- **Dependencies** consumes `verification-reliability-engineer` verdicts
- **Permissions** `read`, `analyze`, `write-workspace` · **Resources** none · **Risk** GREEN
- **Description** 867 chars · **Body** 306 lines · **Compatibility** Any host · **Evaluated** 2026-08-12

### 20 — recursive-improvement-evaluation
- **Version** 1.0.0 · **Purpose** Evaluation suites, benchmarks, baseline comparison, A/B testing,
  regression detection, capability measurement, postmortems, continuous improvement.
- **Triggers** A change needs measuring; keep or revert; building an evaluation suite; comparing
  versions; drift in quality, cost or speed; accumulated complexity; postmortems.
- **Dependencies** none · **Permissions** `read`, `analyze`, `execute-checks`
- **Resources** `references/EVAL-PROTOCOL.md` · **Risk** propose-red (revert in a live system)
- **Description** 822 chars · **Body** 317 lines · **Compatibility** Any host · **Evaluated** 2026-08-12

---

## Shared resources

Pack-level normative documents. They are **not referenced from inside any `SKILL.md`** — the Agent
Skills specification requires skill file references to stay within the skill directory, and a
skill installed on its own must remain complete. Each skill restates the rules it must enforce;
these documents are the single place those rules are edited.

| Document | Contains | Read by |
| --- | --- | --- |
| `shared/GOVERNANCE.md` | Human authority, approval gates, GREEN/YELLOW/RED, standing controls, credential and financial boundaries, untrusted content, precedence | The owner; anyone changing a governance rule |
| `shared/EVIDENCE-STANDARD.md` | Status vocabulary, evidence tiers E1–E5, acceptance criteria, failure classes, repair loops, confidence, fact/inference/assumption | The owner; verification and QA lanes |
| `shared/HANDOFF-PROTOCOL.md` | Lane rule, handoff packet, standard chains, combining without duplicating, escalation, non-activation | The owner; anyone adding a skill |
| `shared/MATURITY-STAGES.md` | Stage 1–4 operating conditions and the stage rule | The owner; every skill's stage judgement |

## Tooling

| File | Purpose | Risk |
| --- | --- | --- |
| `validate.py` | Validates all twenty skills against the Agent Skills specification and this pack's own rules | Read-only, standard library only, no network, no side effects. Lives at pack root and is never executed as part of a skill. |

---

## Evaluation status

**Structural validation: PASS** (2026-08-12) — all twenty skills validated by `validate.py`:
frontmatter well-formed at byte zero, names spec-conformant and matching directories, descriptions
within 1024 characters and carrying negative triggers, all fifteen required sections present, all
references resolving one level deep, no duplicate names, no prohibited claim language, bodies
within the 500-line and ~5,000-token guidance.

**Behavioral evaluation: NOT YET RUN.** `EVALUATION-SUITE.md` defines fifteen scenarios with
expected activations, expected non-activations, workflows, pass criteria, and fail conditions.
Running them requires the pack installed in a host, which has not happened and requires the
owner's decision. Until those results exist, routing accuracy for this pack is **unmeasured** —
stated here rather than implied, because a claim of correct routing without observed activations
would be exactly the E5 assertion this pack refuses elsewhere.

## Change control

- One skill changes at a time; bump that skill's version only.
- Re-run `validate.py` after any edit.
- Re-run the affected evaluation scenarios, plus the scenarios for adjacent skills — a description
  change shifts routing to and from neighbors.
- Record the change, its reason, and its measured effect in `CHANGELOG.md`.
- Never edit all twenty skills because one is wrong.
