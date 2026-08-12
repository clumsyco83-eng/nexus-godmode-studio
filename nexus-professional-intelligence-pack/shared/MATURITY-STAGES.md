# Maturity Stages — Normative Rules

NEXUS is built in stages. The purpose of this document is to stop skills from applying
Stage 4 machinery to a Stage 1 problem, which is the most reliable way to spend months building
infrastructure for revenue that never arrives.

The revenue bands name the operating conditions a stage is designed for. They are not forecasts,
targets the pack can deliver, or promises. No skill in this pack may present a business outcome
as assured.

---

## Stage 1 — $0 → $1K/month

**Condition:** nothing is proven. The main risk is building something nobody wants.

Focus: opportunity validation, a small launchable product, a website or listing, one distribution
channel, first customers, and enough measurement to tell signal from noise.

Appropriate: manual processes, spreadsheets, a single environment, one repository, basic
analytics, hand-run checks.

**Not yet:** microservices, multi-agent orchestration, CRM automation, forecasting models,
dashboards, formal governance boards, disaster recovery drills.

Stage 1 exit signal: repeatable revenue from customers who are not friends, and a named reason
they bought.

## Stage 2 — $1K → $10K/month

**Condition:** something works but only when a human drives it. The main risk is that it does not
survive repetition.

Focus: making the working thing repeatable, automating the highest-friction step, real analytics,
a content or acquisition system that runs on a schedule, customer operations, conversion work.

Appropriate: CI, a staging environment, structured memory, scheduled jobs, a real test suite,
basic alerting.

**Not yet:** portfolio management, department-level workflows, enterprise access control,
multi-region infrastructure.

Stage 2 exit signal: the process runs to the same standard without the owner performing each
step, and unit economics are measured rather than estimated.

## Stage 3 — $10K → $100K/month

**Condition:** the system works and the constraint moves to coordination and cost.

Focus: scaling what is proven, multi-agent coordination where it earns its complexity, CRM,
financial forecasting from real history, process automation, outsourcing support, operational
intelligence.

Appropriate: job queues, model routing, rollback automation, cohort analysis, SLOs, structured
incident response, formal change control.

**Not yet:** governance apparatus that outweighs the team it governs.

Stage 3 exit signal: the business survives the owner being unavailable for a week.

## Stage 4 — $100K → $1M+/month

**Condition:** multiple lines of business, real operational and regulatory exposure.

Focus: portfolio management, department-level workflows, enterprise security posture, advanced
observability, accounting and data integrations, human management systems, disaster recovery,
formal governance.

Appropriate: everything above, plus the compliance and continuity work that only makes sense once
there is something substantial to lose.

---

## The stage rule

Every skill checks the current stage before recommending structure.

1. **Ask which stage the work is actually in.** If unknown, assume the earlier stage.
2. **Recommend the simplest structure that serves the current stage** and does not foreclose the
   next one.
3. **Name the trigger** that would justify moving to the heavier option, rather than building it
   now. "Add a queue when a single request exceeds 30s or when retries start colliding" is
   useful. "Add a queue for scalability" is not.
4. **Say when you are deliberately deferring complexity**, so the decision is visible rather than
   an oversight.

Premature Stage 4 complexity is a defect, and skills should name it as one when they see it —
including when the owner asked for it. Say plainly that it is early, give the cost, and if the
owner still wants it, build it properly.

The reverse error is real too: refusing to add necessary structure because "we are early" when
the system is visibly failing under current load. Stage discipline cuts both ways, and the
evidence of current failure outranks the stage heuristic.
