# Research Basis — NEXUS GODMODE MASTER

Research checked August 7, 2026.

## Claude Skills / Context Engineering

Anthropic reports that the strongest skills are narrowly useful, focus on non-obvious knowledge and gotchas,
and use the file system for progressive disclosure instead of stuffing everything into `SKILL.md`.

- https://claude.com/blog/lessons-from-building-claude-code-how-we-use-skills
- https://claude.com/blog/skills-explained
- https://claude.com/blog/steering-claude-code-skills-hooks-rules-subagents-and-more

## Subagents / Fresh Context

Anthropic recommends subagents for research-heavy side tasks, independent work, and fresh-perspective
verification because their intermediate context does not pollute the parent session.

- https://claude.com/blog/subagents-in-claude-code
- https://claude.com/blog/using-claude-code-session-management-and-1m-context

## Verification / Evals

Anthropic recommends eval-driven development for agent systems and combining code-based, model-based,
and human graders according to the property being measured.

- https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents

## Evaluator–Optimizer

Anthropic's agent guidance documents evaluator–optimizer as a useful workflow when criteria are clear and
iteration produces measurable gains.

- https://www.anthropic.com/engineering/building-effective-agents

## Tool Design

Agent tools should have clear scope, meaningful context, and token-efficient responses.

- https://www.anthropic.com/engineering/writing-tools-for-agents

## Innovation / Divergent-Convergent Thinking

The Design Council Double Diamond distinguishes exploration/divergence from definition/convergence,
then repeats that pattern for solution development and delivery/testing.

- https://www.designcouncil.org.uk/resources/the-double-diamond/
- https://www.designcouncil.org.uk/resources/framework-for-innovation/

## Prompt Caching / Efficiency

Claude Code's harness is designed around prompt caching and advises stable prefixes and deferred tool/context
loading rather than constantly mutating always-loaded instructions.

- https://claude.com/blog/lessons-from-building-claude-code-prompt-caching-is-everything
