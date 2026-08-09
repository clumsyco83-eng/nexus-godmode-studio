# Changelog

## 2.5.0

- Added `gary-intelligence-core`, an original cognitive-quality supervisor for difficult reasoning, research, technical decisions, adversarial review, confidence calibration, and engineering judgment.
- Defined a ten-phase intelligence loop: decision lock, assumption ledger, option set, evidence plan, triangulation, adversarial pass, engineering reality check, decision comparison, confidence calibration, and independent verification.
- Added explicit routing boundaries so Gary Intelligence Core improves judgment under uncertainty without duplicating `nexus-godmode-master`, `engineering-intelligence`, `principal-architecture`, `technology-research-scout`, QA, or security workflows.
- Added research stopping rules, source hierarchy, claim-evidence discipline, recommendation falsifiers, and token/context controls.
- Updated the global skill router so hard decisions can enter Gary Intelligence Core while routine execution remains on the narrowest specialist.
- Expanded the pack from twenty-six to twenty-seven skills and bumped marketplace/plugin metadata together to `2.5.0`.

## 2.4.0

- Expanded NEXUS GODMODE STUDIO from twenty to twenty-six complementary skills.
- Added `find-skills` from Vercel Labs for discovering reputable specialist skills when the current pack lacks a capability.
- Added `verification-before-completion` from obra/superpowers to require fresh evidence before success or completion claims.
- Added `git-guardrails-claude-code` from Matt Pocock, including its dangerous-Git blocking hook script.
- Added `tdd` from Matt Pocock with its test and mocking references; locally adapted unresolved cross-skill references to installed NEXUS specialists.
- Added Anthropic `webapp-testing` with its Playwright server helper, examples, and Apache-2.0 license.
- Added Anthropic `frontend-design` with its Apache-2.0 license for stronger implemented visual design.
- Deliberately did not duplicate `systematic-debugging`, `improve-codebase-architecture`, or `brainstorming`; existing NEXUS skills already own those workflows.
- Added `THIRD_PARTY_SKILLS.md` with upstream repositories, revisions, modification status, and licensing details.
- Bumped marketplace and plugin metadata together to `2.4.0`.

## 2.2.0

- Specialist Router now lists every skill by its exact slug. Ten entries previously appeared
  only under a display name, and the slug is what actually resolves.
- Mapped two external plugins into existing lanes without merging them: `impeccable` into
  UI/UX (reviewing built frontend, complementing the Figma director) and `agent-reviews` into
  Verification (pull-request review findings, complementing the QA director). Both are marked
  external and must be confirmed installed before routing.
- Folded `when_to_use` into `description` on the nine skills that used it. The non-standard key
  worked on this harness but was a portability risk; the merged text is identical, so skill
  selection is unchanged. Longest merged description is 758 characters against the 1024 limit.

## 2.1.0

- Corrected metadata to reflect the twenty skills actually shipped (nine studio directors plus eleven core engineering and orchestration skills); previous metadata still described nine.
- Fixed `godmode-v2` frontmatter `name` (was `godmode`) and `token-optimizer-v2` frontmatter `name` (was `token-optimizer`) so each matches its folder.
- Replaced the `YOUR_NAME` placeholders in `marketplace.json` with the real owner, and added homepage, repository, and license fields to the marketplace plugin entry.
- Aligned `plugin.json` version with `marketplace.json` (both were out of step at `1.0.0` and `2.0.0`).
- Documented the two-copy layout: `plugins/nexus-godmode-studio/skills/` is the source of truth and `.claude/skills/` is its generated mirror.
- Rewrote the root README and skill index to cover all twenty skills, and added `CLAUDE.md`.

## 2.0.0

- Expanded NEXUS GODMODE STUDIO from one skill to nine specialist skills.
- Added mobile app, Figma, Higgsfield, animation/VFX, QA, release, ASO/growth, and AI product strategy directors.
- Updated marketplace and plugin metadata.
- Added complete installation, validation, usage, and update instructions.

## 1.0.0

- Initial AAA Game Studio Director skill.
