# Experiment critique process

Updated: 2026-08-21  
Owner: research CEO / orchestrator  
Authority: documentation, review, and CEO-gated bounded-run policy only

This process makes critique a required control around every experiment. It
does not itself authorize execution; only a complete CEO decision record can
authorize a bounded run. It never changes an experiment's result or replaces
the source-specific rules in `AGENTS.md`.

## Parallel lanes, serialized execution

Literature, planning, and critique are documentation lanes and may proceed in
parallel against the shared Markdown source of truth. They must label facts,
hypotheses, unknowns, and recommendations and must not mutate an experiment's
terminal facts without a dated amendment.

GPU/remote execution is single-threaded by default: one CEO-approved experiment
at a time. The executor must acquire a named queue slot, verify that no other
CEO-approved experiment is `running`, and release the slot only after post-run
evidence review and terminal disposition. A queue entry, a planner handoff, or
a critic's `ready-needs-approval` verdict never grants the slot.

## Required record set

Every experiment has:

1. its immutable experiment card under `experiments/cards/`;
2. one additive per-experiment critique record under
   `governance/critique/EXP-<id>-CRITIQUE.md`, linked from the card and queue;
3. compact receipts under `receipts/<id>/` where execution occurred; and
4. one row in `governance/CRITIQUE-INDEX.md`, the program-level index.

The per-experiment record is the lifecycle audit trail. The program index
summarizes recurring issues and links to each record; it does not substitute
for one. Historical cards may temporarily have
`historical-backfill-required`, but that status is not an approval or a claim
that the card's observation is invalid.

## Three mandatory critique checkpoints

### 1. Pre-run critique

Before the CEO can approve a run, the critic checks:

- one falsifiable causal question and one intended change;
- target/drafter/runtime/checkpoint/data/evaluator hashes and frozen controls;
- matched target-only baseline and separate evidence classes;
- exactness, quality, acceptance, and speed contracts stated independently;
- held-out seal and selection/multiplicity policy;
- construction, finite-fit, integrity, and device preflight gates;
- artifact budget, stop conditions, cleanup, and terminal receipt schema; and
- the single-threaded GPU slot and explicit `NEEDS CEO APPROVAL` boundary.

The verdict is `blocked`, `repair-needed`, or `ready-needs-approval`. Only the
CEO can move the named bounded scope to `CEO APPROVED`; actions outside the
delegated boundary remain `SEPARATE USER APPROVAL REQUIRED`.

### 2. Post-run evidence review

After execution stops, the synthesizer/critic reconciles the card with the
command, working directory, source commits, hashes, data/split identity,
metrics, call counts, timing repetitions, exactness oracle, quality contract,
failures, cleanup, and final process/device state. Missing evidence stays
`unknown`; approximate target-content matches never become `exact`.

If the receipt is incomplete, the result remains `evidence-review` and cannot
be promoted. A negative, underpowered, confounded, aborted, or invalid result
is preserved rather than repaired by rewriting history.

### 3. Terminal disposition

The record must end with one of `completed-positive`, `completed-negative`,
`blocked`, `aborted`, or `invalid`, plus:

- the promotion or non-promotion decision under the declared metric;
- the first failing gate, if any;
- the next narrow discriminating question;
- links to the card, receipts, failure/open-question entries, and program
  critique index; and
- confirmation that the single GPU slot is released and task-owned processes
  are absent.

No executor may close a run by simply reporting a metric. The disposition is
the end of the experiment's audit trail.

## Program-level recurring-issue taxonomy

The index uses stable labels so recurring defects are visible across methods:

- `PROV` — missing hashes, commands, runtime versions, or terminal receipts;
- `SEAL` — exposed or repeatedly reused evaluation data;
- `CONF` — more than one causal variable changed;
- `METRIC` — loss, acceptance, quality, exactness, and speed conflated;
- `RUNTIME` — shape, mask, cache, rollback, scheduler, or numerical path;
- `BASELINE` — target-only or denominator mismatch;
- `CAPACITY` — depth/width or initialization interpretation risk; and
- `LITERATURE` — author claim or compatibility bridge mistaken for local proof.

Each per-experiment record may add labels, but the program index is the place
to count and prioritize them. A recurring issue is not a reason to delete the
experiment; it is a reason to tighten the next gate.

## CEO approval boundary

The user delegates approval of bounded, documented experiments to the CEO.
The CEO may approve only work inside the existing repository/GPU scope, with
one experiment running at a time, no destructive actions, no external
publication, no spending, no downloads or installs, and no sealed-held-out use
unless separately allowed by the user. Stop on missing evidence, provenance
gaps, unexpected resource risk, or scope drift.

Before each approval, written dated inputs from the literature, planner, and
critic lanes are mandatory. The CEO approval record must name the experiment
ID, exact command/configuration boundary, target/drafter/runtime/data/version
identities, resource/time budget, non-sealed evaluation boundary, milestones,
and stop conditions. A proposal without all three inputs is `blocked` and is
not handed to the executor.

Every proposal and run must retain complete written records of the proposal,
decision, commands/configuration, dataset/checkpoint/version, intermediate
milestones, errors, failures, results, interpretations, artifact hashes/paths,
cleanup state, and knowledge update. Approval of one experiment does not
authorize another, a follow-up, a download, or parallel GPU work. Withdrawal or
pause supersedes earlier approval.

This task performs documentation only and launches no experiment.
