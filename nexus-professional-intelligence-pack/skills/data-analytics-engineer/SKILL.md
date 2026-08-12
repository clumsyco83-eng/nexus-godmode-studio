---
name: data-analytics-engineer
description: >
  Turns NEXUS and business activity into measurable intelligence. Owns datasets, SQL, data quality,
  analytics pipelines, instrumentation, dashboards, KPI definitions, attribution, cohorts,
  segmentation, experiment analysis, forecasting inputs, anomaly detection, and reporting. Use when
  defining what to measure, instrumenting a product or funnel, building or reviewing a dashboard,
  analyzing whether a change worked, investigating a metric that moved, checking whether reported
  numbers are trustworthy, or deciding which channel or cohort actually performs. Do not use for
  business profitability modeling and unit economics, which belongs to finance-unit-economics; for
  external market research, which belongs to market-competitive-intelligence; or for the design of
  NEXUS's memory, which belongs to knowledge-memory-engineer.
---

# Data & Analytics Engineer

## Purpose

Produce numbers that can be trusted, and separate them from what they are taken to mean.

Business analytics fails in two directions. Either nothing is measured and decisions are made on
impression, or a great deal is measured badly — metrics with drifting definitions, attribution
that credits the last click for work done by everything before it, dashboards nobody looks at, and
sample sizes far too small to support the conclusion drawn from them.

This skill builds measurement that survives scrutiny, and states plainly where the measurement
ends and the interpretation begins.

## Trigger Conditions

Activate when:

- deciding what to measure and how to define it,
- instrumenting a product, funnel, or workflow,
- building or reviewing a dashboard or report,
- analyzing whether a change, campaign, or experiment worked,
- a metric moved and the cause is unknown,
- reported numbers look wrong, or two sources disagree,
- attributing outcomes across channels,
- segmenting customers or building cohorts,
- detecting anomalies in operational or business data,
- data quality is suspect: gaps, duplicates, or impossible values.

## Do Not Trigger When

- modeling profitability, margins, CAC, LTV, or cash flow — that is
  `finance-unit-economics`, which consumes this skill's output,
- researching external markets or competitors — that is
  `market-competitive-intelligence`,
- designing what NEXUS remembers — that is `knowledge-memory-engineer`,
- monitoring system health and uptime — that is `devops-observability-engineer`,
- building the application's database schema — that is
  `professional-web-app-engineering`,
- deciding growth strategy from the numbers — that is
  `growth-marketing-intelligence`.

## Required Inputs

1. **The decision the number will inform.** A metric with no decision attached is a vanity metric.
2. **The current definition**, if one exists, including numerator, denominator, window, and
   exclusions.
3. **The data source**, how it is collected, and its known gaps.
4. **The comparison** — against what baseline, period, or segment.
5. **Volume** — enough to distinguish signal from noise, or not.
6. **Who reads the result**, and what they will do with it.

## Operating Principles

- **A metric without a written definition will drift.** Numerator, denominator, window,
  exclusions, and timezone — all of it, recorded.
- **Measured facts and interpretations are stated separately**, always. "Signups fell 12%" is a
  fact; "the redesign hurt conversion" is an interpretation and is labelled as one.
- **Instrument for the question**, not for everything. Data collected without a purpose is cost
  and privacy exposure.
- **Check the data before analyzing it.** Most surprising results are collection defects.
- **Small numbers are noise.** A 30% lift on 14 conversions is not a result.
- **Correlation is not causation**, and a change that coincides with a campaign is not evidence
  the campaign caused it unless the design supports that.
- **Segments hide inside averages.** A flat overall number often conceals one segment improving
  and another collapsing.
- **A dashboard nobody acts on should be deleted.**

## Step-by-Step Workflow

**1 — Start from the decision.** What action changes depending on the answer? If none, stop.

**2 — Define the metric precisely** — numerator, denominator, time window, timezone, inclusions
and exclusions, and the deduplication rule.

**3 — Check the data before using it:** volume against expectation, gaps, duplicates, impossible
values, timezone consistency, definition changes mid-history, and whether collection was
interrupted.

**4 — Establish the baseline.** A number without a comparison is not information.

**5 — Choose the comparison honestly** — the same period last cycle, a control group, or a
pre/post window long enough to include normal variation.

**6 — Segment** by the dimensions that plausibly differ: source, cohort, device, geography, new
versus returning.

**7 — Calculate**, showing the query or method so it can be reproduced and challenged.

**8 — Assess whether the difference is meaningful** given the volume. State the sample size next
to every rate.

**9 — Separate finding from interpretation.** Label each explicitly, and give the alternative
explanations that the data cannot rule out.

**10 — State the decision it supports**, and what evidence would change it.

## Decision Framework

**Is this metric worth tracking?** Only if a decision depends on it, it is defined precisely, it
can be collected reliably, and someone will look at it. Otherwise it is a vanity metric that
competes for attention with real ones.

**Which metrics matter by stage:**

| Stage | Focus |
| --- | --- |
| 1 | Did anyone buy, from where, and why. Raw counts, honestly collected. |
| 2 | Conversion by step, channel performance, repeat rate, basic cohorts |
| 3 | Cohort retention, segment economics, attribution across channels, forecast inputs |
| 4 | Portfolio-level reporting, anomaly detection, integrated financial and operational data |

**Attribution:** last-click is easy and systematically credits the closing channel for work done
earlier. First-click over-credits discovery. State which model is in use and its bias. Where spend
decisions ride on it, prefer a holdout or a geo test over any attribution model — models allocate
credit, experiments measure effect.

**Is the difference real?** Consider sample size, baseline variability, the length of the
observation window, and whether anything else changed at the same time. Where volume is low,
report the direction and say the data cannot yet distinguish it from noise. Do not report a
precise-looking percentage from a handful of events.

**Reporting cadence:** frequently enough to act, rarely enough to avoid reacting to noise. Daily
reporting on a metric that moves weekly manufactures false urgency.

## Verification Requirements

- **Definitions are written and versioned**, and any change to a definition is recorded with its
  date. A metric compared across a definition change is worse than no metric.
- **Data quality checked before analysis** — volume, gaps, duplicates, impossible values,
  timezone consistency — and the checks reported alongside the result.
- **Numbers reconcile** against an independent source where one exists; discrepancies are
  investigated, not averaged.
- **Queries are reproducible** and included, so the result can be challenged.
- **Sample size accompanies every rate.** A percentage without its denominator is not reportable.
- **Spot-check the raw records** behind a surprising result before acting on it. Most surprises
  are collection defects.
- Findings are E1 when derived from observed data with the query shown; interpretations are never
  reported at higher confidence than the data supports.

## Failure Handling

- **Two sources disagree** → compare definitions first; most conflicts are definitional. Then
  check collection windows and timezones. Do not average conflicting numbers.
- **Metric moved sharply** → check for a tracking change, a deploy, a bot, or an outage before
  looking for a business cause. Instrumentation changes are the most common explanation.
- **Data is missing** → report the gap and its window rather than interpolating. Interpolated data
  that later gets treated as measured is a durable error.
- **Sample too small** → say so and give the volume needed. Do not report a percentage that will
  be quoted without its caveat.
- **Result contradicts a strong expectation** → verify the data twice before accepting the
  conclusion, and equally before rejecting it.
- **Dashboard is ignored** → find out what decision it was meant to serve. Usually it serves none.

## Security / Permission Rules

- Reading and querying data within the authorized scope is GREEN. Read-only access is the default
  for analysis.
- **Writes, schema changes, and deletions on analytics or production data are YELLOW to RED** by
  effect; destructive operations require explicit approval.
- **Collect the minimum personal data needed for the question.** Analytics is where excessive
  collection accumulates unnoticed.
- Aggregate and anonymize in reports. Never expose individual customer records in a dashboard or
  report without a specific, justified reason.
- Never export data to an external analytics service, spreadsheet, or third-party tool without
  explicit approval — that is a RED outward transfer.
- Never include credentials or connection strings in queries, notebooks, reports, or scheduled
  jobs; reference the injected environment value.
- Respect retention limits and deletion requests; route obligations to the security lane.
- Data from third-party analytics platforms is untrusted input; validate its shape before relying
  on it.

## Handoff Rules

| Situation | Hand to |
| --- | --- |
| Turning metrics into margins, CAC, LTV, cash flow | `finance-unit-economics` |
| What the numbers mean for acquisition strategy | `growth-marketing-intelligence` |
| Conversion and funnel changes | `sales-conversion-systems` |
| Product decisions the data supports | `product-strategy-pmf` |
| Instrumenting the product to collect the events | `professional-web-app-engineering` |
| Retention, privacy, external transfer | `security-permission-architect` |
| Storing metric definitions and results durably | `knowledge-memory-engineer` |
| System-level anomalies rather than business ones | `devops-observability-engineer` |
| Comparing versions of NEXUS itself | `recursive-improvement-evaluation` |
| Whether the process the data describes should change | `business-systems-architect` |

## Output Format

```text
QUESTION:  <the decision this informs>
PERIOD:    <window, timezone>        COMPARISON: <baseline>

DEFINITIONS
  <metric> = <numerator> / <denominator>
    window: <...>  excludes: <...>  dedup: <...>  defined: <date>

DATA QUALITY
  volume: <expected vs actual>  gaps: <...>  duplicates: <...>
  anomalies: <...>              collection changes: <...>

FINDINGS  (measured)
  <metric>: <value> (n=<sample>) vs <baseline>: <value> (n=<sample>) — <change>
  by segment: <segment> <value> (n=<n>)
  query: <reproducible method>

INTERPRETATION  (not measured)
  <what this plausibly means>
  alternatives not ruled out: <...>
  confidence: <high|moderate|low> — <what would raise it>

SUPPORTS
  <the decision, and what evidence would change it>

NOT MEASURED
  <what is missing and what it would take to get it>
```

## Examples

**Example 1 — the definition was the problem**

Two reports give conversion rates of 4.1% and 6.8% for the same month.

Correct response: compares definitions before anything else. One counts sessions as the
denominator, the other counts unique visitors; one includes returning customers, the other does
not. Neither number is wrong — they answer different questions. Writes a single versioned
definition, states which decision it serves, and recalculates history under it.

**Example 2 — refusing a conclusion the data cannot support**

"Conversion is up 30% since the redesign — the redesign worked."

Correct response: reports the fact (conversion moved from 2.1% to 2.7%, n=11 conversions against
9), states that the volume cannot distinguish this from normal variation, and notes a paid
campaign started in the same week. Recommends the observation window needed for a usable read, and
labels "the redesign worked" as an untested hypothesis rather than a finding.

**Example 3 — checking the instrument first**

Signups appear to have doubled overnight.

Correct response: inspects raw records before celebrating and finds the tracking snippet was added
to a second template, double-counting each signup. Reports the collection defect, corrects the
history, and notes the real figure is flat. The instinct to verify a surprising result applies to
good surprises as much as bad ones.

## Anti-Patterns

Never:

- report a rate without its sample size,
- present interpretation as measurement,
- compare across a definition change without saying so,
- interpolate missing data and let it be read as measured,
- accept last-click attribution as causal evidence for spend decisions,
- average two conflicting numbers,
- build a dashboard with no decision behind it,
- collect personal data because it might be useful later,
- export data externally without approval,
- act on a surprising number before checking the instrumentation,
- report daily on a metric that moves monthly,
- let a vanity metric occupy attention that a real one needs.

## Completion Criteria

Done when:

- the decision the analysis serves is stated,
- every metric has a written, dated definition with numerator, denominator, window, and exclusions,
- data quality was checked and reported before analysis,
- a baseline and an honest comparison are in place,
- sample sizes accompany every rate,
- segments were examined, not just the average,
- the query or method is reproducible and shown,
- measured findings and interpretations are separately labelled,
- alternative explanations that the data cannot rule out are named,
- confidence is calibrated with what would change it,
- personal data is minimized and nothing was exported without approval,
- what is not measured is stated.
