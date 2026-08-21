# Prioritized experiment queue

Planner-owned queue, updated 2026-08-21. This file is documentation only. No
job, training run, download, evaluation, remote action, or external action is
authorized by its existence.

The repository's canonical orchestration queue is [`queue/INDEX.md`](../../queue/INDEX.md).
The existing `PLAN-20260821-001` verifier-fidelity entry is blocked on the
literature handoff `LIT-20260821-001`; this planner queue preserves that
dependency and does not supersede its state machine.

## Queue rules

- Preserve the current cards, receipts, negative results, and sealed held-out
  controls. A queue item is not a result.
- Freeze target, drafter, tokenizer, data/splits, evaluator, seed, decoding,
  runtime, and hardware before implementation. Change one causal variable per
  item.
- Keep teacher-forced loss/accuracy, autoregressive acceptance, quality,
  end-to-end speed, and exactness as separate evidence classes.
- Run the smallest construction/correctness/fit gate first. Do not open sealed
  held-out data until a validation checkpoint is selected.
- The entries below are proposals, not authorization. Under the current
  delegated policy, the CEO may approve a bounded in-scope experiment after
  complete literature, planner, and critic inputs; anything outside that
  boundary requires separate user approval.

## Priority summary

| Priority | Planning ID | Causal question | Why now | Estimated cost |
|---|---|---|---|---|
| P0 | PQ-20260821-001 | Is Qwen strict divergence caused by target execution shape or verifier state handling? | The published path showed 52.58% approximate acceptance but failed strict identity on 4/6 prompts; v31 also measured shape-dependent target states. Blocked on canonical LIT-20260821-001. | Low–medium: one bounded runtime diagnosis, about 1 GPU-hour if artifacts are already present |
| P0 | PQ-20260821-002 | Can an acceptance-calibrated objective improve contiguous prefixes over v27? | v27 showed intermediate acceptance optima; v29 showed early-only loss is insufficient; loss/accuracy alone have not predicted acceptance. | Medium–high: one bounded training run plus validation screen, about 2–4 GPU-hours |
| P1 | PQ-20260821-003 | Can intermediate SmolLM depth recover some five-layer acceptance at lower latency? | Five layers improved acceptance but reduced guarded throughput by 13.51%; one layer remains the throughput incumbent. | Medium: one fit/acceptance/timing comparison, about 1–2 GPU-hours |
| P1 | PQ-20260821-004 | Can confidence-gated proposal length improve Qwen’s acceptance/overhead trade-off? | Fixed n=4/8/16 are all slower than target-only; adaptive length is an open question and needs a pre-registered policy. | Low–medium: runtime-only screen, about 30–60 minutes |
| P2 | PQ-20260821-005 | Does paired singleton/block-17 state consistency address the remaining Qwen interface mismatch? | v31 established shape dependence and that alignment alone was not sufficient; a consistency objective is the next discriminating training test. | High: feature preparation plus bounded training, about 4–8 GPU-hours |

## Diversity and coverage annotations — 2026-08-21

These tags classify the five existing proposals; they do not create, authorize,
reprioritize, or promote an experiment. “Expected information gain” is a
planning estimate about the stated question, not an observed result. Existing
statuses and approval/dependency boundaries remain exactly as written below.

| Planning ID | Causal axis | Expected information gain | Current dependency / status boundary |
|---|---|---|---|
| PQ-20260821-001 | Runtime execution shape and verifier state semantics (singleton versus deployment-shaped block schedule) | **Very high / P0** — directly localizes the strict-divergence mechanism before training or serving claims | Canonical `LIT-20260821-001`, pinned evaluator/Arm-B contract, and recovered drafter identity; remains blocked and diagnostic-only. |
| PQ-20260821-002 | Training objective (direct FP32 cumulative-log prefix survival) | **High if the implementation gate closes / P0** — tests whether a prefix-aligned loss moves acceptance rather than CE proxy metrics | Additive objective-implementation manifest, critic review, and CEO amendment; remains `NEEDS-CEO-AMENDMENT`/blocked before fit. |
| PQ-20260821-003 | Drafter architecture capacity (intermediate decoder depth) | **Medium / P1** — separates depth-versus-throughput trade-off after identity and evaluator gates | Existing SmolLM target/data/evaluator identities, additive fit, and explicit user approval; remains queue-only. |
| PQ-20260821-004 | Runtime scheduling policy (confidence-gated proposal length) | **High conditional on a deterministic policy / P1** — directly tests whether fewer weak proposals recover overhead without retraining | Source-backed score/threshold/selector implementation and separate runtime-change approval; remains blocked and queue-only. |
| PQ-20260821-005 | Training objective plus paired execution-shape state consistency (singleton versus block-17) | **Medium–high but expensive / P2** — tests a mechanism left after shape dependence and alignment-only evidence, with confounding risk | Preserved v31 paired-state manifests/hashes, frozen consistency coefficient/feature contract, and user approval; remains deferred queue-only. |

### Coverage map and explicit gaps

The current backlog spans five distinct axes: target execution semantics
(001), loss/objective (002), capacity (003), runtime scheduling (004), and
paired-state consistency (005). This gives coverage of the main runtime,
training, and architecture hypotheses without treating any one evidence class
as a substitute for another.

Documented gaps are intentionally left as gaps rather than new cards:

- **No runnable item currently exists.** 001 and 004 have unresolved runtime or
  policy contracts; 002 needs its implementation artifact and CEO amendment;
 003 and 005 still require explicit user approval and their stated data/fit
  gates.
- **No standalone tokenizer/prompt/evaluator identity experiment exists.**
  Those identities are preflight dependencies of 001–005, not an unregistered
  sixth proposal; missing identity evidence must stop the dependent item.
- **No independent quantization-only or data-composition axis is in this
  planner queue.** Existing v30 quantization and historical data receipts are
  controls/evidence, not newly proposed causal changes.
- **No serving-promotion item is independent of correctness.** Timing appears
  only as a downstream metric in the existing proposals and remains gated by
  target identity, evaluator, cache/correction, and exactness/target-content
  checks.

These gaps do not alter the current priority table, proposal text, approval
flags, receipt paths, or sealed-held-out boundaries.

Portfolio next-action ranking: [`QWEN-NEXT-ACTION-RANKING-20260821`](QWEN-NEXT-ACTION-RANKING-20260821.md)
— PLAN-001 contract closure is the next documentation-only lane; all proposal
statuses and execution boundaries remain unchanged.

---

## PQ-20260821-001 — Qwen verifier/shape exactness localizer

**Dependency / state**  Follows canonical `PLAN-20260821-001`; remains blocked
until `LIT-20260821-001` produces its required primary-source and pinned-runtime
note and the approval boundary is recorded. The repaired named card is
[`PLAN-20260821-001-qwen-target-schedule-localizer`](../cards/PLAN-20260821-001-qwen-target-schedule-localizer.md)
and its per-experiment critique is
[`PLAN-20260821-001-PRE-RUN`](../critique/PLAN-20260821-001-PRE-RUN.md).

**Question**  Under the pinned quantized runtime, does changing only target
execution from singleton calls to the deployment-shaped block schedule change
the next-token state for the same committed prefix?

**Hypothesis**  The IQ1_S target can produce materially different intermediate
states when executed as singleton versus speculative block calls, and the
published verifier/cache path propagates that difference into a first-token
divergence. If the target-only negative controls remain stable, a localized
shape/state mismatch will explain the strict failure without implying a drafter
quality problem.

**Fixed variables**

- Target GGUF: Unsloth `Qwen3.8-27B-UD-IQ1_S.gguf`, SHA-256
  `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`.
- Runtime: isolated pinned llama.cpp DFlash2 PR lineage `5ecbe1ac`.
- Six frozen representative prompts, 4K context, matched greedy decoding, and
  the existing target-only oracle from EXP-20260820-001.
- Target quantization, tokenizer, prompt order, context, seed, and evaluator
  must remain unchanged. No model or runtime upgrade is allowed in this item.

**Changed variable**  Target execution schedule only: target-only singleton
versus target-only deployment-shaped block calls. The published speculative
trace and cache/rollback round trip are separate diagnostic arms/negative
controls; no runtime patch, quantization change, drafter change, or correction
semantic change is bundled.

**Data**  The six frozen prompts and target-only output references used by
EXP-20260820-001; no training or held-out data.

**Target / drafter**  Target is the IQ1_S Qwen GGUF above. Drafter is the
published matching Q4_K_M DFlash2 GGUF from the same experiment; its immutable
hash must be recovered from the preserved v21 receipt before execution. The
target-only path is the required negative control.

**Baseline**  Fresh target-only replay under PR lineage `5ecbe1ac`, plus the
existing published-drafter result: 245/466 approximate acceptance, 22.4079
tok/s versus 18.0908 tok/s target-only, and strict identity failure on 4/6.

**Metrics**

- Exact target-token identity per prompt and first divergence position.
- Singleton/block hidden-state and logits deltas at the first divergent step.
- Accepted/proposed tokens and target-call/correction counts.
- Cache/position/mask transaction checks and process cleanup state.
- Timing is diagnostic only; no speed claim is permitted unless strict identity
  passes under the defined contract.

**Stopping rule**  Stop immediately on load, target-only replay, or cache
negative-control failure. Otherwise stop after the six-prompt replay and the
first-divergence trace. If no stable shape/state difference is observed, record
the result as non-localizing and do not broaden the sweep without a new card.

**Risks**  The drafter hash and historical flags may be missing; target
quantization can make small numerical deltas hard to attribute; a six-prompt
screen cannot establish general exactness. Any unresolved cause remains
`unknown`, not a runtime bug claim.

**Cost**  Low–medium: existing artifacts only, one bounded RTX 3060 runtime
diagnosis (estimate: up to 1 GPU-hour), no training or downloads.

**CEO DECISION REQUIRED**  **Queue proposal only; execution is not authorized
until the CEO records a bounded approval under the current policy.**

**Named card / critique**  See
[`PLAN-20260821-001-qwen-target-schedule-localizer`](../cards/PLAN-20260821-001-qwen-target-schedule-localizer.md)
and [`PLAN-20260821-001-PRE-RUN`](../critique/PLAN-20260821-001-PRE-RUN.md).

---

## PQ-20260821-002 — Qwen acceptance-calibrated objective

Readiness audit: [`PQ-20260821-002-READINESS-20260821`](PQ-20260821-002-READINESS-20260821.md)
— **BLOCKED-PREFLIGHT** after executor found no executable implementation of
the proposed objective. Planner implementation verdict:
[`PQ-20260821-002-IMPLEMENTATION-PREFLIGHT-VERDICT-20260821`](PQ-20260821-002-IMPLEMENTATION-PREFLIGHT-VERDICT-20260821.md)
— **BLOCK; CEO amendment required**. Provenance recheck:
[`PQ-20260821-002-PROVENANCE-VERDICT-20260821`](PQ-20260821-002-PROVENANCE-VERDICT-20260821.md)
— lineage/data identities are pinned; objective manifest is linked below.
Proposed objective: [`PQ-20260821-002-OBJECTIVE-MANIFEST-20260821`](PQ-20260821-002-OBJECTIVE-MANIFEST-20260821.md)
— policy remains frozen as the sole intended causal change, but no execution
is authorized until an implementation artifact is separately pinned and
approved. Final inventory disposition:
[`PQ-20260821-002-IMPLEMENTATION-INVENTORY-DISPOSITION-20260821`](PQ-20260821-002-IMPLEMENTATION-INVENTORY-DISPOSITION-20260821.md)
— **DEFER**; no preserved candidate implements the complete objective tuple.

**Question**  Can an objective that weights contiguous-prefix survival improve
Qwen n=4 acceptance over the v27 curve-step-4000 incumbent without relying on
teacher-forced loss as a proxy?

**Hypothesis**  A prefix-survival objective that retains supervision at all 16
positions but weights early positions and the product of surviving prefixes can
improve first-position and contiguous-prefix acceptance. It should outperform
the v29 early-positions-only continuation, which fell from 5.175% to 4.819%.

**Fixed variables**

- Target: Qwen3.8-27B IQ1_S, target layer 62, unchanged target hash and
  quantization.
- Drafter architecture: v27 compact block-17, 47,206,656 parameters;
  initialization and parent checkpoint fixed to v27’s declared parent.
- Data: the frozen 9,944 train / 508 source-disjoint validation windows and
  v23b/v23f feature/label manifests; held-out remains sealed.
- Optimizer family, seed 42, BF16, AdamW 1e-4, betas 0.9/0.95, weight decay
  0.01, batch 2, runtime, evaluator, and proposal screen n=4/8/16.

**Changed variable**  Training objective only: replace v27’s position-weighted
hard-label CE (`gamma=8`, label smoothing 0.02) with a pre-registered
prefix-survival weighting that still includes every position. The proposed
first implementation is normalized `w_t = 1/t` on per-position CE plus
`lambda=1.0` times a differentiable penalty on the negative log of each
surviving prefix; freeze this formula before fitting. Architecture, features,
labels, and optimizer must not change with the objective.

**Data**  Same frozen train/validation windows as v27; no new trajectories and
no held-out access during training or model selection.

**Target / drafter**  Target is Qwen3.8-27B IQ1_S at layer 62. Drafter is the
47.21M v27 compact block-17 architecture, exported F16 for training-screen
comparability; Q8_0 deployment is a later serving variable, not part of this
causal test.

**Baseline**  v27 curve step 4000 for n=4 (102/1,971 = 5.175%, 0.20198
accepted/cycle, 11.476 tok/s) and the same v27 step-3200/epoch-04 checkpoints
for n=8/n=16. v29 early4 is a negative control, not a replacement baseline.

**Metrics**

- Fit/validation CE and teacher-forced accuracy, reported separately.
- Per-position teacher-forced hits and contiguous-prefix survival by length.
- Autoregressive acceptance, accepted/cycle, and n=4/n=8/n=16 screen results.
- Target-content matches and strict exactness status; never infer either from
  CE or acceptance.
- End-to-end tok/s only for a selected candidate and only after the correctness
  gate; target-only remains 17.592 tok/s on the existing screen.

**Stopping rule**  First require finite construction, backward, and bounded-fit
  gates. Screen intermediate checkpoints on the frozen validation set; stop the
  run if loss/accuracy improves while all prefix/acceptance metrics regress for
  two consecutive checkpoints, or if the fit gate fails. Select at most one
  validation checkpoint. Do not open held-out data unless it beats v27 n=4 by
  at least 10% relative acceptance and passes the pre-registered exactness/
  quality gate; otherwise retain as validation-only evidence.

**Risks**  Prefix weighting may overfit the small 508-window screen; objective
  gains may not survive block-shaped target states; the current approximate
  runtime cannot support an exact speed claim. The objective is a single causal
  change, but any feature-state mismatch remains a possible interaction.

**Cost**  Medium–high: one bounded training run and three proposal-length
  validation screens on the existing RTX 3060 setup (estimate: 2–4 GPU-hours;
  no new data or downloads).

**CEO APPROVAL**  **SUSPENDED BEFORE FITTING — implementation amendment
required; see** [`CEO-DECISION-2026-08-21-PQ002`](../../governance/CEO-DECISION-2026-08-21-PQ002.md).
The historical approval and queue-only labels remain preserved as evidence;
any scope outside the eventual amendment still requires separate user
approval.

---

## PQ-20260821-003 — SmolLM intermediate-depth drafter

**Question**  Can a three-layer SmolLM DFlash2-style drafter recover part of the
five-layer acceptance gain while preserving the one-layer throughput advantage?

**Hypothesis**  The five-layer candidate’s +1.1521 percentage-point acceptance
gain is partly recoverable at an intermediate depth, with less draft latency
than the 20.96M five-layer model. A three-layer candidate may therefore improve
throughput relative to five layers, but this is uncertain because the five-layer
training selected identity-initialized epoch 0.

**Fixed variables**

- Target: SmolLM2-135M-Instruct snapshot and manifest hash from EXP-20260821-006.
- Data: existing 18k train / 1k validation / 1k test on-policy-20k trajectories;
  fixed balanced 90-prompt comparison (30 chat, 30 code, 30 document).
- Block size 4 / 3 proposals, greedy decoding, `max_new_tokens=32`, evaluator
  and official DFlash source commit `07ebd93db9f472af339b644bb70221ad8428328a`
  plus the compatibility bridge.
- RTX 3060 environment, seed and AdamW protocol match EXP-20260821-006.

**Changed variable**  Draft decoder depth only: one-layer baseline versus one
three-layer identity-initialized candidate. Do not simultaneously change width,
objective, data, or runtime. The exact three-layer parameter count must be
recorded by the fit gate rather than inferred here.

**Data**  Existing on-policy-20k train/validation/test manifests; no new data
generation. The fixed 90 prompts are for selection and timing; final sealed
held-out evaluation is out of scope for the bounded comparison.

**Target / drafter**  Target is SmolLM2-135M-Instruct (134,515,008 parameters).
Baseline drafter is the 6,520,256-parameter one-layer checkpoint. Candidate is
the new three-layer bridge built additively from the documented bridge family.

**Baseline**  One-layer fixed-90 acceptance/timing incumbent: 6.0045% overall
acceptance, 14.4277 tok/s, and 180/180 exact guarded outputs. The five-layer
result (7.1566%, 12.4785 tok/s, 180/180 exact) is the capacity reference.

**Metrics**

- Exact parameter count, finite fit gates, validation CE/accuracy.
- Fixed-90 accepted/proposed, accepted/cycle, and per-position acceptance.
- Target-equivalent output count under the exact guard.
- Matched end-to-end tok/s, wall time, mean/median/p95 latency, target-call
  counts, and peak VRAM over at least three repetitions per model.
- Final process/GPU-idle state and compact receipt hashes.

**Stopping rule**  Stop on construction, finite-gradient, evaluator, or exact
guard failure. Otherwise complete the fixed-90 acceptance and repeated timing
screen. Do not run sealed held-out evaluation unless the candidate passes exact
guard and beats the one-layer baseline on end-to-end throughput; if acceptance
improves but throughput does not, retain it as a bounded research result only.

**Risks**  Identity initialization makes this a bounded depth/serving test, not
proof that three-layer training is optimal. The 90-prompt slice and three timing
repetitions are narrow. Additional depth may improve acceptance but still lose
to target verification and launch overhead, as five layers did.

**Cost**  Medium: one additive fit plus acceptance and timing screen (estimate:
  1–2 GPU-hours, existing artifacts only).

**CEO DECISION REQUIRED**  **Queue proposal only; execution is not authorized
until the CEO records a bounded approval under the current policy.**

---

## PQ-20260821-004 — Qwen confidence-gated proposal length

Readiness audit: [`PQ-20260821-004-READINESS-20260821`](PQ-20260821-004-READINESS-20260821.md)
— **BLOCKED** pending an immutable confidence-policy/threshold and
implementation identity; v30 model/runtime/evaluator provenance is closed.
Policy inventory: [`PQ-20260821-004-POLICY-INVENTORY-20260821`](PQ-20260821-004-POLICY-INVENTORY-20260821.md).
Adaptive-source verdict: [`PQ-20260821-004-ADAPTIVE-INVENTORY-VERDICT-20260821`](PQ-20260821-004-ADAPTIVE-INVENTORY-VERDICT-20260821.md)
— no existing DFlash2 selector; a separate runtime-change card would be
required. Card blocker: [`PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-20260821`](PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-20260821.md).
Critique: [`PQ-20260821-004-FINAL-CRITIQUE-20260821`](../critique/PQ-20260821-004-FINAL-CRITIQUE-20260821.md).
Literature: [`VERDICT-20260821-PQ004-POLICY`](../../literature/VERDICT-20260821-PQ004-POLICY.md).

**Question**  Can a pre-registered confidence gate choose fewer than four
proposals on weak prefixes and improve the Qwen acceptance/overhead trade-off
over fixed n=4?

**Hypothesis**  Fixed n=8 and n=16 add low-yield proposals, while a confidence
gate can stop early on uncertain prefixes and retain most n=4 accepted tokens.
Because target verification and runtime overhead dominate in current screens,
the likely outcome is a clearer break-even boundary rather than a proven speedup.

**Fixed variables**

- Target Qwen3.8-27B IQ1_S, v27 curve-step-4000 drafter, Q8_0 deployment export,
  target layer 62, tokenizer, runtime, evaluator, and 12-prompt validation
  screen.
- Prompt order, 64-token generation contract, greedy decoding, and target-only
  baseline remain fixed. Threshold selection must use only the existing train
  split or a pre-registered constant.

**Changed variable**  Proposal scheduling policy only: confidence-gated
  `n∈{1,2,3,4}` with one threshold frozen before validation replay. No drafter
  retraining, quantization change, or evaluator change.

**Data**  The existing 12 source-disjoint validation prompts for the serving
  screen; no held-out data. The train split may be used only to choose the
  threshold before validation is opened.

**Target / drafter**  Target is Qwen3.8-27B IQ1_S. Drafter is the v27
  47.21M compact block-17 export in Q8_0, whose repeated n=4 screen averaged
  11.550 tok/s and remained approximate.

**Baseline**  Fixed n=4 Q8_0 (103/1,967, 11.550 tok/s) and target-only
  17.592 tok/s on the same validation contract. Fixed n=8/n=16 are secondary
  descriptive references, not new baselines.

**Metrics**

- Accepted/proposed and accepted/cycle, grouped by chosen proposal length.
- Number of target verifications, rejected/corrected tokens, and draft calls.
- End-to-end tok/s, latency distribution, and peak VRAM over repeated runs.
- Strict target identity or target-content matches under the defined contract;
  report approximate results separately from exactness.

**Stopping rule**  Stop if the policy changes prompt ordering, violates cache/
  correction invariants, or fails the target-only negative control. Run the
  pre-registered threshold once on all 12 prompts and repeat timing only if
  acceptance/cycle is not lower than fixed n=4. Do not claim a serving win
  unless exactness passes and tok/s beats target-only with repeated timing.

**Risks**  Twelve prompts are underpowered for threshold selection; confidence
  can be poorly calibrated under quantization; adaptive control overhead may
  erase saved draft work. A result is approximate if strict identity fails.

**Cost**  Low–medium: runtime-only validation and repeated timing (estimate:
  30–60 minutes on the existing GPU; no training or downloads).

**CEO DECISION REQUIRED**  **Queue proposal only; execution is not authorized
until the CEO records a bounded approval under the current policy.**

---

## PQ-20260821-005 — Paired singleton/block-17 state consistency

**Question**  Does explicitly regularizing the drafter against both singleton
and deployment-shaped block-17 target states improve Qwen contiguous-prefix
acceptance after alignment-only training failed?

**Hypothesis**  v31 showed that singleton and block-17 target states differ
  materially (auxiliary-context RMSE 1.0999; target-hidden RMSE 0.2648), while
  block-17-aligned continuation alone did not improve acceptance. A paired-state
  consistency term may prevent the drafter from fitting one execution shape at
  the expense of the other.

**Fixed variables**

- Target Qwen3.8-27B IQ1_S, layer 62, quantization, tokenizer, runtime,
  evaluator, and 47,206,656-parameter v27 architecture/initialization.
- Same hard-label CE family, seed 42, AdamW settings, proposal screen, and
  source-disjoint validation protocol as v27/v31.
- Held-out data sealed; no runtime or quantization changes.

**Changed variable**  Add one pre-registered singleton-versus-block-17 hidden
  state consistency term to the v27 objective while retaining all-position hard
  CE. Feature extraction format and consistency coefficient are the only new
  design choices and must be frozen before fitting.

**Data**  Reuse the existing v31 1,536 train / 152 validation block-17 subset
  only if its manifests and hashes are available; otherwise stop at the missing
  artifact gate rather than silently regenerate data. No held-out access.

**Target / drafter**  Target is Qwen3.8-27B IQ1_S at layer 62. Drafter is the
  v27 compact block-17 model, with v27 step-4000 as the parent checkpoint.

**Baseline**  v27 n=4 incumbent (102/1,971 = 5.175%, 11.476 tok/s,
  target-content 7/12) and v31 epoch-5 aligned continuation (4.812% n=4,
  11.352 tok/s). These are validation/approximate references only.

**Metrics**

- Feature/state RMSE and anchor/mask equality checks for both execution shapes.
- CE, teacher-forced accuracy, per-position hits, and contiguous-prefix survival.
- n=4/n=8/n=16 acceptance, accepted/cycle, target-content matches, and exactness
  status.
- End-to-end speed only after a correctness gate; preserve target-only baseline.

**Stopping rule**  Stop before training if block-17 manifests, hashes, or state
  alignment gates are unavailable. During fitting, stop on non-finite loss,
  state-consistency failure, or two consecutive validation checkpoints with
  lower prefix acceptance than v27. Select one checkpoint at most; keep held-out
  sealed unless the candidate clears a pre-registered acceptance and correctness
  gate.

**Risks**  The consistency term introduces objective/data confounding and may
  trade away useful target information. The tiny aligned subset and shape-
  dependent quantized states limit generalization. This is intentionally P2,
  after the runtime localizer and simpler objective test.

**Cost**  High: paired feature preparation plus bounded training and validation
  (estimate: 4–8 GPU-hours, existing artifacts only; no downloads).

**CEO DECISION REQUIRED**  **Queue proposal only; execution is not authorized
until the CEO records a bounded approval under the current policy.**

## Queue disposition

Until the canonical literature/design/critique gates are satisfied, explicit
user approval and a new experiment card exist, all five items are planner
backlog proposals, not active canonical queue entries, `authorized`, `running`,
or `promoted`. In particular, PQ-20260821-001 cannot advance past the existing
LIT-20260821-001 dependency. The queue deliberately does not modify existing
cards, receipts, indexes, artifacts, or remote state.
