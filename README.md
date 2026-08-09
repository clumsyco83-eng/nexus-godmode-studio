# NEXUS GODMODE STUDIO

One GitHub-hosted Claude Code plugin containing **twenty-six professional specialist skills** in one organised folder.

The pack has three layers:

- **Nine studio directors** (`nexus-*`) — discipline-level product creation, from game and app development through design, creative, QA, release and growth.
- **Eleven core engineering skills** — orchestration, architecture, backend/data, platform/SRE, AI systems, security, research, continuity and context efficiency.
- **Six vetted specialist additions** — skill discovery, evidence-before-completion, Git safety, TDD, Playwright webapp testing, and distinctive implemented frontend design.

Every skill lives in its own folder with its own `SKILL.md`. Nothing is merged into one giant prompt.

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

### Vetted specialist additions

- `find-skills` — Discover high-quality agent skills when a genuinely new specialist capability is needed.
- `verification-before-completion` — Require fresh command/test/build evidence before making completion claims.
- `git-guardrails-claude-code` — Configure Claude Code hooks to block dangerous Git operations before execution.
- `tdd` — Behavior-focused test-driven development using red → green vertical slices; adapted to route architecture/review dependencies into existing NEXUS skills.
- `webapp-testing` — Anthropic Playwright toolkit for local web applications, screenshots, browser logs, and server lifecycle management.
- `frontend-design` — Anthropic guidance for distinctive, intentional implemented frontend design rather than templated AI-looking UI.

Third-party sources, revisions, modifications, and per-skill licenses are documented in [`plugins/nexus-godmode-studio/THIRD_PARTY_SKILLS.md`](plugins/nexus-godmode-studio/THIRD_PARTY_SKILLS.md).

Three earlier candidates were deliberately not duplicated because NEXUS already has clear owners for those jobs: `systematic-debugging` → `engineering-intelligence`, `improve-codebase-architecture` → `principal-architecture`, and `brainstorming` → `nexus-godmode-master` / `godmode-v2`.

## Repository structure

```text
nexus-godmode-studio/
├── .claude-plugin/
│   └── marketplace.json          # marketplace entry pointing at plugins/nexus-godmode-studio
├── .claude/
│   └── skills/                   # generated mirror — auto-loads when working in THIS repo
│       ├── README.md
│       └── <26 skill folders>/SKILL.md
├── plugins/
│   └── nexus-godmode-studio/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── THIRD_PARTY_SKILLS.md
│       └── skills/               # SOURCE OF TRUTH — 26 skill folders
│           ├── README.md
│           ├── ai-systems-engineer/SKILL.md
│           ├── backend-data-engineer/SKILL.md
│           ├── engineering-intelligence/SKILL.md
│           ├── find-skills/SKILL.md
│           ├── frontend-design/SKILL.md
│           ├── git-guardrails-claude-code/SKILL.md
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
│           ├── tdd/SKILL.md
│           ├── technology-research-scout/SKILL.md
│           ├── token-optimizer-v2/SKILL.md
│           ├── verification-before-completion/SKILL.md
│           └── webapp-testing/SKILL.md
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

You install the pack once. All twenty-six namespaced skills then become available as
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

## Installing skills from repos that have no plugin manifest

Some good skill repositories ship `skills/` but no `.claude-plugin/` manifest, so
`/plugin marketplace add` cannot install them. Copying the folders into `~/.claude/skills/`
works but creates a second copy that drifts from upstream and never updates.

[`global/install-external-skills.sh`](global/install-external-skills.sh) avoids that: it clones
each upstream **once** into `~/src`, then symlinks the individual skill folders into
`~/.claude/skills/`. One canonical source, updated with `git pull`, no duplicated files.
Claude Code follows those symlinks — verified.

```bash
./global/install-external-skills.sh --list     # show what would be linked
./global/install-external-skills.sh            # install or update
./global/install-external-skills.sh --remove   # remove only its own symlinks
```

It refuses to replace anything that is not a symlink it created, so an existing real skill
folder is never clobbered. Add more repositories by extending the `REPOS` array.

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

### Frontend design implementation

```text
/nexus-godmode-studio:frontend-design Give this implemented interface a distinctive visual identity, deliberate typography and layout, responsive polish, and a rigorous self-critique.
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

### Test-driven development

```text
/nexus-godmode-studio:tdd Implement this behavior test-first using a red → green vertical-slice loop through the public interface.
```

### Local webapp testing

```text
/nexus-godmode-studio:webapp-testing Launch the local app if needed, inspect the rendered UI with Playwright, exercise the critical journey, capture screenshots and browser logs, and report reproducible failures.
```

### Verification before completion

```text
/nexus-godmode-studio:verification-before-completion Verify the tests, build, and original failure path with fresh evidence before claiming this work is complete.
```

### Git safety hooks

```text
/nexus-godmode-studio:git-guardrails-claude-code Set up project-level Claude Code guardrails that block dangerous Git operations before they execute.
```

### Find another specialist skill

```text
/nexus-godmode-studio:find-skills Find a reputable skill for this capability, verify its source and quality, and show me the safest install option.
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

The version is currently `2.4.0`. Increase the version in **both**
`.claude-plugin/marketplace.json` and `plugins/nexus-godmode-studio/.claude-plugin/plugin.json`
when publishing a new release, and keep the two values equal.

## Important safety boundary

"GODMODE" means maximum professional rigor, initiative, and validation. The skills do not
instruct Claude Code to bypass permissions, hide failures, expose secrets, publish without
authorization, copy protected work, or claim unverified completion.
