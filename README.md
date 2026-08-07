# NEXUS GODMODE STUDIO

One GitHub-hosted Claude Code plugin containing **nine professional specialist skills** in one organised folder.

## Included skills

- `/nexus-godmode-studio:nexus-aaa-game-studio` — **AAA Game Studio Director**: Games, gameplay, art, systems, optimization, and release preparation.
- `/nexus-godmode-studio:nexus-aaa-mobile-app-studio` — **AAA Mobile App Studio Director**: Production-grade iOS and Android product development.
- `/nexus-godmode-studio:nexus-figma-design-director` — **Figma Design Director**: Design systems, complete product flows, prototypes, and handoff.
- `/nexus-godmode-studio:nexus-higgsfield-creative-director` — **Higgsfield Creative Director**: Cinematic images, videos, ads, UGC, storyboards, and creative QA.
- `/nexus-godmode-studio:nexus-animation-vfx-studio` — **Animation & VFX Studio Director**: Character, UI, camera, particles, shaders, game feel, and performance.
- `/nexus-godmode-studio:nexus-qa-testing-director` — **QA & Testing Director**: Risk-based testing, automation, defects, performance, and release gates.
- `/nexus-godmode-studio:nexus-app-store-release-director` — **App Store & Google Play Release Director**: Builds, store compliance, metadata, testing tracks, rollout, and launch.
- `/nexus-godmode-studio:nexus-aso-growth-marketing` — **ASO & Growth Marketing Director**: Positioning, store optimization, creative testing, funnels, and growth.
- `/nexus-godmode-studio:nexus-ai-product-strategy` — **AI Product Strategy Director**: Validation, differentiation, AI suitability, MVP, metrics, and roadmap.

## Repository structure

```text
nexus-godmode-studio/
├── .claude-plugin/
│   └── marketplace.json
├── plugins/
│   └── nexus-godmode-studio/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       └── skills/
            ├── nexus-aaa-game-studio/SKILL.md
            ├── nexus-aaa-mobile-app-studio/SKILL.md
            ├── nexus-figma-design-director/SKILL.md
            ├── nexus-higgsfield-creative-director/SKILL.md
            ├── nexus-animation-vfx-studio/SKILL.md
            ├── nexus-qa-testing-director/SKILL.md
            ├── nexus-app-store-release-director/SKILL.md
            ├── nexus-aso-growth-marketing/SKILL.md
            └── nexus-ai-product-strategy/SKILL.md
├── CHANGELOG.md
├── LICENSE
└── README.md
```

## Before uploading to GitHub

Replace these placeholders in `.claude-plugin/marketplace.json` and `plugins/nexus-godmode-studio/.claude-plugin/plugin.json`:

- `YOUR_NAME`
- `YOUR_GITHUB_USERNAME`

Create one GitHub repository named:

```text
nexus-godmode-studio
```

Upload the **contents of this folder** so `README.md`, `.claude-plugin`, and `plugins` appear at the repository root.

## Install from GitHub

Replace `YOUR_GITHUB_USERNAME` with the repository owner:

```text
/plugin marketplace add YOUR_GITHUB_USERNAME/nexus-godmode-studio
/plugin install nexus-godmode-studio@nexus-studio-marketplace
/reload-plugins
```

You install the pack once. All nine namespaced skills then become available.

## Example commands

### Game project

```text
/nexus-godmode-studio:nexus-aaa-game-studio Audit this repository and upgrade the game into a polished production-quality mobile release.
```

### Mobile application

```text
/nexus-godmode-studio:nexus-aaa-mobile-app-studio Inspect this app, complete the core user journey, fix defects, and prepare a production-ready iOS and Android build.
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

The version is currently `2.0.0`. Increase the version in both JSON files when publishing a new release.

## Important safety boundary

“GODMODE” means maximum professional rigor, initiative, and validation. The skills do not instruct Claude Code to bypass permissions, hide failures, expose secrets, publish without authorization, copy protected work, or claim unverified completion.
