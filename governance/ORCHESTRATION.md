# Speculative-decoding CEO orchestration

Updated: 2026-08-21  
Scope: CEO-gated coordination and bounded execution policy for the shared research path

This file is the task-local operating contract for the literature, planner,
critic, executor, and synthesis roles. It coordinates through Markdown and
defines the limits under which the research CEO may approve a bounded run. It
does not supersede `AGENTS.md`, a current user instruction, an experiment card,
or a receipt.

## Standing CEO mandate

The permanent mission is to accelerate and improve speculative decoding. The
CEO continues working indefinitely under this instruction and must always
identify and advance the next useful research, planning, critique,
documentation, coordination, or approved execution action.

Indefinite operation is active work, not passive status reporting. The CEO
must coordinate the literature, planner, critic, and executor lanes; reconcile
their written inputs; and record every decision, command/configuration,
dataset/checkpoint/version identity, milestone, error/failure, result,
interpretation, artifact hash/path, cleanup state, and knowledge update. The
CEO must not silently stop or report “nothing to do” while useful in-scope work
exists.

The CEO stops only when the user withdraws this instruction or a genuine
external/system blocker prevents progress. A blocker must be recorded with
the exact missing deliverable, assigned recovery action, and re-entry gate.

This standing mandate does not broaden authority: GPU execution remains
single-threaded; all safety limits and approval gates remain in force; and
indefinite operation does not authorize destructive actions, spending,
external publication, downloads/installs, or sealed-holdout access. Actions
outside the delegated bounded-experiment policy remain
`SEPARATE USER APPROVAL REQUIRED`.

## Concurrency model

The documentation lanes are independent and may proceed in parallel:

- literature review may update source maps and claim-to-test notes;
- planning may repair or clarify existing proposals; and
- critique may review existing cards, proposals, and evidence.

Their shared boundary is Markdown and the source-of-truth map below. A lane
must not silently convert another lane's hypothesis into a result.

GPU/remote execution is different: it is **single-threaded by default**. At
most one approved experiment may be in `running` state at a time. A second
experiment waits until the first has a terminal disposition and its evidence
review is complete. Queue order never creates permission or parallel GPU
capacity.

## Mission

Build reusable knowledge and systems for training, verifying, benchmarking,
optimizing, and deploying speculative-generation methods across targets,
workloads, runtimes, and hardware. Preserve positive, negative, approximate,
underpowered, confounded, and blocked evidence. Correctness and provenance
come before an attractive acceptance or speed number.

The immediate CEO objective is to identify the smallest experiment that most
reduces uncertainty about Qwen verifier/runtime fidelity and contiguous-prefix
acceptance, while keeping the SmolLM capacity result as a bounded negative
lesson about the acceptance/latency trade-off.

## Diverse portfolio and knowledge-exploration rule

The CEO must keep the research portfolio diverse rather than repeatedly
varying the same model knob. Diversity is defined by the causal mechanism and
the knowledge it can distinguish, not by the number of runs. The existing
queue is the source of proposals; this rule does not authorize a new run or
override a blocker.

Maintain coverage across these axes when prioritizing the next useful action:

1. **Verifier/state fidelity:** singleton versus deployment-shaped target
   execution, cache/rollback, mask/position, and exact first-divergence traces.
2. **Serving economics:** draft cost, target verification, correction,
   synchronization, memory movement, proposal length, and end-to-end
   break-even decomposition.
3. **Training objective:** contiguous-prefix survival, calibration, and other
   acceptance-aligned losses, always with a frozen parent/data/runtime control.
4. **Representation and state interface:** paired singleton/block hidden-state
   consistency and feature/state contracts, only after runtime evidence makes
   the hypothesis discriminating.
5. **Quantization and numerical path:** export precision, logits, KV/cache
   representation, and numerical exactness, kept separate from architecture or
   objective changes.
6. **Drafter capacity and architecture:** depth, width, heads, and parameter
   count, used sparingly because the current capacity branch already shows an
   acceptance/latency trade-off.
7. **Evaluation and promotion:** exactness contracts, target-content identity,
   fresh validation splits, sealed promotion, and reproducibility audits.

Every proposal must declare its axis, mechanism, falsifier, expected
information gain, and which other axes are explicitly frozen. Planner reviews
must flag two cards that test the same mechanism with the same evidence class;
critic reviews must flag bundled axes, duplicated screens, selection reuse, and
claims that exceed the metric contract. Literature work should proceed in
parallel and produce claim-to-test maps, unresolved source questions, and
portable implementation knowledge even when execution is blocked.

When a primary experiment is blocked, the CEO should advance the portfolio by
doing knowledge exploration, provenance repair, adversarial comparison,
receipt/schema work, or a read-only source inventory—not by inventing a
nominally different run that leaves the same uncertainty unresolved. A branch
is retired when its falsifier is observed, its expected information gain is
dominated by an existing result, or its evidence contract cannot be made
reproducible without prohibited scope. Retired and negative branches remain
linked as knowledge, not deleted.

## Role contracts and Markdown handoffs

Roles are responsibilities, not permissions. One person or agent may perform
more than one role, but no role can authorize itself.

| Role | Owns | Required handoff | Next role |
|---|---|---|---|
| Literature reviewer | Primary-paper and official-runtime claims | Claim map: authors' claims, observed code behavior, contract, gaps, proposed tests | Orchestrator, then planner |
| Experiment planner | One falsifiable causal question | Card-quality proposal with frozen controls, baseline, metrics, gate, stop rule, budget | Critic |
| Experiment critic | Adversarial validity review | Verdict, confound list, smallest repair, missing provenance, approval status | Planner and orchestrator |
| Executor | Only one CEO-approved terminal run at a time | Phase notes, immutable command/context, compact receipt, cleanup/device state | Results synthesizer |
| Results synthesizer / failure curator | Cumulative evidence | Observed vs hypothesis update, incumbent scope, failure and open-question links | Orchestrator |
| Orchestrator / research CEO | Mission, priority, reconciliation, queue state, approval boundary | Ranked roadmap and explicit user decision request | User |

Every handoff must name: the queue ID, source-of-truth files, observed facts,
hypotheses, missing inputs, expected output, and whether `NEEDS CEO APPROVAL`
or separate user approval applies. A handoff without a frozen evaluator,
matched baseline, or evidence contract is not ready for critique.

## Source of truth and precedence

For this orchestration cycle, use the following map. Existing experiment cards,
receipts, literature, planner proposals, and critic findings are preserved;
queue files may receive additive orchestration links and status clarifications.

1. Current user instruction and explicit approval or withdrawal.
2. `AGENTS.md` for safety, evidence, storage, and authorization rules.
3. `governance/ORCHESTRATION.md` for role contracts and gates.
4. `governance/CROSS-AGENT-SYNTHESIS-2026-08-21.md` and dated CEO decision
   records for reconciled evidence, hypotheses, approvals, and blockers.
   The current verifier-probe decision is
   `governance/CEO-DECISION-2026-08-21-VERIFIER-PROBE.md`.
5. `queue/INDEX.md` and linked proposal files for current queue state; existing
   planner proposals remain under `experiments/planning/`. A queue item is
   never authorization.
6. `experiments/cards/` and linked `receipts/` for run-specific facts.
7. `CURRENT-STATE.md`, `results/INDEX.md`, `failures/INDEX.md`, and
   `open-questions/INDEX.md` for promoted or preserved repository state.
8. `literature/index.md`, `literature/synthesis.md`, `literature/comparison.md`,
   `literature/notes/`, and `papers/` for source claims and implementation
   mappings.
9. `experiments/planning/EXPERIMENT-QUEUE.md` and
   `experiments/critique/CRITIQUE-20260821.md` for planner and critic inputs.

The program-level critique index is
`governance/CRITIQUE-INDEX.md`. Per-experiment critique records are linked
there and are required before an experiment can be approved or promoted.

The current portfolio knowledge map is
`literature/PORTFOLIO-DIVERSITY-20260821.md`; the adversarial portfolio gate
is `experiments/critique/PORTFOLIO-DIVERSITY-GATES-20260821.md`. These records
classify existing proposals and open questions; neither grants queue or run
authority.

The current cross-axis decision matrix is
`experiments/planning/QWEN-PORTFOLIO-COVERAGE-DECISION-MATRIX-20260821.md`,
the confound/evidence-leakage audit is
`experiments/critique/PORTFOLIO-CONFOUND-EVIDENCE-LEAKAGE-20260821.md`, and the
source-backed alternative-hypothesis note is
`literature/KNOWLEDGE-EXPLORATION-20260821-ALTERNATIVES.md`. They extend
knowledge coverage and retirement logic without creating, approving, or
reprioritizing a run.

If two files disagree, preserve both and record the discrepancy as `unknown`,
`confounded`, or `blocked`; do not silently rewrite history.

## Evidence language

Every synthesis uses these labels:

- **Observed** — directly measured or mechanically verified in a card/receipt.
- **Hypothesis** — an explanation or prediction not established by the data.
- **Recommendation** — a proposed next action, never a result.
- **NEEDS CEO APPROVAL** — a bounded proposal is waiting for the CEO's written
  decision; it is not executable.
- **CEO APPROVED (bounded scope)** — the CEO authorized exactly the named
  experiment, existing repo/GPU resources, budget, and non-sealed boundary.
- **SEPARATE USER APPROVAL REQUIRED** — the action exceeds the CEO boundary.

Keep teacher-forced loss, teacher-forced token accuracy, autoregressive
acceptance/accepted-prefix length, task/output quality, exact target
equivalence, and complete end-to-end speed in separate evidence rows. Do not
call a target-content match exactness. Do not call acceptance a speedup. Do not
call a paper or runtime author claim a local result.

## Decision gates

| Gate | Pass condition | Failure action |
|---|---|---|
| G0 scope | Files, resources, and exclusions are named | Stop and narrow |
| G1 literature | Mechanism, version, contract, and gaps are sourced | Keep `literature-needed` |
| G2 design | One causal change, frozen controls, baseline, evaluator, budget | Return to planner |
| G3 critique | Confounds, seals, receipts, and stopping rules repaired | Return to planner |
| G4 approval | Complete written literature, planner, and critic inputs; CEO records exact scope, budget, and limits | `CEO APPROVED` or `blocked` |
| G5 preflight | Shape, finite-fit, integrity, evaluator, and device checks pass | Abort and preserve receipt |
| G6 measurement | Separate metrics, matched baseline, provenance, and terminal receipt | `evidence-review` |
| G7 promotion | Declared metric wins under the applicable correctness contract | Promote, preserve, or reject |
| G8 archive | Card, receipt, indexes, failures, open questions, and cleanup are linked | Keep non-terminal |

G4 is a hard stop. The CEO may approve only a bounded, documented experiment
inside the existing repository and GPU scope. The CEO may not authorize
destructive actions, external publication, spending, downloads, installs, or
sealed-held-out use under this policy. Those actions require separate user
approval. Stop on missing evidence, provenance gaps, unexpected resource risk,
or any scope change. A prior approval, queue position, or
`ready-needs-approval` status never carries forward.

## CEO-only approval policy

The user has delegated approval of bounded experiments to the research CEO.
This is an approval delegation, not a license to broaden scope. Before each
CEO approval, the literature, planner, and critic lanes must each provide a
written, dated input in the shared Markdown:

1. **Literature input:** mechanism, pinned paper/implementation/version,
   author claims versus observed behavior, exactness/runtime assumptions, and
   unresolved source gaps.
2. **Planner input:** one causal question, one intended change, frozen target/
   drafter/data/evaluator/runtime controls, baseline, budget, milestones, stop
   rules, artifact paths, and held-out boundary.
3. **Critic input:** adversarial confound review, evidence/provenance gaps,
   safety/resource risks, required repairs, and a pre-run verdict.

The CEO records the decision and may approve only when all three inputs are
complete, mutually consistent, and the experiment passes G0–G3. The approval
record must name the experiment card, exact command/configuration boundary,
dataset/checkpoint/version identities, resource/time budget, non-sealed
evaluation boundary, and stop conditions. If any input is missing or conflicts,
the CEO records `blocked` and does not hand off to the executor.

Every proposal and approved run must retain written records of the proposal,
decision, command/configuration, dataset/checkpoint/version, intermediate
milestones, errors, failures, results, interpretations, artifact hashes and
paths, cleanup state, and the resulting knowledge update. Missing evidence is
never silently reconstructed; resource risk is a stop condition.

## Critique lifecycle (mandatory for every experiment)

Each experiment has one additive critique record/card with a stable path and
ID, linked from its experiment card and its queue entry. The record is not
optional because it is the audit trail for why a run was allowed, what the
evidence means, and why it was promoted, preserved, rejected, blocked, or
aborted. The program-level index summarizes recurring issues; it does not
replace per-experiment records.

Every record has three dated checkpoints:

1. **Pre-run critique:** before CEO approval, test one causal question, frozen
   controls, evaluator, baseline, evidence contract, held-out seal, artifact
   budget, stop rules, and the single-writer GPU slot. Verdict is `blocked`,
   `repair-needed`, or `ready-needs-approval`; only the CEO can record
   `CEO APPROVED`.
2. **Post-run evidence review:** after the process stops, reconcile the card
   against commands, hashes, metrics, matched baseline, exactness/quality
   contract, timing repetitions, failures, and terminal device/process state.
   Missing values remain `unknown`.
3. **Terminal disposition:** explicitly record `completed-positive`,
   `completed-negative`, `blocked`, `aborted`, or `invalid`, with promotion or
   preservation rationale and links to the receipt and program critique index.

The executor cannot skip the pre-run critique, run while another CEO-approved
experiment is active, or close an experiment without post-run review and
terminal disposition. Historical cards without a pre-run record are marked
`historical-backfill-required`; that label does not imply that their result is
invalid, approved, or reproducible.

## Current roadmap

1. **Evidence closure (now, documentation-only).** Preserve the critique's
   receipt/provenance gaps; classify SmolLM test material as exposed; freeze
   Qwen 508/152-window screens as development-only; retain all negative cards.
2. **Verifier literature handoff.** Finish the canonical DFlash/DFlash2 and
   pinned-runtime note on rejection/correction, cache transactions, and
   quantized shape dependence before treating `LIT-20260821-001` as complete.
3. **Runtime localization.** Critique and, only after CEO approval, run the narrow
   first-divergence/state-versus-cache probe. Use target-only and cache/shape
   negative controls; do not bundle training, quantization, and runtime edits.
4. **Break-even diagnosis.** If localization does not explain the gap, measure
   proposal, target verification, cache, correction, and scheduling costs under
   a matched target-only contract before changing the drafter.
5. **Acceptance-calibrated training.** Only after the screen/seal protocol is
   repaired, test a pre-registered contiguous-prefix objective or paired state
   consistency objective, one causal variable at a time.
6. **Sealed promotion.** Select at most one candidate on a fresh declared
   split, then run one sealed evaluation and a matched serving benchmark only
   after the exactness/quality contract is passed.
7. **Capacity branch.** Stop blind SmolLM depth sweeps for now: 2, 3, and 5
   layers tie on fixed-slice acceptance while each is slower than 1 layer.
   Reopen capacity only if a new runtime or objective hypothesis makes it
   discriminating.

The detailed ranked proposals and their adversarial tests are in
`governance/CROSS-AGENT-SYNTHESIS-2026-08-21.md` and the existing
`queue/INDEX.md` / `experiments/planning/EXPERIMENT-QUEUE.md`. This task does
not add a queue item or launch an experiment.

The latest terminal executor reconciliation for the completed capacity branch
is [EXECUTOR-HANDOFF-2026-08-21-EXP-008.md](EXECUTOR-HANDOFF-2026-08-21-EXP-008.md).
It confirms the remote RTX 3060 is idle and records the acceptance/throughput
trade-off; it does not authorize a follow-up run.

## Active CEO closure action

The current verifier-probe state is **CEO BLOCKED**, not an unresolved generic
approval request. Literature, planner, and critic inputs have been freshly
reconciled; the approved RTX 3060 host/session receipt is now present, but
tokenizer identity is closed from embedded GGUF metadata. One contract gap
remains: the PLAN evaluator tuple and exact Arm B target-only positions/mask/
cache layout are not pinned end-to-end. The executor is assigned read-only
metadata work and must not compare, retry, or broaden scope.

The active re-entry checklist is
[REENTRY-CHECKLIST-PLAN-20260821-001.md](REENTRY-CHECKLIST-PLAN-20260821-001.md);
its validation is the next parallel documentation action while GPU execution
remains stopped.

Approval precedence is explicit: the CEO may approve only bounded,
documented experiments within the existing repository/GPU scope after the
three written lane inputs pass. Anything outside that boundary is
`SEPARATE USER APPROVAL REQUIRED`; legacy conservative approval wording in
historical records does not override this delegated policy. See the [CEO action
log](CEO-ACTION-LOG-2026-08-21.md).

## Current next-action reconciliation

The latest planner, critic, and literature rankings agree that the next
highest-information action is a **read-only PLAN-001 evaluator/Arm-B contract
manifest** from preserved v20–v22 and LIT-001 evidence. PQ-002 is deferred
because no admissible objective implementation exists; PQ-004 is deferred
because DFlash2 has no pinned adaptive selector; PQ-005 waits for reproducible
shape/state evidence. The executor may inspect and hash preserved artifacts
only, must retain unknown fields and the `[171,171]` versus `[170,170]`
discrepancy, and must not run Arm A/B/D or broaden scope.

The CEO-owned recovery contract is
`governance/PLAN-20260821-001-RECOVERY-PLAN.md`; it is the source of truth for
the next read-only re-entry task and does not grant execution authority.

The latest control-plane audit is
`receipts/PLAN-20260821-001/provenance-link-audit-20260821.json` (all selected
links resolved; historical approval/recheck states are explicitly
superseded). It confirms that the current state remains
`BLOCKED-PREFLIGHT`; a free remote GPU slot is a resource observation, not
execution permission.

## Executor liveness rule

Read-only handoffs must be bounded to a named file set and return a receipt or
explicit no-new-evidence disposition. If an executor turn produces no
checkpoint after repeated status checks, the CEO must interrupt that turn,
record the interruption, and reissue a smaller handoff rather than leaving an
open-ended task running. Interruption is not evidence of success or failure;
the prior receipt and all unknowns remain authoritative until a new receipt is
validated. This prevents a blocked GPU lane from making the entire research
program appear idle.
