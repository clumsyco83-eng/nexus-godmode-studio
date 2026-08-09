# Global instructions

<!-- ==========================================================================
     NEXUS skill-selection block — managed content.
     Safe to keep your own unrelated instructions above or below this block.
     Canonical source: clumsyco83-eng/nexus-godmode-studio -> global/CLAUDE.md
     ========================================================================== -->

## Automatic skill selection

**Select and use the relevant installed skills automatically. Do not wait to be told which
skill to use.** Naming a skill is an override, not a precondition. I should not have to say
"use skill X" for the right skill to be used.

At the start of any non-trivial task:

1. **Understand the task first.** Say what kind of work it is — research, design, backend,
   game, release, review — before reaching for anything.
2. **Look at what is actually installed.** Match the task against the available skills'
   descriptions. Route only to skills that are present; never assume a skill exists because
   it would be convenient, and never invent a skill name.
3. **Select the smallest sufficient set.** Usually one specialist. Two when the work genuinely
   spans two domains. More than two needs a stated reason.
4. **Say which skills you are using and why**, in one line, so I can correct the choice.

### Do not over-activate

Loading every skill is a failure mode, not thoroughness — it burns context and blurs the work.

- Never activate the whole roster.
- Skip skills entirely for trivial requests: a one-line edit, a quick factual answer, a
  mechanical rename, a direct question.
- Load a skill when you reach the phase that needs it, not at the start "just in case".
- Prefer the narrowest skill that covers the work over a broad orchestrator.

### Orchestration for multi-stage work

When the work is a whole feature, product, migration, repository overhaul, or release —
anything with several phases and real ambiguity — start at the orchestration layer and let it
route:

- `nexus-godmode-master` — the most complex, ambiguous, high-stakes, or invention-heavy work.
- `godmode-v2` — ordinary end-to-end delivery that still needs planning, delegation and
  verification.

The orchestrator picks specialists per phase. It does not do the specialists' work itself, and
it does not hold every specialist open at once.

For a single well-defined task, skip the orchestrator and go straight to the specialist.

### Cross-cutting skills

- `token-optimizer-v2` — engage on long sessions, large repositories, expensive tool loops, or
  whenever context is filling up. Apply narrow-first context loading and delta inspection.
- `project-memory-continuity` — engage when work will continue past this session, when resuming
  earlier work, or when decisions need to survive compaction and handoff. Checkpoint at phase
  boundaries.

These two support the others; they are not a substitute for a specialist.

### Verification is a separate step

The skill that produced the work does not certify it. Before calling substantial work done:

- `nexus-qa-testing-director` — does it actually work? Tests, coverage, regressions, release gates.
- `security-guardian` — auth, payments, admin, public APIs, secrets, dependencies, cloud/CI changes.
- `resolve-reviews` (from `agent-reviews`, if installed) — have review findings been addressed?

Report verification honestly. If tests fail, say so with the output. If a step was skipped, say
which and why.

### Routing map

Route to whichever of these are installed. Slugs are what resolve.

| Work | Skill |
| --- | --- |
| Large or ambiguous end-to-end outcome | `nexus-godmode-master`, `godmode-v2` |
| Current libraries, vendors, pricing, deprecations | `technology-research-scout` |
| Structure, boundaries, one-way-door decisions | `principal-architecture` |
| Idea validation, MVP scope, roadmap, metrics | `nexus-ai-product-strategy` |
| Unfamiliar code, hard bugs, regressions | `engineering-intelligence` |
| APIs, schemas, queries, migrations, queues | `backend-data-engineer` |
| Deploys, infra, observability, incidents | `platform-sre-engineer` |
| LLM/agent features, RAG, evals, guardrails | `ai-systems-engineer` |
| Screens, design systems, prototypes, handoff | `nexus-figma-design-director` |
| Polish/review frontend that already exists | `impeccable` |
| iOS/Android app work | `nexus-aaa-mobile-app-studio` |
| Game work of any kind | `nexus-aaa-game-studio` |
| Animation, motion, VFX, game feel | `nexus-animation-vfx-studio` |
| Cinematic images/video, ads, storyboards, UGC | `nexus-higgsfield-creative-director` |
| Test strategy, coverage, release gates | `nexus-qa-testing-director` |
| Auth, payments, admin, public APIs, pre-release review | `security-guardian` |
| Pull-request review findings | `resolve-reviews` |
| Store submission, signing, metadata, rollout | `nexus-app-store-release-director` |
| ASO, positioning, launch, growth, retention | `nexus-aso-growth-marketing` |
| Work continuing across sessions | `project-memory-continuity` |
| Long sessions, large repos, expensive tool loops | `token-optimizer-v2` |
| Word/Excel/PowerPoint/PDF deliverables | `docx`, `xlsx`, `pptx`, `pdf` |
| Creating or editing a skill | `skill-creator` |

Typical compositions:

- **New mobile product** → research → product strategy → architecture → Figma → mobile app
  studio → QA → security → release → growth
- **New game** → product strategy → game studio → animation/VFX → QA → release
- **Existing repo, unclear behaviour** → engineering intelligence → architecture if structural
  → the implementation lane → QA
- **Improve a built UI** → Figma design director + `impeccable`
- **Review a pull request** → `resolve-reviews` + security where the diff touches a sensitive surface
- **Choose an architecture** → `technology-research-scout` → `principal-architecture`

## Reports and deliverables

**Whenever you produce a report, audit, review, plan, or similar written deliverable, deliver a
PDF as well — without being asked.** Standing preference, not a per-request option.

The pattern:

1. Build the report as an artifact and publish it, so there is a live link.
2. Convert the same source to PDF with
   [`global/report-to-pdf.sh`](https://github.com/clumsyco83-eng/nexus-godmode-studio/blob/main/global/report-to-pdf.sh)
   — one canonical source, two formats, no divergence.
3. Send the PDF as a file, and give the artifact link alongside it.

Verify the PDF before sending: page count, page size, and that the text is **extractable**, not
an image scan. `report-to-pdf.sh` fails loudly if extraction yields almost no words. Render a
page or two and actually look at them — layout defects (empty grid cells, clipped tables, split
cards) are invisible in the source and obvious in the render.

If a conversion or verification step fails, say so and hand over what does exist. Never describe
a PDF as delivered without having verified it.

### Project instructions win

A repository's own `CLAUDE.md` overrides this file. Project-specific skills — a repo's release
workflow, its commit conventions, its own CLI documentation — stay project-specific and are not
used outside that repository.

<!-- ================= end NEXUS skill-selection block ================= -->
