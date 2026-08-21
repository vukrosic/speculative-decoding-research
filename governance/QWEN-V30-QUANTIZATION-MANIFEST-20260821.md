# Qwen v30 quantization candidate manifest

Status: `BLOCKED — candidate preparation only; no execution approval`  
Candidate: `EXP-20260821-004-qwen-v30-quantization`  
Purpose: prepare the highest-information bounded Qwen improvement rerun

## Causal question

With the v27 compact drafter, does changing only drafter export format
(`F16` versus `Q4_K_M` versus `Q8_0`) improve the approximate n=4 serving
screen under fixed target/runtime/data/evaluator controls?

This is an approximate validation experiment, not a lossless speculative
decoding claim. It must not be conflated with PLAN-001's blocked state-
localization contract.

## Preserved candidate evidence

- Target: Qwen3.8-27B IQ1_S, bound to the remote inventory receipt and target
  SHA-256 `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`;
  runtime source `5ecbe1ac17ec0484c5b44af0bd580cdc9c428ed4` and binary SHA-256
  `78ccd846f70b6d632eb290c33be0b02f818c91b21fb0c126926c901cca5eb0d6` are
  pinned in the same receipt.
- Candidate artifacts: F16 SHA-256
  `8e3edd04ecacd949da675dcdbe0263689fa820ee729e4376137ed816a4b0be31`;
  Q4_K_M SHA-256
  `2a7828cfb7fa3aece704a7df4a36004341ec99ae99ab8bfe6e5262fe28430a63`; Q8_0
  SHA-256 `f71a21453e2fc379585045d22ee55c51add979e529882a17cf0ccb9cecf4e4f4`.
- Existing screen: 12 validation prompts, 64-token generation, proposal
  length 4, F16/Q4/Q8 comparison; Q8_0 repeated three times.
- Observed historical result: Q8_0 mean 11.550 tok/s versus F16 11.476,
  7/12 target-content matches, and 34.3% below target-only 17.592 tok/s.
  Exactness failed; preserve this as approximate evidence only.

## Required immutable rerun tuple

Before planner/critic/CEO approval, a compact receipt must pin:

- target GGUF hash, v27 parent checkpoint hash, and both drafter hashes;
- runtime source/binary/compiler/CUDA/driver/backend/thread/device hashes;
- evaluator/logger path+commit/hash, exact command/configuration, dependency
  versions, 12-prompt manifest/order/hash, seed, flags, context, and n=4;
- matched target-only baseline receipt, warmup/repetition plan, timing/VRAM
  metrics, approximate target-content metric, and explicit exactness status;
- process ownership, one-GPU/one-process budget, cleanup state, and receipt
  paths/hashes.

The read-only inventory receipt
[`v30-provenance-supplement-20260821.json`](../receipts/PLAN-20260821-001/v30-provenance-supplement-20260821.json),
SHA-256 `fc7b84bbf2f599e376819589c3da2a79f6636fd030a901de938213e7e2f38ccb`,
closes the target, parent, candidate, prompt-manifest, contract, evaluator
wrapper/finalizer, runtime, flags, baseline, and historical receipt fields.

Remaining pre-run repairs are narrower: map the artifacts to a named
experiment receipt path, capture an explicit task-owned cleanup/device receipt
for the rerun, and preserve the inventory's lack of a quantization shell
transcript/lockfile as a non-required historical limitation because existing
artifacts—not new quantization—are the only candidates in scope. Do not infer
anything beyond this tuple.

The named receipt schema is
[`receipts/EXP-20260821-004-v30-rerun-20260821/README.md`](../receipts/EXP-20260821-004-v30-rerun-20260821/README.md).
It pre-registers one warmup plus three timed repetitions per arm, output-token
accounting, separated approximate metrics, task-owned cleanup, and terminal
GPU state. It is a schema only; no rerun has started.

## Approval and stop boundary

This manifest creates no queue permission and no GPU authorization. A future
rerun may change only export format and must use existing artifacts, no
downloads/installs/training/patches/held-out data, one remote RTX 3060 slot,
and a bounded time budget. Stop before comparison on any missing identity,
target-only baseline mismatch, exactness-contract confusion, resource risk, or
cleanup failure. A new planner packet, critic review, literature
reconciliation, and CEO decision are mandatory.
