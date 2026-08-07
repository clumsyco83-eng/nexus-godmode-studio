# Technology Research Scout — Advanced Reference

## 1. Decision Brief Template

```markdown
# Technology Decision Brief

Question:
Date researched:
Project constraints:

## Recommendation
...

Confidence: High / Medium / Low

## Why
1. ...

## Candidate matrix
| Criterion | Weight | A | B | C |
|---|---:|---|---|---|

## Key evidence
- claim → source → date/version

## Risks / unknowns
- ...

## PoC
- hypothesis
- success threshold

## Exit strategy
...

## Reconsider when
...
```

## 2. Confidence

### High
Multiple primary/current sources agree; compatibility directly verified; low unresolved uncertainty.

### Medium
Core facts verified but meaningful integration/performance/cost uncertainty remains.

### Low
Important facts are unavailable, preview-only, vendor-claimed, or workload-specific.

Do not hide low confidence behind confident prose.

## 3. Claim-Evidence Ledger

For material claims:

```text
Claim | Source | Source type | Date/version | Confidence | Decision impact
```

This prevents unsupported comparison tables.

## 4. Release State

Explicitly label:
- stable,
- LTS,
- beta,
- preview,
- experimental,
- deprecated,
- EOL.

Never recommend preview software as production default without acknowledging support risk.

## 5. License Review

Check:
- license type,
- commercial-use implications,
- copyleft obligations,
- source-distribution obligations,
- trademark restrictions,
- hosted-service terms when relevant.

For legal uncertainty, flag for legal review rather than inventing a conclusion.

## 6. Vendor Evaluation

Assess:
- data export,
- API limits,
- region availability,
- SLA/support,
- pricing unit,
- rate limits,
- authentication model,
- audit/log capability,
- service history,
- migration path.

## 7. Open-Source Evaluation

Assess:
- ownership/governance,
- contributor concentration,
- recent releases,
- issue response,
- security policy,
- release signing/provenance,
- documentation quality,
- dependency count,
- backward compatibility.

## 8. Benchmark Review

Reject benchmark conclusions when:
- versions differ materially,
- workload is unrealistic,
- only throughput is shown while latency matters,
- cache state is undisclosed,
- cost is omitted,
- vendor benchmarks itself without reproducible details,
- test size does not resemble project usage.

## 9. Community Signal

Community sources can reveal:
- migration pain,
- undocumented gotchas,
- support quality,
- ecosystem sentiment,
- real-world operations.

Treat as qualitative evidence and verify technical claims in primary sources.

## 10. Research Stop Condition

Stop when:
- critical requirements have evidence,
- disqualifiers are checked,
- leading option is clear,
- unresolved uncertainty is either low-impact or assigned to a PoC,
- more searching is unlikely to change the decision.

Do not research indefinitely.

## 11. Web Research Discipline

For current questions:
- search with date/version terms,
- compare publication date to event/release date,
- prioritize recent primary sources,
- inspect official release notes,
- verify "latest" directly,
- cite every externally derived material fact in the decision brief when the environment supports citations.

## 12. Architecture Handoff

Scout should not decide architecture alone.

Handoff:
- recommended option,
- evidence,
- constraints,
- trade-offs,
- irreversible implications,
- migration path,
- confidence.

Principal Architecture then integrates the decision into the system design.

## 13. Research Basis

Anthropic's skill guidance says strong skills should contain non-obvious knowledge and gotchas rather
than generic instructions. This skill therefore focuses on evidence methodology and decision hygiene.

Primary reference:
https://claude.com/blog/lessons-from-building-claude-code-how-we-use-skills
