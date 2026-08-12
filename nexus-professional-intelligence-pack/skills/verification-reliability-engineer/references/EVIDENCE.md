# Verification Recipes by Artifact Type

Read this when you know *what* must be verified but not *how* to obtain evidence for that kind of
artifact. Each recipe names the check that produces E1 evidence, the trap that most often turns a
verification into a false pass, and the regression signal worth running alongside.

## Contents

1. Code changes
2. APIs and services
3. Data and migrations
4. User interfaces
5. Documents and generated content
6. Agent and subagent output
7. Infrastructure and deployment
8. Security properties
9. Performance claims
10. Verification of absence

---

## 1. Code changes

**E1 evidence:** the test suite run with output captured; the specific new test run and observed
to fail before the fix and pass after.

**Trap:** a test that passes because it asserts nothing meaningful, or that was skipped. Read the
summary line for skipped, xfail, and filtered counts — not just the exit code. An exit code of 0
with every relevant test filtered out is the most common false pass in agent workflows.

**Regression signal:** the full suite, not just the file that changed. If the full suite is too
slow to run, that is a finding to report, not a reason to skip it silently.

**Also confirm:** the diff actually contains the change described. Agents sometimes describe an
edit they did not write, or wrote to a different file.

---

## 2. APIs and services

**E1 evidence:** a real request and its full response — status, headers, body.

**Traps:**
- verifying a 200 without checking the body performed the effect,
- testing only the success path,
- calling a mock and reporting it as the service,
- a response that is correct but not persisted — re-read the resource in a separate request.

**Checks worth running:** valid input; invalid input; missing authentication; wrong-user
authentication (should be denied — this is where broken access control shows up); malformed body;
duplicate submission (idempotency); and the effect confirmed by an independent read.

**Regression signal:** the endpoints that share the changed handler, model, or middleware.

---

## 3. Data and migrations

**E1 evidence:** row counts and checksums before and after; a sample of records inspected
directly; the migration run against a copy of real-shaped data, not an empty table.

**Traps:**
- a migration that succeeds on an empty database and fails on production volume or on rows with
  legacy nulls,
- verifying the schema changed without verifying the data survived,
- silent truncation on a narrowed column type.

**Always establish before running:** is this reversible? A down-migration that has never been
executed is a hypothesis. If there is no tested rollback, the change is RED and needs explicit
human approval with the data-loss risk stated.

**Regression signal:** queries and reports that read the changed tables.

---

## 4. User interfaces

**E1 evidence:** the interface actually rendered and interacted with — a screenshot, a recorded
run, or a browser automation transcript.

**Traps:**
- verifying the component compiles rather than that it displays correctly,
- checking one viewport,
- checking only the populated state — empty, loading, error, and overflow states are where UI
  breaks,
- confirming a button exists without confirming it does something.

**Checks worth running:** the primary flow end to end; empty state; error state; slow network;
keyboard-only navigation; and the smallest and largest supported viewport.

---

## 5. Documents and generated content

**E1 evidence:** the produced file opened and inspected — not the code that generates it.

**Traps:**
- a PDF that is an image scan when extractable text was required,
- a spreadsheet where formulas were written as literal strings,
- a document with placeholder text left in,
- correct content in a corrupted container that the target application refuses to open.

**Always:** open the artifact in something resembling the tool the reader will use, and look at it.

---

## 6. Agent and subagent output

**E1 evidence:** the artifacts the agent produced, inspected directly. Never the agent's report.

**Traps:**
- the report describes intent, not action,
- files claimed as written do not exist, or exist at another path,
- the agent "fixed" a test by deleting or skipping it,
- work was done on the wrong branch, directory, or repository,
- a partial run was summarized as a complete one.

**Minimum check for delegated work:** list what changed, read the changes, run the checks
yourself. Three questions catch most of it — *does the artifact exist, does it contain what was
claimed, and does the check pass when I run it?*

---

## 7. Infrastructure and deployment

**E1 evidence:** the deployed version identifier observed in the running environment; a health
endpoint returning healthy; a real request served end to end after deploy.

**Traps:**
- a successful deploy pipeline with the old artifact still serving,
- healthy checks that only confirm the process is up, not that it works,
- verifying in staging and claiming production,
- caches and CDNs serving the previous version.

**Regression signal:** error rate and latency compared against the pre-deploy baseline, over a
window long enough to be meaningful.

---

## 8. Security properties

**E1 evidence:** the attack the control is meant to prevent, attempted against the control, and
observed to fail.

**Traps:**
- verifying the control exists in code rather than that it holds at runtime,
- testing with an authorized account only,
- testing the UI path while the API remains open.

**Standard checks:** access the object as a different user; access it with no credential; access
it with an expired credential; reach the endpoint directly, bypassing the interface.

A control that has never been tested against its threat is unverified regardless of how carefully
it was written. Route findings to the security specialist rather than assessing severity here.

---

## 9. Performance claims

**E1 evidence:** measurement under realistic conditions, reported with the distribution rather
than a single number.

**Traps:**
- a single run on a warm cache,
- measuring on hardware unlike the target,
- reporting a mean when the tail is what users experience,
- comparing against an unrecorded baseline.

**Minimum:** state the baseline, the load, the percentiles (median and p95 at least), and the
number of runs. A performance claim with one number and no baseline is not verifiable.

---

## 10. Verification of absence

Claims of the form "there are no X" — no hardcoded secrets, no remaining callers, no other
occurrences — are the hardest to verify and the easiest to get wrong.

**Method:** state the search that was run, its exact scope, and its known blind spots. "No matches
for pattern P across paths Q, excluding R" is verifiable. "There are none" is not.

**Traps:** searching the wrong directory; a pattern that misses an equivalent form; excluded
files that were the ones that mattered; and searching only tracked files when untracked ones
exist.

Absence claims should carry their method in the evidence line, always.
