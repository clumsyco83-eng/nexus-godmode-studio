# NEXUS Orchestration Map

How NEXUS GODMODE MASTER routes work to specialist skills.

NEXUS orchestrates. It does not reimplement what a specialist already owns, and it
does not load the whole roster to answer one question. Skills stay separate; this
map is the routing layer between them.

## Lane map

| Lane | Skill | Owns |
| --- | --- | --- |
| Research | `technology-research-scout` | Current libraries, vendors, platforms, pricing, licences, deprecations, security advisories |
| Planning — structure | `principal-architecture` | Boundaries, one-way-door decisions, long-term evolution |
| Planning — product | `nexus-ai-product-strategy` | Idea validation, differentiation, MVP scope, pricing, metrics, roadmap |
| Coding — orchestration | `godmode-v2` | Mission, task graph, delegation, execution, recovery, handoff |
| Coding — comprehension | `engineering-intelligence` | Unfamiliar repos, behaviour tracing, root-cause debugging, regressions |
| Coding — backend/data | `backend-data-engineer` | APIs, schemas, transactions, queues, caching, migrations, multi-tenancy |
| Coding — AI systems | `ai-systems-engineer` | LLM/agent features, tools, RAG, evals, guardrails, cost and latency |
| Coding — platform | `platform-sre-engineer` | CI/CD, IaC, containers, observability, SLOs, incidents, DR |
| UI / UX | `nexus-figma-design-director` | Design systems, screens and states, prototypes, developer handoff |
| App development | `nexus-aaa-mobile-app-studio` | iOS/Android product work end to end |
| Game development | `nexus-aaa-game-studio` | Gameplay, systems, content, progression, game release |
| Animation / motion | `nexus-animation-vfx-studio` | Character and UI motion, camera, particles, shaders, game feel |
| Image / video | `nexus-higgsfield-creative-director` | Cinematic images and video, ads, trailers, storyboards, UGC |
| Testing | `nexus-qa-testing-director` | Test strategy, coverage, defect triage, performance, release gates |
| Security | `security-guardian` | Threat modeling, secure design and code review, dependencies, hardening |
| Release | `nexus-app-store-release-director` | Builds, signing, store compliance, metadata, testing tracks, rollout |
| Growth | `nexus-aso-growth-marketing` | Positioning, ASO, creative testing, funnels, retention |
| Verification | `nexus-qa-testing-director` + `security-guardian` | Independent evidence before completion |
| Continuity | `project-memory-continuity` | Checkpoints, decision records, durable state across sessions |
| Efficiency | `token-optimizer-v2` | Narrow context loading, delta inspection, model/effort routing |

## Routing rules

1. **Name the lane before naming the skill.** Identify what kind of work the phase
   is, then take the skill that owns that lane.
2. **Respect the skill budget.** Master plus Token Optimizer plus one active
   specialist by default. A second specialist needs a boundary that genuinely
   spans two lanes. Three needs a stated reason.
3. **Verification is a separate lane from building.** The skill that produced the
   work does not certify it. Route verification to QA, and to Security when the
   surface is security-sensitive.
4. **One-way doors go to Architecture** before implementation, not after.
5. **Research precedes commitment**, not the other way round. If a decision
   depends on a current external fact, the Research lane runs first.
6. **Continuity is not optional on multi-session work.** Checkpoint through
   `project-memory-continuity` at phase boundaries.

## Typical compositions

- **New mobile product** → Research → Product Strategy → Architecture → Figma →
  Mobile App Studio → QA → Security → Release → Growth
- **New game** → Product Strategy → Game Studio → Animation/VFX → QA → Release → Growth
- **Existing repo, unclear behaviour** → Engineering Intelligence → Architecture (if
  structural) → the relevant implementation lane → QA
- **Production incident** → Platform/SRE → Engineering Intelligence → QA
- **Auth, payments, or admin surface** → Architecture → Backend/Data → Security → QA
- **Marketing asset production** → Higgsfield Creative Director → Growth

## Adding skills from outside this pack

Skills installed from other repositories are routable on the same terms — put them
in the lane they own and keep the skill budget. Route to whatever is actually
installed; never assume a skill is present because it appears in a plan.

To make an external skill routable:

1. Install it (plugin marketplace where the repository supports it, otherwise a
   single canonical copy under a skills root).
2. Confirm it loads and that its `name` matches its folder.
3. Add it to the lane table above with a one-line statement of what it owns.

Keep one canonical copy of any skill. Two copies of the same skill in different
roots means selection can pick either one, and edits silently diverge.
