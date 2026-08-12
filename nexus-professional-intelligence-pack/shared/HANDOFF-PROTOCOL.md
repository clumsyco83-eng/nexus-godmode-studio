# Handoff Protocol — Normative Rules

How skills in this pack pass work to each other without duplicating effort, losing context, or
claiming authority outside their lane.

---

## 1. The lane rule

A skill is authoritative inside its own expertise and advisory everywhere else.

When a task crosses a boundary, the owning skill states the crossing explicitly and hands off. It
does not quietly produce a mediocre version of another skill's work, and it does not block on the
other skill for something it can decide itself.

A skill may disagree with another skill's output. It says so in its own voice, gives its reason,
and lets the human resolve genuine conflicts. It does not silently overwrite.

## 2. Handoff packet

Every handoff carries these fields. Anything longer than this is a report, not a handoff.

```text
FROM:        <skill that is handing off>
TO:          <skill that should take it>
DECISION:    <what was concluded, in one or two sentences>
BECAUSE:     <the decisive evidence or constraint>
STATUS:      PLANNED | APPROVED | IN PROGRESS | BLOCKED | VERIFIED | COMPLETED
CONSTRAINTS: <what the receiving skill must not violate>
OPEN:        <what is still unresolved and who resolves it>
NEEDS:       <the specific question or work being requested>
RISK:        GREEN | YELLOW | RED  (+ what makes it that class)
```

The receiving skill restates `NEEDS` in its own words before starting. If the restatement does
not match, the handoff was ambiguous and gets clarified rather than guessed at.

## 3. Standard chains

These are the common paths. They are defaults, not a required pipeline — skip a stage when it has
nothing to contribute, and say that you skipped it.

```text
Architecture      → Security review → Implementation → Testing → Verification
Business research → Product strategy → Finance
Product strategy  → Growth → Analytics → Recursive improvement
Skill design      → Security review → Evaluation
Any change        → Verification → Human approval, where the class requires it
```

Verification sits at the end of every chain that produces a change. Nothing reaches COMPLETED
without passing through it.

## 4. Combining without duplicating

When several skills apply to one task:

1. One skill **leads** — the one that owns the primary decision.
2. Others **contribute** a named section, not a competing full analysis.
3. The lead integrates and is responsible for the combined output being coherent.
4. Contradictions between contributors are surfaced, not averaged away.

Symptoms that skills are duplicating rather than combining: the same analysis appearing twice in
different words; two skills both writing the implementation plan; a "thorough" output that is
three overlapping reports stapled together.

## 5. Escalation

Escalate to the human, rather than deciding, when:

- the action is RED,
- two skills reach incompatible conclusions on a load-bearing question,
- the repair budget is exhausted,
- the work would exceed the scope that was approved,
- a required input is missing and any assumption about it would materially change the output,
- a control in `GOVERNANCE.md` would have to be relaxed for the work to proceed.

An escalation states: what is blocked, the options, the recommendation, and what the assistant
will do if the human says nothing. That last field prevents silent stalling.

## 6. Non-activation

Skills should not activate to look thorough. Before a skill joins a task it should be able to
answer: *what would be materially worse if I did not participate?* If the answer is nothing, it
stays out.

The default live set for a task is the lead skill plus at most two supporting skills. More than
that needs a reason.
