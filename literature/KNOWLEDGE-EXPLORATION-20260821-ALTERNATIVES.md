# Knowledge exploration — alternative Qwen hypotheses

Date: 2026-08-21  
Scope: source/notes-only exploration; no run, implementation, download, or
authorization. These hypotheses are deliberately distinct from PLAN-001's
singleton-versus-block schedule question, PQ-002's prefix objective, and
PQ-004's adaptive proposal length.

## 1. Verifier transaction: stale state after correction

**Observed:** LLM-42 replaces fast-path KV with verified KV after replay, and
VeriCache treats compressed/full cache restoration as part of correctness
([LLM-42 note](notes/llm42-2026.md), [VeriCache note](notes/vericache-2026.md)).
The local Qwen record has strict divergence but no complete per-rejection
transaction receipt.

**Hypothesis:** even if singleton and block target logits agree before a
rejection, the correction path may commit stale target/drafter KV, hidden
buffers, positions, allocator pages, or sampler state. The next-token mismatch
would therefore be a commit/rollback ownership failure, not a shape mismatch.

**Local observable:** for one forced accept, rejection, and correction cycle,
compare the post-commit state digest and next-token logits with a fresh
target-only replay from the same committed prefix; record rollback ranges and
sampler/RNG advance.

**Falsifier:** byte/tolerance-declared state, replay identity, and next-token
logits agree after every transaction; or divergence occurs before any
correction/rollback.

**Required identity/receipt:** pinned llama.cpp source/binary/build, target and
tokenizer hashes, sampler/seed, prompt/replay ID, candidate/correction IDs,
KV/hidden/mask/position/allocator state hashes before/after, rollback ranges,
and cleanup/device state. A text match alone is insufficient.

## 2. Serving overhead: launch/cache movement dominates target verification

**Observed:** v30 F16/Q4/Q8 arms are all slower than target-only despite
near-tied acceptance; SpecInfer and the production study warn that tree/block
padding, cache copies, scheduler, and target verification costs can dominate
([SpecInfer note](notes/specinfer-2023.md), [Performance or Illusion note](notes/performance-or-illusion-2026.md)).

**Hypothesis:** the Qwen serving gap is driven primarily by per-cycle launch,
HTTP/scheduler, cache movement, or prompt/target synchronization overhead,
rather than proposal length or export precision. A higher acceptance score
would not improve throughput until this phase cost is reduced.

**Local observable:** phase-separated repeated timing for prompt/prefill,
draft, target verification, correction, cache copy/rollback, scheduler/launch,
and total; compare sums to wall time and report per-prompt distributions.

**Falsifier:** target verification dominates and phase sums leave no material
launch/cache/scheduler residual, or an overhead reduction is absent when the
same runtime path is replayed.

**Required identity/receipt:** runtime commit and binary hash, compiler/CUDA/
driver/backend, threads/device split, target/drafter hashes and quantization,
sampler/seed, prompt manifest/order, warmups/repetitions, phase instrumentation
version, target-only and speculative baselines, VRAM, and final process state.
Do not convert phase timing into a speed claim without a matched correctness
contract.

## 3. Training representation: feature geometry/projection mismatch

**Observed:** DFlash conditions masked block prediction on target hidden states;
EAGLE-3 fuses multiple target layers and warns that feature extraction and
projection are architecture/runtime dependent ([DFlash note](notes/dflash-2026.md),
[EAGLE-3 note](notes/eagle-3-2025.md)). Qwen v31 improved teacher-forced
accuracy after block-shaped feature alignment but did not improve acceptance;
this does not isolate the representation interface.

**Hypothesis:** the drafter's target-layer projection, feature normalization,
or dtype geometry is miscalibrated for deployment states. The bottleneck is
representation interface (which layer/features and how projected), not the
PQ-002 loss weighting or a verifier transaction. A representation can fit
teacher-forced labels while mis-ranking autoregressive candidates.

**Local observable:** frozen-prefix feature/logit probes at the exact target
layer(s), projection input/output norms and dtypes, cosine/RMSE distributions,
per-position candidate margins, and acceptance conditional on feature regime;
compare teacher-forced and deployment-shaped feature manifests without changing
the verifier in the same causal comparison.

**Falsifier:** feature/projection distributions and candidate margins are
matched across the declared execution shape while acceptance remains low, or
acceptance changes only after verifier/cache semantics change.

**Required identity/receipt:** target/drafter checkpoint hashes, layer IDs,
projection/normalization implementation hash, feature/label manifest hashes,
shape/mask/position/dtype metadata, split/seed/optimizer if training is later
approved, evaluator hash, and separate fit/acceptance/exactness receipts with
held-out sealing.

## Boundary

These are alternative explanations and observables, not results or proposed
runs. Current canonical statuses remain unchanged: PLAN-001 is blocked on its
evaluator/Arm-B contract, PQ-002 lacks an admissible implementation artifact,
and PQ-004 lacks a DFlash2 adaptive selector. No hypothesis here authorizes a
runtime change, training, serving benchmark, or exactness claim.
