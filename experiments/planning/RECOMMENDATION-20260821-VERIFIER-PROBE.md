# Planner recommendation — verifier/state-localization probe

Date: 2026-08-21  
Owner: experiment planner  
Source queue entry: [`PLAN-20260821-001`](../../queue/2026-08-21-PLAN-001-verifier-fidelity-probe.md)  
Related detail: [`PQ-20260821-001`](EXPERIMENT-QUEUE.md)  
Named card: [`PLAN-20260821-001-qwen-target-schedule-localizer`](../cards/PLAN-20260821-001-qwen-target-schedule-localizer.md)  
Per-experiment critique: [`PLAN-20260821-001-PRE-RUN`](../critique/PLAN-20260821-001-PRE-RUN.md)  
Approval state: **BLOCKED-PREFLIGHT; prior bounded approval suspended**

## Recommendation

The repaired proposal is approved only for one causal question: **does
target-only singleton versus deployment-shaped block execution change the
greedy target trajectory under the pinned quantized runtime?** Arm D remains a
negative control; Arm C is excluded.

This makes the drafter and speculative acceptance path out of scope for the
bounded run. If its immutable drafter hash and historical flags are later
recovered, it requires a new amendment/card; do not silently add it here. The
bounded run is target-only Arm A/B plus Arm D cache/rollback state control; do
not patch or train in this probe.

## Proposed approval scope after repair

### Fixed variables

- Target: Unsloth `Qwen3.8-27B-UD-IQ1_S.gguf`, SHA-256
  `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`.
- Pinned llama.cpp DFlash lineage `5ecbe1ac`; binary/build, tokenizer, greedy
  sampler, seed, flags, evaluator, 4K context, prompt order, and target-only
  oracle are mandatory preflight captures. Stop before comparison if any are
  unavailable; do not guess values.
- Six frozen prompts from EXP-20260820-001; no training or sealed held-out data.
- One RTX 3060 session, one process, and the same target weights/precision in
  both schedule conditions.

### Single changed variable

Target execution schedule only: singleton target calls versus deployment-shaped
block calls replaying the same token prefix. Do not change quantization,
runtime revision, sampler, correction rule, cache implementation, or drafter
in the causal comparison.

### Metrics and evidence contract

- Target-only token identity per prompt and first-divergence position.
- Per-step hidden-state/logit deltas, with shape and position labels.
- Deterministic repeat agreement for each schedule and cache/position/mask
  integrity checks.
- No acceptance or throughput claim in this probe. Published-drafter
  acceptance remains the prior approximate observation, not a result of this
  test.

## Stop rules and resource limits

- Stop before comparison if the fresh singleton target-only replay does not
  reproduce the existing six-prompt oracle, or if any target/runtime build,
  tokenizer, prompt, evaluator, or flag identity cannot be verified.
- Stop if the block-shaped target-only path cannot replay the same prefix or
  violates cache/position/mask integrity.
- Run only the six prompts under the two schedules, with one deterministic
  repeat; stop after the first-divergence trace or a clean non-localizing
  result. Do not broaden prompts, shapes, quantization, or runtime versions.
- Maximum resource budget: one RTX 3060 session, one GPU slot, at most one
  hour wall time, existing artifacts only, no downloads, installs, training,
  generation beyond the frozen replay, or external writes.
- Store only a compact receipt (commands, hashes, state deltas, cleanup, and
  final device/process state). No weights, corpora, or binary traces in Git.

## Execution blockers that must be cleared

1. `LIT-20260821-001` is source-note-complete but still in canonical
   `evidence-review`/canonicalization-pending state. The queue's G1 handoff
   must be closed before this probe advances.
2. Create the immutable experiment card and the required per-experiment
   critique record/index entry. A queue proposal is not a run contract.
3. Backfill or explicitly preserve as `unknown` the pinned runtime build
   metadata (compiler, CUDA/driver, and evaluator hash), and freeze the prompt
   manifest/hash and target-only oracle receipt.
4. The published speculative trace is excluded from this run. A future trace
   requires a new amendment after its immutable GGUF hash and historical flags
   are recovered.
5. The critic must confirm that the block-shaped target-only replay is a real
   single-variable comparison; otherwise return the design for another repair.

## CEO handoff

**Terminal update:** the executor performed read-only preflight on local macOS
arm64 and stopped before comparison because the RTX 3060 slot and mandatory
runtime/environment identities were unavailable. No retry is authorized until
an approved execution host/session and preserved v20–v22 metadata are provided.
The bounded approval is suspended; no cache patches, drafter training,
downloads, or follow-up runtime experiments are authorized.

## Planner reconciliation — v30 quantization rerun (2026-08-21)

The separate CEO-approved v30 rerun completed under its own approximate
contract. The result is preserved in the [queue entry](../../queue/2026-08-21-EXP-004-v30-rerun.md)
and [summary receipt](../../receipts/EXP-20260821-004-v30-rerun-20260821/summary.json).

### Observed

| Arm | Acceptance | Target-content | Mean tok/s (stdev) | Peak VRAM |
|---|---:|---:|---:|---:|
| target-only | n/a | 12/12 | 17.376 (0.067) | 6,365 MiB |
| F16 | 102/1,971 = 5.175% | 7/12 | 11.531 (0.014) | 8,085 MiB |
| Q4_K_M | 103/1,967 = 5.236% | 7/12 | 11.574 (0.010) | 8,015 MiB |
| Q8_0 | 102/1,971 = 5.175% | 7/12 | 11.557 (0.014) | 8,033 MiB |

All arms produced 625 completion tokens per repetition. Cleanup passed and the
RTX 3060 finished idle with no task-owned inference process. A Q8 path typo
occurred before any server/model process and was corrected before the approved
sequence.

### Interpretation / next action

Q4_K_M was marginally fastest, but all drafter forms remained approximately
33% below target-only and shared the same 7/12 target-content count. This is a
bounded approximate negative result: no meaningful serving improvement or
exactness/quality/losslessness claim is supported. The next highest-information
planner action is to repair or explicitly retain the blocked PLAN-20260821-001
evaluator/layout contract; do not repeat v30 export formats. Existing PQ-004
and other planner proposals remain preserved and unauthorized.
