# Third-party skills

Vendored on 2026-08-09 to complement the NEXUS GODMODE STUDIO skills. Each item remains in its own skill folder and retains its upstream license.

| Skill | Upstream source | License | Local status |
| --- | --- | --- | --- |
| `find-skills` | `vercel-labs/skills` — `skills/find-skills/SKILL.md` | MIT | Vendored without functional changes. |
| `verification-before-completion` | `obra/superpowers` — `skills/verification-before-completion/SKILL.md` | MIT | Vendored without functional changes. |
| `git-guardrails-claude-code` | `mattpocock/skills` — `skills/misc/git-guardrails-claude-code/` | MIT | Vendored skill plus hook script without functional changes. |
| `tdd` | `mattpocock/skills` — `skills/engineering/tdd/` | MIT | NEXUS-adapted: unresolved upstream cross-skill references were mapped to installed NEXUS specialists; supporting `tests.md` and `mocking.md` are vendored unchanged. |
| `webapp-testing` | `anthropics/skills` — `skills/webapp-testing/` | Apache-2.0 | Vendored skill, server helper, examples, and license. |
| `frontend-design` | `anthropics/skills` — `skills/frontend-design/` | Apache-2.0 | Vendored skill and license without functional changes. |

## Upstream revisions used

- `find-skills/SKILL.md`: blob `a41bdd074bb587afd861332cf2f473f3154de4d7`
- `verification-before-completion/SKILL.md`: blob `7d45333cc4a49c57a80df6c1fe2fa777a207afbc`
- `git-guardrails-claude-code/SKILL.md`: blob `d943c68219d0f47512f10c5018a11fd8358e9bb5`
- `git-guardrails-claude-code/scripts/block-dangerous-git.sh`: blob `c40b59cb47880fc9da8fe4179bd742f51f09d17d`
- `tdd/SKILL.md` upstream base: blob `ead7781d79eb11cdafa1ac2db978cadef0eba240`
- `tdd/tests.md`: blob `7ab86479f925a1f9e8ba680af33cb3b12e015381`
- `tdd/mocking.md`: blob `71cbfee674d93244ce81d1830b930ca9a69200bd`
- `webapp-testing/SKILL.md`: blob `4726215301db64a0cc4d41fc3219c61f37a30f4a`
- `webapp-testing/scripts/with_server.py`: blob `431f2eba16b268b7f3e2ae4daae9db41c0289b6d`
- `frontend-design/SKILL.md`: blob `decdff43d05908b4c1fc2cfd2d80fc5743440934`

## Why three earlier candidates were not vendored

The existing NEXUS pack already contains strong equivalents, so adding another copy would create overlapping trigger descriptions and competing workflows:

- `systematic-debugging` → covered by `engineering-intelligence`
- `improve-codebase-architecture` → covered by `principal-architecture`
- `brainstorming` → covered by `nexus-godmode-master` / `godmode-v2` for ambiguous, multi-phase planning and orchestration

This pack favors complementary capabilities over duplicate instructions.
