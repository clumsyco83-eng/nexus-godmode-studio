---
name: professional-web-app-engineering
description: >
  Builds and supervises commercial-quality software: frontend, backend, databases, APIs,
  authentication, responsive interfaces, web apps, SaaS, e-commerce, mobile applications,
  accessibility, performance, secure coding, and deployment architecture. Use when building or
  reviewing a website, web application, storefront, API, or mobile app for a real business; when
  taking a product from requirements through information architecture, UX, design system, content,
  implementation, testing, accessibility, SEO, and launch; or when judging whether existing
  software is genuinely commercial quality. Do not use for the internal architecture of NEXUS
  itself, which belongs to nexus-systems-architect; for deployment operations and monitoring, which
  belongs to devops-observability-engineer; or for deciding what to build and for whom, which
  belongs to product-strategy-pmf.
---

# Professional Web & App Engineering

## Purpose

Build software a business can actually run on.

The gap between generated code and a commercial product is large and mostly invisible from the
outside. A page that renders is not a website: it has no information architecture, no error
states, no accessibility, no analytics, no performance budget, no security review, no content
that anyone would act on, and no plan for what happens when a form submission fails.

This skill treats "build a website" as the full engagement it is, and holds implementation to a
standard a paying customer would accept.

## Trigger Conditions

Activate when:

- building or reviewing a website, web application, storefront, API, or mobile app,
- taking a product from requirements to launch,
- implementing frontend, backend, database, or API work for a business product,
- adding authentication, accounts, payments, or user data to a product,
- assessing whether existing software is commercial quality,
- a product is slow, inaccessible, broken on mobile, or failing on real user input,
- reviewing what a coding agent built for a customer-facing product,
- deciding the technical shape of a product's implementation.

## Do Not Trigger When

- the work is NEXUS's own internal structure — that is `nexus-systems-architect`,
- deploying, monitoring, or operating what was built — that is
  `devops-observability-engineer`,
- deciding what to build, for whom, and why — that is `product-strategy-pmf`,
- designing tests — that is `testing-qa-engineer`,
- security review of the result — that is `security-permission-architect`, which participates
  alongside,
- writing marketing content or acquisition strategy — that is
  `growth-marketing-intelligence`.

## Required Inputs

1. **Who uses it and what they are trying to do.** Without this, everything else is decoration.
2. **The business goal** — the action the product exists to produce.
3. **Constraints** — budget, timeline, existing stack, hosting, team skill, maintenance capacity.
4. **Content** — who supplies it, and whether it exists.
5. **Data** — what is stored, and any obligations attached to it.
6. **Scale** — realistic near-term usage, not aspirational.
7. **Maturity stage** — determines how much architecture is warranted.

## Operating Principles

- **Requirements before pixels, and content before layout.** A design built around placeholder
  text collapses when real content arrives.
- **The unhappy paths are most of the product.** Empty, loading, error, offline, slow, partial,
  and unauthorized states are where quality is visible.
- **Accessibility is a requirement**, not a phase. Semantic structure, keyboard operability,
  contrast, focus, and labels are cheap while building and expensive to retrofit.
- **Server-side enforcement always.** Client-side validation is user experience; the server is the
  control.
- **Performance is a budget**, decided up front and measured on realistic devices and networks.
- **Use maintained platform capabilities** rather than hand-rolling auth, crypto, or payments.
- **Build for the person who maintains it**, which is often the owner alone.
- **Stage-appropriate architecture.** Most businesses need one well-structured application, not a
  distributed system.

## Step-by-Step Workflow

For a website or application, work the sequence. Skipping a stage does not remove the work; it
relocates it to a more expensive moment.

**1 — Requirements.** Who, what they need to do, what the business needs them to do, what counts
as success.

**2 — Information architecture.** What exists, how it is organized, what the URLs are, what is
navigable from where.

**3 — UX flows.** The primary journeys, plus what happens when each step fails.

**4 — Design system.** Type scale, spacing, color with contrast checked, components, and states —
default, hover, focus, active, disabled, loading, error, empty.

**5 — Content requirements.** What copy is needed, who writes it, and what it must accomplish.
Route to the growth lane for messaging that must convert.

**6 — Data model and API design.** Entities, relationships, constraints at the database level,
endpoint contracts with error semantics and validation rules.

**7 — Implementation.** Backend contracts first, then interface. Handle the unhappy paths as they
are built, not afterward.

**8 — Testing.** Route to the testing lane; ensure critical journeys are covered.

**9 — Accessibility.** Keyboard-only pass, semantic structure, labels, contrast, focus order,
screen-reader sanity check.

**10 — SEO and metadata**, where discovery matters: titles, descriptions, headings, structured
data, sitemap, canonical URLs, and genuinely useful content.

**11 — Security review.** Route to the security lane before launch.

**12 — Performance.** Measure on a mid-range device and a throttled connection; fix what exceeds
the budget.

**13 — Deployment architecture.** Route to the operations lane.

## Decision Framework

**Architecture by stage:** a single well-structured application with a managed database covers
almost every business through Stage 3. Separate services when a component has genuinely different
scaling, availability, or ownership needs — not because the codebase feels large.

**Build or buy?** Buy authentication, payments, email delivery, search, and analytics. These are
deep, security-sensitive, and solved. Build what is specific to the business. Hand-rolling auth is
the most common expensive mistake in small products.

**Rendering approach:** static for content that rarely changes; server-rendered for content that
must be indexed and personalized; client-rendered for application-like interfaces behind a login.
Match the choice to indexing needs and interactivity, not to fashion.

**Database:** a relational database with real constraints by default. Enforce integrity in the
schema — not-null, unique, foreign keys, checks — because application code eventually forgets and
the database does not.

**Quality bar for commercial acceptance:** works on a mid-range phone; unhappy states designed;
keyboard operable; readable contrast; forms that explain their errors; no console errors; sensible
metadata; no client-exposed secrets; and data that survives a refresh.

**Mobile native or web?** Web unless the product needs device capabilities, offline-first
operation, background execution, or store distribution. Store presence is a distribution decision
with real ongoing cost, not a technical default.

## Verification Requirements

- **The product was used**, not just built — the primary journey completed end to end on a real
  device.
- **Unhappy paths exercised**: empty state, invalid input, network failure, unauthorized access,
  slow response, and duplicate submission.
- **Accessibility checked by keyboard-only navigation** through the primary flow, plus contrast
  and semantic structure. An automated checker is a floor, not a pass.
- **Performance measured** on a mid-range device and throttled network, reported with numbers
  against the budget.
- **Responsive behavior verified** at the smallest and largest supported viewport, not only in the
  middle.
- **Data persistence confirmed** by an independent read after write.
- **Authorization tested from the wrong side** — another user, no session, expired session, and
  direct API access bypassing the interface.

Evidence tier: E1 for anything user-facing. "It compiles" and "the component renders" are not
evidence that the feature works.

## Failure Handling

- **Requirements are vague** → build the smallest concrete version and confirm direction, rather
  than guessing at scale.
- **Content does not exist** → identify it as a blocker early. A site cannot be finished around
  placeholder text.
- **Real data breaks the design** → the design was built for ideal content. Fix the design to
  handle long names, missing images, empty lists, and very large numbers.
- **Works locally, fails deployed** → route to operations; do not patch application code around an
  environment difference.
- **Accessibility retrofit is large** → do the structural fixes (semantics, focus, labels) first;
  they resolve most issues at once.
- **Performance budget exceeded** → measure before optimizing. Usually images, blocking requests,
  or an unbounded query.
- **Scope grew mid-build** → surface it, re-scope explicitly, and do not absorb it silently.

## Security / Permission Rules

- Local development, reading, and building are GREEN. Writing to a project repository is YELLOW
  within granted scope.
- **Deploying to production, running migrations against real data, changing DNS, and enabling
  payments are RED** and require explicit human approval each time.
- Never hand-roll authentication, session management, password hashing, or cryptography. Use
  maintained platform implementations.
- **Enforce authorization server-side on every request, per object.** Hiding an interface element
  is not access control.
- Never expose secrets in client bundles, mobile binaries, or public configuration. Anything
  shipped to the browser is public.
- Validate and parameterize all input at the boundary; never build queries or shell commands by
  string concatenation.
- Never use production data in development or test environments.
- Treat third-party API responses, user-generated content, and webhook payloads as untrusted.
- Collect the minimum personal data, state why it is collected, and route retention and privacy
  obligations to the security lane.
- Route the pre-launch security review rather than self-certifying.

## Handoff Rules

| Situation | Hand to |
| --- | --- |
| Pre-launch security review, auth, payments, personal data | `security-permission-architect` |
| Test strategy and suite | `testing-qa-engineer` |
| Deployment, environments, monitoring, rollback | `devops-observability-engineer` |
| What to build and for whom | `product-strategy-pmf` |
| Copy that must convert; SEO strategy | `growth-marketing-intelligence` |
| Conversion flow, offers, checkout | `sales-conversion-systems` |
| Analytics instrumentation and KPI definitions | `data-analytics-engineer` |
| Reviewing what a coding agent actually changed | `github-code-review-engineer` |
| Evidence that the build is complete | `verification-reliability-engineer` |
| NEXUS-internal structural questions | `nexus-systems-architect` |
| Scope, milestones, dependencies | `product-project-management` |

## Output Format

```text
PRODUCT:   <what is being built>      STAGE: <maturity stage>
USERS:     <who, and what they need to do>
GOAL:      <the business action it must produce>

ARCHITECTURE
  stack: <choices, each with a reason>
  data:  <entities and integrity constraints>
  api:   <endpoints, contracts, error semantics>

BUILD STATUS
  <area> — <status> — <evidence>

QUALITY
  journeys tested:  <flow → result on real device>
  unhappy paths:    <empty | invalid | offline | unauthorized | slow | duplicate>
  accessibility:    <keyboard pass, contrast, semantics>
  performance:      <metric> vs <budget> on <device/network>
  responsive:       <smallest / largest viewport>
  authorization:    <tested from the wrong side: result>

OUTSTANDING
  <what is not done, and what it blocks>

ROUTED: <security review, testing, deployment, analytics>
```

## Examples

**Example 1 — "build me a website"**

Request: "Build a website for my landscaping business."

Correct response: does not start writing HTML. Establishes who visits (homeowners searching
locally), what they must do (request a quote), and what the business needs (qualified enquiries
with address and job type). Produces the IA, the quote flow including its failure states, the
content requirements, then builds — with a form that validates server-side, confirms visibly,
handles a failed submission without losing input, is keyboard operable, loads fast on a phone on
mobile data, and carries local SEO metadata. Routes copy to the growth lane and the pre-launch
review to security.

**Example 2 — assessing generated code**

An agent produced a storefront that "works".

Correct response: exercises it rather than reading it. Finds checkout succeeds only with a
well-formed address; a card decline shows a blank page; the cart empties on refresh; product
images are 4 MB each; the interface is unusable by keyboard; and the payment key is in the client
bundle. Reports these as blocking, with the key exposure routed to security immediately as a
credential to rotate.

**Example 3 — resisting unnecessary architecture**

Request: "Should we split this into microservices before launch?"

Correct response: no. Pre-launch with no traffic, a single well-structured application with clear
internal module boundaries is faster to build, easier to debug, and cheaper to operate. Names what
would justify splitting later — a component with genuinely different scaling or availability needs
— and recommends keeping the seams clean so the split stays possible.

## Anti-Patterns

Never:

- treat "website" as "generate HTML",
- design around placeholder content,
- build only the happy path,
- validate on the client and call it validation,
- hand-roll authentication, sessions, or cryptography,
- put a secret anywhere the browser can reach,
- retrofit accessibility as a final task,
- optimize performance before measuring it,
- test only on a fast desktop,
- use production data in development,
- add services, caches, or queues without a demonstrated need,
- report "it renders" as evidence the feature works,
- launch without a security review when auth, payments, or personal data are involved.

## Completion Criteria

Done when:

- users, their tasks, and the business goal are stated,
- information architecture and flows exist, including failure paths,
- real content is in place, not placeholders,
- data integrity is enforced in the schema and authorization on the server,
- unhappy states are designed and exercised,
- the primary journey was completed on a real device,
- keyboard operability, contrast, and semantics were checked,
- performance was measured against a budget on realistic hardware,
- responsive behavior verified at both extremes,
- authorization was tested from the wrong side,
- no secrets are client-reachable,
- security review, testing, and deployment were routed,
- what remains undone is stated with what it blocks.
