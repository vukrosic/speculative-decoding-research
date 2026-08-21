# Research orchestration

Updated: 2026-08-21

This document is the operating contract for the speculative-decoding research
lab. It coordinates literature work, experiment design, criticism, execution,
and synthesis without granting execution authority.

## Mission and success criteria

### Mission

Build reusable, reproducible knowledge and systems for training, verifying,
benchmarking, optimizing, and deploying speculative-generation methods across
targets, workloads, runtimes, and hardware. The lab must explain both wins and
failures, and must never trade away correctness or provenance for an attractive
metric.

### Operational success criteria

The orchestration layer is working when:

1. Every proposed claim has an owner, a queue entry, and a named source of
   truth.
2. Every experiment has one causal question, frozen controls, a promotion gate,
   stop conditions, and a compact receipt.
3. Literature claims, teacher-forced metrics, acceptance, quality, exactness,
   and end-to-end serving speed remain separate evidence classes.
4. Negative, underpowered, approximate, and blocked results remain searchable
   and are not silently promoted.
5. No remote work, training, download, install, evaluation, publishing, or
   spending starts without explicit current user approval.
6. At the end of a work cycle, the repository states the best supported fact,
   the leading hypothesis, the next discriminating action, and its approval
   status.

## Roles and handoffs

Roles are documentation responsibilities. They may be performed by one agent
or by separate agents, but no role can grant itself permission to execute.

| Role | Owns | Produces | Hands off to |
|---|---|---|---|
| Orchestrator / research CEO | Mission, priority, conflict resolution, queue state, approval boundary | Queue triage, decision-log entries, roadmap, explicit recommendation | Literature reviewer, planner, critic, user |
| Literature reviewer | Primary-paper and official-code understanding | `papers/<note>.md` with claims, mechanisms, gaps, and test mappings | Planner and orchestrator |
| Experiment planner | One falsifiable causal question and a controlled protocol | Experiment card or queue-ready design with frozen controls, gate, stop conditions, and artifact budget | Critic |
| Experiment critic | Adversarial review before execution | Critique note: confounders, missing provenance, invalid claims, smallest repair, gate verdict | Planner, orchestrator, user |
| Experiment executor | Only user-approved terminal work | Phase notes, commands, compact receipts, cleanup/device state, amended card | Results synthesizer and failure curator |
| Results synthesizer / failure curator | Cumulative interpretation | `results/INDEX.md`, `failures/INDEX.md`, `open-questions/INDEX.md`, daily note | Orchestrator |

### Required handoff packet

Every handoff links the queue entry and includes: question, current status,
source-of-truth files, facts versus hypotheses, missing inputs, expected output,
and whether user approval is required. A handoff that lacks a frozen evaluator,
baseline, or evidence contract is not ready for critique.

## Source of truth and precedence

When documents disagree, use this precedence order:

1. Current user instruction and explicit approval or withdrawal.
2. `AGENTS.md` safety, evidence, and storage rules.
3. This file and `queue/INDEX.md` for orchestration state.
4. `experiments/planning/EXPERIMENT-QUEUE.md` for planner-owned detailed
   proposals; its entries still require the queue gates and user approval.
5. The experiment card and linked receipts for run-specific facts.
6. `CURRENT-STATE.md` and `results/INDEX.md` for promoted incumbents.
7. `failures/INDEX.md`, `open-questions/INDEX.md`, `papers/`, and `daily/` for
   preserved context and unresolved work.
8. Historical external logs or memory are context only until linked to a
   receipt.

| Need | Canonical file(s) |
|---|---|
| Mission and operating contract | `README.md`, `docs/ORCHESTRATION.md` |
| Safety and evidence rules | `AGENTS.md`, `docs/RESEARCH-METHOD.md` |
| What is currently supported | `CURRENT-STATE.md`, `results/INDEX.md` |
| Individual run facts | `experiments/cards/`, linked `receipts/` |
| Failures and rejected assumptions | `failures/INDEX.md` and the original card |
| Open hypotheses and discriminating tests | `open-questions/INDEX.md` |
| Paper and implementation knowledge | `papers/INDEX.md` and paper notes |
| Draft literature synthesis | `literature/index.md`, `literature/sources.md`, `literature/synthesis.md`, and `literature/comparison.md` |
| Queue state and ownership | `queue/INDEX.md` and the linked queue entry |
| Detailed experiment proposals | `experiments/planning/EXPERIMENT-QUEUE.md` |
| Adversarial evidence review | `experiments/critique/CRITIQUE-20260821.md` |
| Decisions and conflict resolution | `docs/DECISIONS.md` |
| Chronological lab context | `daily/YYYY-MM-DD.md` |

## Queue lifecycle

The queue is append-oriented. Status changes are dated in the entry; old
evidence and rejected proposals are never deleted.

`proposed` -> `literature-needed` -> `planned` -> `critique-needed` ->
`ready-needs-approval` -> `approved` -> `running` -> `evidence-review` ->
`completed` / `completed-negative` / `blocked` / `aborted` / `invalid`.

- `proposed`: an idea exists, but its question or source is incomplete.
- `literature-needed`: primary sources or implementation facts are required.
- `planned`: a card-quality protocol exists; no mutation has started.
- `critique-needed`: the planner has handed it to the critic.
- `ready-needs-approval`: critic found no unresolved design blocker; execution
  still requires explicit current user approval.
- `approved`: the user approved the named scope, command, and resource budget.
- `running`: only the executor may use this status, and only during approved
  work.
- `evidence-review`: work stopped; receipts and claims are being checked.
- Terminal statuses preserve the reason and links to the evidence.

Queue entries must state `approval: NOT REQUESTED`, `approval: CEO DECISION
REQUIRED`, or `approval: CEO APPROVED (bounded scope/date)`. Agents must never
infer approval from a prior run, a planned card, or a queue position. Actions
outside the delegated bounded-experiment policy are `SEPARATE USER APPROVAL
REQUIRED`.

## Decision gates

| Gate | Question | Required evidence | Result |
|---|---|---|---|
| G0 scope | Is the work inside the current request and safety boundary? | Named files, resources, and exclusions | Continue or block |
| G1 literature | Is the mechanism and prior art understood? | Primary paper/code note; authors' claims separated | Continue, narrow, or research more |
| G2 design | Is there one causal question? | Card, frozen controls, baseline, evaluator, budget | Planner-ready |
| G3 critique | Can the result answer the question? | Adversarial critique; confounds and stop conditions repaired | Ready or return to planner |
| G4 approval | May mutation begin? | Explicit current user approval naming scope and budget | `approved` or `ready-needs-approval` |
| G5 preflight | Is the run safe and interpretable? | Shape/gradient/integrity/evaluator/device checks | Run or abort |
| G6 measurement | Are metrics and provenance complete? | Separate evidence classes, repeated timing where relevant, receipt | Evidence-review |
| G7 promotion | Does the candidate beat the relevant incumbent under contract? | Matched baseline and applicable correctness gate | Promote, preserve, or reject |
| G8 archive | Can another researcher reproduce the claim? | Card, receipt, indexes, failure/open-question updates, cleanup state | Terminal queue status |

G4 is a hard stop. A proposal remains non-authorizing until the CEO records a
bounded decision after the literature, planner, and critic gates pass. The CEO
may approve only in-scope repository/GPU work; actions outside that boundary
remain `SEPARATE USER APPROVAL REQUIRED`.

## Evidence standard

Every report uses these labels:

- **Observed:** directly measured or verified, with a card/receipt link.
- **Hypothesis:** an explanation not established by the current evidence.
- **Recommendation:** the orchestrator's proposed next action.
- **User-approved execution:** only an explicitly approved scope, never an
  inference from `ready-needs-approval`.

Keep these evidence classes in separate rows and prose: teacher-forced loss,
teacher-forced token accuracy, autoregressive draft acceptance, task/output
quality, end-to-end latency/throughput, and exact target-equivalence or an
explicit approximate contract. A higher class is not implied by a lower one.

Claims of `exact`, `lossless`, `equivalent`, or `speedup` require the relevant
passed oracle and matched baseline receipt. Approximate, validation-only,
confounded, or underpowered results must say so next to the metric.

## Approval boundaries

Documentation, indexing, queue maintenance, critique, and local read-only
inspection are in scope for this orchestration request. The following always
require explicit current user approval: SSH or remote GPU work, training,
generation, evaluation, downloads, installs, changes to external services,
publishing, spending, and use of sealed held-out data.

The executor must stop if the approved scope, artifact budget, device state,
or correctness contract changes. It may stop processes it started, but may not
clean up unrelated work. A withdrawal or pause supersedes an earlier approval.

## Current reconciliation (facts and hypotheses)

### Critic gate now on record

The critique at `experiments/critique/CRITIQUE-20260821.md` is a
documentation-only review, not an execution approval. It identifies three
control-plane blockers that must remain visible: incomplete compact receipt and
provenance closure, exposed/non-sealed SmolLM test evidence, and repeated
optimization of small Qwen validation screens. It also flags confounded
capacity, alignment, objective, and runtime comparisons. These findings narrow
what may be promoted; they do not erase the bounded observations below.

### Observed

- The SmolLM 10.13M two-layer bridge is the fixed-90 exact-acceptance
  incumbent at 7.1566%; the 35.40M capacity ablation improved teacher-forced
  metrics but fell to 6.8334% acceptance.
- The bounded SmolLM five-layer comparison improved acceptance from 6.0045% to
  7.1566% and passed its exact guard, but reduced end-to-end throughput from
  14.4277 to 12.4785 tok/s.
- The published Qwen drafter produced 52.58% approximate proposal acceptance
  and +23.86% approximate throughput, while strict identity failed on 4/6
  prompts.
- The custom Qwen v27 n=4 validation incumbent is 5.175% acceptance at 11.476
  tok/s, below target-only 17.592 tok/s and without exactness.
- Smaller capacity, early-position-only training, and block-17 alignment did
  not improve the custom Qwen acceptance screen; quantization produced only a
  small approximate gain.

### Reconciliation

The apparent conflict between better training metrics and worse serving
behavior is a repeated finding, not an indexing error. Capacity can improve
acceptance yet lose throughput; alignment can be necessary yet insufficient;
approximate acceptance or speed cannot support an exactness claim.

### Hypotheses

Verifier/runtime fidelity, shape-dependent quantized target states, and
contiguous-prefix acceptance are higher-value unknowns than another blind
capacity or average-CE sweep. These are hypotheses until a controlled test or
primary-source review supports them.

## Current roadmap

1. **Now — evidence closure:** record the critique's receipt/provenance gaps,
   classify exposed SmolLM test evidence as non-final, and freeze the Qwen
   validation screens as development-only. This is documentation-only.
2. **Next — literature:** complete the queued review of DFlash/DFlash2
   verification, rejection/correction, KV-cache transactions, and quantized
   shape dependence; write a paper note and map each claim to a test.
3. **Then — design:** planner turns the review into one bounded verifier-fidelity
   protocol with a sealed held-out boundary and exact/approximate contracts
   stated separately.
4. **Then — critique:** critic attacks confounds, baseline matching, target
   state construction, receipt completeness, and the break-even metric.
5. **Decision — user:** present the repaired card for explicit approval. Until
   then, no remote work or execution is authorized.
6. **After approval — execute and synthesize:** run the smallest preflight and
   terminal measurement, preserve negative evidence, update results/failures,
   and only then choose the next question.

## Recommended next action

The highest-value immediate action is the documentation-only evidence-closure
pass specified by the critique: preserve unknown receipt fields, classify
exposed test evidence, freeze the development-screen boundary, and canonicalize
the now-complete literature notes into the repository's `papers/` source of
truth (or explicitly link that layer) before treating the handoff as complete.
The subsequent experiment proposal requires a current CEO decision and is not
an authorization.
