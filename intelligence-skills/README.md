# NEXUS Intelligence Foundation

Eight skills that give NEXUS a reliable relationship with the truth: what it remembers, what it looks
up, how it checks, and how honestly it reports what it does not know.

**Version 1.0.0 · Created 2026-08-11 · Status: skill definitions created, nothing installed or
activated.**

---

## Why this exists

An AI assistant that is confidently wrong is worse than one that says "I don't know". The three ways
it goes confidently wrong are all failures of epistemics, not intelligence:

1. **It confuses a plan with a fact.** Somebody decided to build a feature; six weeks later the
   assistant says the feature exists, because a note says so.
2. **It uses information that expired.** A fee, a policy, an API requirement, a permission — true when
   learned, false now, restated with full confidence.
3. **It believes the first plausible thing it read.** One source, no corroboration, no idea whether
   the source was authoritative, recent, or even real.

These eight skills are the machinery that stops each of those. Nothing here makes the model smarter.
It makes the model *disciplined*: every claim carries a state, every state carries evidence, and no
claim is allowed to quietly gain confidence it did not earn.

**The single most important rule in the whole system:** an assumption never becomes a verified fact
by being repeated, restated, summarised, or left unchallenged. Confidence rises only when new
evidence is attached — and the evidence is named.

---

## How the eight work together

Each skill does one job and refuses the others. That refusal is the design: overlapping
responsibilities are how a system loses track of who decided what.

| # | Skill | The one question it answers |
| --- | --- | --- |
| 01 | **Memory Intelligence** | What do *we* know about this project, and how sure are we? |
| 02 | **Knowledge Intelligence** | What do we know about the *world*, and is it still good enough? |
| 03 | **Deep Research** | If we don't know, how do we find out properly? |
| 04 | **Source Verification** | How much can this particular source be trusted for this particular claim? |
| 05 | **Freshness Intelligence** | Is this still true *now*, and how badly would it hurt to be wrong? |
| 06 | **Universal Retrieval** | Where should we look, and what is the least we need to fetch? |
| 07 | **Contradiction & Fact-Check** | These two things disagree — which one is right, and can we tell? |
| 08 | **Intelligence Router** | Which of the above does this question actually need? |

Skill 08 is the one you never have to think about. It reads the question, decides which of the other
seven are worth running, and runs them in the right order at a sensible cost. You never say "use the
memory skill" — that is precisely what it is for.

### The pipeline

```
                              QUESTION
                                 │
                    ┌────────────▼────────────┐
                    │  08  INTELLIGENCE ROUTER│  classify · pick profile · set budget
                    └────────────┬────────────┘
                                 │
              ┌──────────────────┴──────────────────┐
              │                                     │
     ┌────────▼────────┐                  ┌─────────▼────────┐
     │  01  MEMORY     │                  │  06  RETRIEVAL   │   run together
     │  what we decided│                  │  where to look   │
     └────────┬────────┘                  └─────────┬────────┘
              │                                     │
              └──────────────────┬──────────────────┘
                                 │
                      ┌──────────▼──────────┐
                      │  05  FRESHNESS      │   is it still true?
                      └──────────┬──────────┘
                                 │
                      ┌──────────▼──────────┐
                      │  02  KNOWLEDGE      │   do we have a gap?
                      └──────────┬──────────┘
                                 │  gap? yes
                      ┌──────────▼──────────┐
                      │  03  DEEP RESEARCH  │   find out properly
                      └──────────┬──────────┘
                                 │  per source
                      ┌──────────▼──────────┐
                      │  04  SOURCE VERIFY  │   can this be trusted?
                      └──────────┬──────────┘
                                 │
                      ┌──────────▼──────────┐
                      │  07  CONTRADICTION  │   does anything disagree?
                      └──────────┬──────────┘
                                 │
                      ┌──────────▼──────────┐
                      │      SYNTHESIS      │   08 assembles
                      └──────────┬──────────┘
                                 │
                      ┌──────────▼──────────┐
                      │   NEXUS VERIFIER    │   external · not yet built
                      └──────────┬──────────┘
                                 │
                      ┌──────────▼──────────┐
                      │  ANSWER + CONFIDENCE│   + what we still don't know
                      └──────────┬──────────┘
                                 │  only if VERIFIED and durable
                      ┌──────────▼──────────┐
                      │  MEMORY UPDATE      │   proposal to 01 / 02
                      └─────────────────────┘
```

Most questions never reach the bottom. That is the point — the router's job is as much about *not*
running skills as running them.

---

## Example workflows

**"What is 2 + 2?"**
Router classifies: no evidence needed. Zero skills run. Answer: 4.
*If this question triggered a research pipeline, the system would be broken.*

**"What did we decide about Etsy?"**
Router → memory + retrieval. Two calls. Returns the decision, its rationale, its date, and — if there
is no such decision — says so plainly rather than reconstructing a plausible one.

**"What is Etsy's current digital-product policy?"**
Router → freshness first (is what we stored still good?) → knowledge (do we have a gap?) → retrieval
→ source verification. If the stored answer is fresh, it stops after two calls and never touches the
web.

**"Is NEXUS Phase 1F enabled?"**
This is the question the whole system exists for. It routes to *three* places at once: memory (what
we decided), the repository (what the code says), the runtime (what is actually live). Then the
contradiction skill compares them. The honest answer is usually layered — *"decided, partly built,
not enabled"* — and any single source would have given a confident wrong answer.

**"What product should we sell next month?"**
The full pipeline. Prior decisions and constraints from memory; market, competitor and customer
research; every source scored; every fact freshness-checked; contradictions against past decisions
surfaced. The output separates **verified facts**, **inferences**, and **recommendation** into three
labelled layers — so you can disagree with the recommendation without discarding the facts.

**"Quick one — can I just delete the old branch?"**
Short question, irreversible action. Routes to the highest-stakes profile regardless of how casually
it was asked. Calling something a quick question does not change what happens if it is wrong.

---

## The vocabulary

Every claim carries exactly one of these. They are the shared language of all eight skills:

| State | Means |
| --- | --- |
| `VERIFIED` | Checked against primary evidence, and currently fresh |
| `HIGH_CONFIDENCE` | Strong corroborated evidence, one step short of verified |
| `LIKELY` | Reasonable evidence, real gaps remain |
| `ASSUMED` | A working assumption, stated so work can continue — never dressed as fact |
| `UNKNOWN` | We looked and did not find it |
| `STALE` | Was true when checked; the window has expired |
| `SUPERSEDED` | Replaced by something newer and verified — kept, never deleted |
| `CONFLICTING` | Two things disagree and we cannot yet tell which is right |
| `PLANNED` | Intended. Not a fact about the present |

Full definitions, the legal transitions between them, and the evidence gates each requires are in
[SHARED-PRINCIPLES.md](SHARED-PRINCIPLES.md).

---

## Two ideas worth understanding

**Risk shortens the freshness window.** A fact's shelf life is not just about how fast the world
changes — it is about what happens if you are wrong. The same nine-day-old fee figure is perfectly
usable in a planning conversation and unusable for setting live prices, because the consequence of
being wrong differs by an order of magnitude. The arithmetic is deterministic and shown every time.

**Nothing is deleted.** When something changes, the old record is marked `SUPERSEDED` and kept, with
its original evidence intact. This matters more than it looks: the old value explains behaviour in
old logs, and a supersession chain makes tampering visible. A system that overwrites history cannot
tell the difference between "this changed" and "someone changed this".

---

## What is actually implemented

The project's own rule applies to the project itself: a plan is not a fact.

### ✅ SKILL DEFINITION CREATED — verified to exist

- Eight skill folders, each with `SKILL.md` (all 27 required sections) and `TESTS.md`.
- Shared principles, manifest, this README, a validator and an installer.
- 16 test cases per skill; 30 routing scenarios for the router.
- Frontmatter validated against the Agent Skills standard.
- No secrets anywhere in the tree.

### ⏳ RUNTIME CAPABILITY — not implemented

- **There is no memory store.** Skill 01 specifies a schema and lifecycle for something that does not
  exist yet. Until it does, "memory" means whatever the host environment provides.
- **There is no knowledge store.** Same.
- **Nothing is enforced in code.** State transitions, confidence gates and freshness arithmetic are
  instructions to a model, not validated invariants. A model that ignores them will not be stopped.
- **There is no test runner.** `TESTS.md` files are rubrics for manual or LLM-judged evaluation.
- **Nothing has been executed.** No test case has been run against any model.

### ❓ UNVERIFIED — asserted, not checked

**Every NEXUS runtime integration.** Guardian, Watchdog, approval gates, GREEN/YELLOW/RED, Verifier,
workspace restrictions and emergency stop **do not exist in this repository** and were not inspected
while writing these skills. The integration sections describe contracts the skills promise to honour,
written so they fail safe if the components are absent. They are not descriptions of tested behaviour,
and no skill should claim these integrations work until they are tested against the real runtime.

---

## Installation concept

**Nothing is installed. Nothing is activated.** The skills live in `intelligence-skills/`, which is
not a directory any skill loader reads — so they cannot fire by accident.

To validate them in place:

```bash
cd intelligence-skills
./validate.sh
```

When you decide to activate them, `install.sh` copies them into the plugin skills directory, stripping
the numeric prefixes so each folder name matches its `name` exactly:

```bash
./install.sh --dry-run     # show what would happen
./install.sh               # copy into plugins/nexus-godmode-studio/skills/
```

After installing, follow this repository's `CLAUDE.md`: re-run the *Sync NEXUS Project Skills*
workflow (or mirror by hand into `.claude/skills/`), then confirm with
`diff -r plugins/nexus-godmode-studio/skills .claude/skills`.

### Portability

Frontmatter uses only `name` and `description` — the portable subset of the
[Agent Skills open standard](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview),
which OpenAI's [ChatGPT and Codex skills](https://developers.openai.com/plugins/build/skills) also
consume. No platform-specific keys, no required tools, no MCP server names, no executable
dependencies. The same folders should work in Claude Code, the Claude API, and ChatGPT-compatible
skill systems without modification.

*This portability is by construction, not by testing — the format matches the published standard on
both sides, but the skills have not been loaded into a ChatGPT-compatible system and confirmed.*

---

## What still needs runtime integration

In rough priority order:

1. **Build the memory store.** Everything else assumes it. Until it exists, skill 01 is a
   well-specified interface to nothing.
2. **Build the knowledge store**, with the packet schema from skill 02.
3. **Enforce the invariants in code**, not prose — the state transition table and the confidence gates
   are the two worth validating mechanically, because they are the ones that fail silently.
4. **Wire the NEXUS runtime contracts** and test each: a Guardian denial, an emergency stop
   mid-write, a Verifier disagreement. Then, and only then, mark those integrations `VERIFIED`.
5. **Run the test suites** against the models you use, and record the results.
6. **Resolve the two adjacent-skill overlaps** noted in [MANIFEST §8](MANIFEST.md#8-relationship-to-the-existing-nexus-skill-pack)
   — `project-memory-continuity` and `technology-research-scout` — before installing, so two skills
   never claim the same lane.

---

## Reading order

Start with [SHARED-PRINCIPLES.md](SHARED-PRINCIPLES.md) — the state vocabulary and confidence gates
are the load-bearing ideas, and every skill assumes them. Then
[08-intelligence-router](08-intelligence-router/SKILL.md) to see how it all fits together, and any
individual skill for detail.

[MANIFEST.md](MANIFEST.md) has the dependency graph, write authority, security boundaries, and the
honest status of every claim made here.
