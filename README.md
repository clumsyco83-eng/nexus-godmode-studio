# NEXUS GODMODE STUDIO

One GitHub-hosted Claude Code plugin containing **twenty professional specialist skills** in one organised folder.

The pack has two layers:

- **Nine studio directors** (`nexus-*`) — discipline-level product creation, from game and app development through design, creative, QA, release and growth.
- **Eleven core engineering skills** — orchestration, architecture, backend/data, platform/SRE, AI systems, security, research, continuity and context efficiency.

Every skill lives in its own folder with its own `SKILL.md`. Nothing is merged.

## Included skills

### Studio directors

- `nexus-aaa-game-studio` — Elite end-to-end game studio for auditing, designing, building, repairing, upgrading, optimizing, testing, and preparing original games for release.
- `nexus-aaa-mobile-app-studio` — Elite end-to-end mobile application studio for production-grade iOS and Android apps.
- `nexus-figma-design-director` — Figma product-design director for design systems, complete product flows, prototypes, and developer handoff.
- `nexus-higgsfield-creative-director` — Higgsfield creative director for storyboards, cinematic images and video, motion ads, UGC, and campaign-ready delivery.
- `nexus-animation-vfx-studio` — Animation, motion-design, technical-animation, and VFX studio for characters, UI, camera, particles, shaders, and game feel.
- `nexus-qa-testing-director` — Quality-engineering and testing director for risk-based strategy, automation, defects, performance, and release gates.
- `nexus-app-store-release-director` — Apple App Store and Google Play release director for builds, signing, store compliance, metadata, testing tracks, and rollout.
- `nexus-aso-growth-marketing` — App Store Optimization, growth, launch, and product-marketing studio.
- `nexus-ai-product-strategy` — AI product strategy, product management, business design, research, safety, and execution director.

### Core engineering and orchestration

- `nexus-godmode-master` — Meta-orchestrator for exceptionally complex, ambiguous, high-stakes, or invention-heavy work. Routes into the specialist skills rather than duplicating them.
- `godmode-v2` — Top-level delivery and orchestration skill: mission definition through planning, delegation, execution, verification, recovery, and handoff.
- `principal-architecture` — Principal-level software and systems architecture, sized to the current stage while preserving paths for growth.
- `engineering-intelligence` — Rapidly understand unfamiliar repositories, trace behaviour, perform root-cause debugging, and isolate regressions.
- `backend-data-engineer` — Production backend and data systems: APIs, databases, transactions, queues, caching, migrations, multi-tenancy, observability.
- `platform-sre-engineer` — Deploy, operate, observe, scale, and recover production services and infrastructure.
- `ai-systems-engineer` — Build, evaluate, harden, and operate production AI features and agentic systems.
- `security-guardian` — Defensive secure-design review, threat modeling, dependency assessment, and security hardening.
- `technology-research-scout` — Evidence-backed decision briefs on current libraries, frameworks, services, and platform rules.
- `project-memory-continuity` — Preserve high-signal project knowledge across sessions, compaction, handoffs, and multiple agents.
- `token-optimizer-v2` — Minimize token usage, context bloat, and noisy tool output without reducing correctness.

## Repository structure

```text
nexus-godmode-studio/
├── .claude-plugin/
│   └── marketplace.json          # marketplace entry pointing at plugins/nexus-godmode-studio
├── .claude/
│   └── skills/                   # generated mirror — auto-loads when working in THIS repo
│       ├── README.md
│       └── <20 skill folders>/SKILL.md
├── plugins/
│   └── nexus-godmode-studio/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       └── skills/               # SOURCE OF TRUTH — 20 skill folders
│           ├── README.md
│           ├── ai-systems-engineer/SKILL.md
│           ├── backend-data-engineer/SKILL.md
│           ├── engineering-intelligence/SKILL.md
│           ├── godmode-v2/SKILL.md
│           ├── nexus-aaa-game-studio/SKILL.md
│           ├── nexus-aaa-mobile-app-studio/SKILL.md
│           ├── nexus-ai-product-strategy/SKILL.md
│           ├── nexus-animation-vfx-studio/SKILL.md
│           ├── nexus-app-store-release-director/SKILL.md
│           ├── nexus-aso-growth-marketing/SKILL.md
│           ├── nexus-figma-design-director/SKILL.md
│           ├── nexus-godmode-master/SKILL.md
│           ├── nexus-higgsfield-creative-director/SKILL.md
│           ├── nexus-qa-testing-director/SKILL.md
│           ├── platform-sre-engineer/SKILL.md
│           ├── principal-architecture/SKILL.md
│           ├── project-memory-continuity/SKILL.md
│           ├── security-guardian/SKILL.md
│           ├── technology-research-scout/SKILL.md
│           └── token-optimizer-v2/SKILL.md
├── .github/workflows/
│   └── sync-nexus-project-skills.yml
├── CHANGELOG.md
├── CLAUDE.md
├── LICENSE
└── README.md
```

### Two copies, on purpose

`plugins/nexus-godmode-studio/skills/` is the **source of truth**. `.claude/skills/` is a
byte-identical **mirror** produced by the `Sync NEXUS Project Skills` workflow.

- The plugin copy is what people install from the marketplace.
- The mirror is what makes the skills load automatically for anyone who clones and works
  inside this repository, with no plugin installation.

Because both copies are live, **edit the plugin copy and re-run the sync workflow** (or apply
the same edit to both). A divergence between them is a bug, not a variant.

## How skills get used

There is no separate registration step. Claude Code discovers a skill when it finds
`<skills-root>/<skill-name>/SKILL.md` with valid YAML frontmatter, and selects it based on the
`description` field — which is why every description here states both what the skill does and
when to use it. The recognised skill roots are:

| Root | Scope |
| --- | --- |
| `~/.claude/skills/` | all of your projects |
| `<repo>/.claude/skills/` | that repository only |
| an installed plugin's `skills/` | wherever the plugin is enabled |

Keep the folder name and the frontmatter `name` identical — a mismatch makes the skill hard to
invoke by name and fails `claude plugin validate`.

## Install from GitHub

```text
/plugin marketplace add clumsyco83-eng/nexus-godmode-studio
/plugin install nexus-godmode-studio@nexus-studio-marketplace
/reload-plugins
```

You install the pack once. All twenty namespaced skills then become available as
`/nexus-godmode-studio:<skill-name>`.

## Global automatic skill selection

`.claude/skills` and an installed plugin make the skills *available*. Making Claude **choose**
them without being asked is a separate thing, and it lives in a memory file.

This repository ships the canonical template at [`global/CLAUDE.md`](global/CLAUDE.md). Install
it once per machine:

```bash
mkdir -p ~/.claude
curl -fsSL https://raw.githubusercontent.com/clumsyco83-eng/nexus-godmode-studio/main/global/CLAUDE.md \
  -o ~/.claude/CLAUDE.md
```

Already have a `~/.claude/CLAUDE.md`? Don't overwrite it — the template is wrapped in
`NEXUS skill-selection block` comment markers, so paste the block in and keep your own
instructions above or below it.

It tells Claude to understand the task, match it against **installed** skills, pick the
smallest sufficient set, route multi-stage work through `nexus-godmode-master` or `godmode-v2`,
keep `token-optimizer-v2` and `project-memory-continuity` on as cross-cutting support, and
verify substantial work through QA and security before calling it done. A repository's own
`CLAUDE.md` overrides it.

## Example commands

### Full-project orchestration

```text
/nexus-godmode-studio:nexus-godmode-master Take this repository from prototype to a verified, releasable product.
```

### Game project

```text
/nexus-godmode-studio:nexus-aaa-game-studio Audit this repository and upgrade the game into a polished production-quality mobile release.
```

### Mobile application

```text
/nexus-godmode-studio:nexus-aaa-mobile-app-studio Inspect this app, complete the core user journey, fix defects, and prepare a production-ready iOS and Android build.
```

### Architecture

```text
/nexus-godmode-studio:principal-architecture Review the current structure and propose the simplest architecture that still supports the next two stages of growth.
```

### Figma design

```text
/nexus-godmode-studio:nexus-figma-design-director Build a complete original design system and every required screen and state for this product.
```

### Higgsfield creative production

```text
/nexus-godmode-studio:nexus-higgsfield-creative-director Create a campaign brief, storyboard, shot bible, prompt package, variants, and strict creative QA plan for this app trailer.
```

### Animation and VFX

```text
/nexus-godmode-studio:nexus-animation-vfx-studio Audit and upgrade the animation, UI motion, camera feedback, particles, shaders, audio timing, accessibility, and performance.
```

### QA and testing

```text
/nexus-godmode-studio:nexus-qa-testing-director Build a risk-based test strategy, reproduce current defects, add regression coverage, and give a go or no-go verdict.
```

### Security review

```text
/nexus-godmode-studio:security-guardian Threat-model this feature and review authentication, authorization, secrets handling, and dependencies before release.
```

### Store release

```text
/nexus-godmode-studio:nexus-app-store-release-director Audit this release candidate and prepare everything required for owner submission to Apple App Store and Google Play.
```

### ASO and marketing

```text
/nexus-godmode-studio:nexus-aso-growth-marketing Create the positioning, ASO metadata, screenshot story, keyword strategy, launch plan, experiments, and retention framework.
```

### AI product strategy

```text
/nexus-godmode-studio:nexus-ai-product-strategy Validate this idea, research the competitive space, define the product wedge, MVP, AI architecture, business model, metrics, and roadmap.
```

## Test locally before GitHub installation

From the repository root, load the plugin folder directly:

```bash
claude --plugin-dir ./plugins/nexus-godmode-studio
```

Then validate it:

```bash
claude plugin validate ./plugins/nexus-godmode-studio
```

You can also test the plugin ZIP directly on Claude Code versions that support zipped local plugins.

## Update the installed pack

After pushing a new version to GitHub:

```text
/plugin marketplace update nexus-studio-marketplace
/reload-plugins
```

The version is currently `2.2.0`. Increase the version in **both**
`.claude-plugin/marketplace.json` and `plugins/nexus-godmode-studio/.claude-plugin/plugin.json`
when publishing a new release, and keep the two values equal.

## Important safety boundary

"GODMODE" means maximum professional rigor, initiative, and validation. The skills do not
instruct Claude Code to bypass permissions, hide failures, expose secrets, publish without
authorization, copy protected work, or claim unverified completion.
