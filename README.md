# NEXUS GODMODE STUDIO

One GitHub-hosted Claude Code plugin containing **twenty-seven complementary professional skills**.

The pack has three layers:

- **Nine studio directors** — game, mobile app, Figma, Higgsfield creative, animation/VFX, QA, store release, ASO/growth, and AI product strategy.
- **Twelve NEXUS intelligence/engineering/orchestration skills** — including the new `gary-intelligence-core` for difficult reasoning, research, decision quality and engineering judgment.
- **Six vetted specialist additions** — skill discovery, evidence-before-completion, Git safety, TDD, Playwright webapp testing, and implemented frontend design.

Every skill lives in its own folder with its own `SKILL.md`. Nothing is merged into one giant prompt.

## Intelligence layer

### `gary-intelligence-core`

The cognitive-quality supervisor. Use it when the hard part is not merely executing work, but determining:

- what the real question is,
- which assumptions are fragile,
- what evidence is decisive,
- which of several plausible options is strongest,
- what could make the leading answer wrong,
- how confident the conclusion should be,
- what would cause the recommendation to change.

It uses decision framing, an assumption ledger, competing hypotheses/options, evidence planning,
triangulation, adversarial review, engineering failure-mode analysis, confidence calibration, a
recommendation falsifier, and independent verification.

It does **not** replace the execution specialists. For multi-phase delivery,
`nexus-godmode-master` / `godmode-v2` still orchestrate the work; Gary Intelligence Core enters
only when uncertainty or judgment is the bottleneck.

Example:

```text
/nexus-godmode-studio:gary-intelligence-core Research and stress-test the best architecture for this product. Separate facts from assumptions, compare credible alternatives, identify failure modes, give calibrated confidence, and tell me what evidence would change the recommendation.
```

## Included skills

### Studio directors

- `nexus-aaa-game-studio`
- `nexus-aaa-mobile-app-studio`
- `nexus-figma-design-director`
- `nexus-higgsfield-creative-director`
- `nexus-animation-vfx-studio`
- `nexus-qa-testing-director`
- `nexus-app-store-release-director`
- `nexus-aso-growth-marketing`
- `nexus-ai-product-strategy`

### Core intelligence, engineering and orchestration

- `gary-intelligence-core` — difficult reasoning, research synthesis, adversarial review, decision quality and engineering judgment.
- `nexus-godmode-master` — complex multi-phase orchestration across specialists.
- `godmode-v2` — structured end-to-end delivery and verification.
- `principal-architecture` — software/system architecture and long-term structural decisions.
- `engineering-intelligence` — repository understanding, behavior tracing, root-cause debugging and regressions.
- `backend-data-engineer` — APIs, databases, transactions, queues, caching and migrations.
- `platform-sre-engineer` — CI/CD, infrastructure, observability, SLOs, incidents and recovery.
- `ai-systems-engineer` — production LLM/agent systems, RAG, tools, evals, guardrails, cost and latency.
- `security-guardian` — threat modeling, secure design, code/dependency review and hardening.
- `technology-research-scout` — current technical evidence, libraries, vendors, services and platform rules.
- `project-memory-continuity` — durable project state across sessions, compaction and handoff.
- `token-optimizer-v2` — lower context/token cost without lowering correctness or verification.

### Vetted specialist additions

- `find-skills` — discover reputable new specialist skills when a genuine capability gap exists.
- `verification-before-completion` — fresh evidence before success/completion claims.
- `git-guardrails-claude-code` — Claude Code hooks that block dangerous Git operations.
- `tdd` — behavior-focused red → green test-driven development.
- `webapp-testing` — Anthropic Playwright-based local webapp testing toolkit.
- `frontend-design` — Anthropic guidance for distinctive implemented UI rather than templated AI-looking design.

Third-party sources, revisions, modifications and licenses are recorded in
[`plugins/nexus-godmode-studio/THIRD_PARTY_SKILLS.md`](plugins/nexus-godmode-studio/THIRD_PARTY_SKILLS.md).
`gary-intelligence-core` is original NEXUS pack content, not a vendored third-party skill.

## Avoided duplicates

The pack deliberately does not vendor these earlier candidates because existing NEXUS lanes
already own their core jobs:

- `systematic-debugging` → `engineering-intelligence`
- `improve-codebase-architecture` → `principal-architecture`
- `brainstorming` → `nexus-godmode-master` / `godmode-v2`

Gary Intelligence Core is different: it supervises **decision quality under uncertainty** and
routes to these specialists rather than duplicating their implementation workflows.

## Repository layout

```text
nexus-godmode-studio/
├── .claude-plugin/
│   └── marketplace.json
├── .claude/
│   └── skills/                   # generated project mirror
├── plugins/
│   └── nexus-godmode-studio/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── THIRD_PARTY_SKILLS.md
│       └── skills/               # SOURCE OF TRUTH — 27 skill folders
│           ├── README.md
│           ├── gary-intelligence-core/SKILL.md
│           └── <26 other skill folders>/...
├── global/
│   ├── CLAUDE.md                 # automatic skill-selection template
│   └── install-external-skills.sh
├── .github/workflows/
│   └── sync-nexus-project-skills.yml
├── CHANGELOG.md
├── CLAUDE.md
├── LICENSE
└── README.md
```

`plugins/nexus-godmode-studio/skills/` is the source of truth. The GitHub Action refreshes
`.claude/skills/` after source-skill changes on `main`.

## Install from GitHub

In Claude Code:

```text
/plugin marketplace add clumsyco83-eng/nexus-godmode-studio
/plugin install nexus-godmode-studio@nexus-studio-marketplace
/reload-plugins
```

Install the pack once. All twenty-seven namespaced skills become available as:

```text
/nexus-godmode-studio:<skill-name>
```

If the pack is already installed after a new release:

```text
/plugin marketplace update nexus-studio-marketplace
/reload-plugins
```

## Global automatic skill selection

Installing the plugin makes skills available. Automatic selection is controlled by the canonical
[`global/CLAUDE.md`](global/CLAUDE.md) template.

It tells Claude to:

- understand the task before choosing skills,
- use the smallest sufficient skill set,
- invoke `gary-intelligence-core` when judgment under uncertainty is the bottleneck,
- use NEXUS orchestrators for multi-phase delivery,
- route implementation to the narrowest specialist,
- use `token-optimizer-v2` and `project-memory-continuity` only when needed,
- require independent QA/security/verification before consequential completion claims.

A repository's own `CLAUDE.md` can override global instructions.

## Skill routing examples

### Difficult research / technical decision

```text
/nexus-godmode-studio:gary-intelligence-core Determine the strongest approach, challenge the assumptions, triangulate the evidence, compare alternatives, identify the dominant trade-off, calibrate confidence, and state what would change the answer.
```

### Full project

```text
/nexus-godmode-studio:nexus-godmode-master Take this repository from prototype to a verified, releasable product and route each phase to the minimum necessary specialist.
```

### Architecture

```text
/nexus-godmode-studio:principal-architecture Review the current structure and propose the simplest architecture that supports the next stages of growth.
```

### Debugging / code archaeology

```text
/nexus-godmode-studio:engineering-intelligence Reproduce the problem, trace the behavior, identify the root cause, make the smallest evidence-based repair, and establish a regression signal.
```

### QA / completion evidence

```text
/nexus-godmode-studio:nexus-qa-testing-director Build a risk-based test strategy and give a go/no-go verdict.
/nexus-godmode-studio:verification-before-completion Require fresh test/build/runtime evidence before claiming the work is complete.
```

## Local validation

From the repository root:

```bash
claude --plugin-dir ./plugins/nexus-godmode-studio
claude plugin validate ./plugins/nexus-godmode-studio
```

Validation should be performed on the real Claude Code installation before treating a release as
fully runtime-verified.

## Current version

`2.5.0`

Keep the version equal in both:

- `.claude-plugin/marketplace.json`
- `plugins/nexus-godmode-studio/.claude-plugin/plugin.json`

## Safety boundary

"GODMODE" and "Intelligence Core" mean stronger rigor, initiative, research discipline,
engineering judgment and verification. They do not authorize bypassing permissions, exposing
secrets, publishing without authorization, hiding failures, or claiming certainty without evidence.
