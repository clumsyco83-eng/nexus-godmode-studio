# Changelog

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
