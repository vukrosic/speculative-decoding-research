# CEO literature packet — Qwen already-implemented bounded axis

**Date:** 2026-08-21  
**Scope:** literature review and claim-to-test mapping only; no execution or
queue mutation.

## Decision

The only source-backed axis that is already implemented, reproducible from
local receipts, and independent of blocked PLAN-001/PQ-002/PQ-004 is the
v30 drafter-export precision comparison (F16 → Q4_K_M, with Q8_0 as a
comparator). It is a **bounded approximate drafter-form improvement**: Q4_K_M
was 0.38% faster than F16 in the fresh three-repetition screen and used 70 MiB
less peak VRAM. It is **not** an end-to-end Qwen improvement: every drafter arm
was slower than target-only, target-content was 7/12, and exactness was
diagnostic/failed.

**CEO eligibility:** **PASS only for an approximate compact-drafter baseline
or deployment-form selection; BLOCK for promotion as a Qwen serving-speed,
quality, lossless, or exactness improvement.** The receipt is terminal, so no
additional run is implied. If the goal requires a material end-to-end GPU
improvement, no already-implemented eligible axis exists; the smallest missing
artifact is a new hash-pinned implementation/evaluator contract (see the final
section).

## Exact implementation, runtime, and data identities

| Field | Pinned identity |
|---|---|
| Target | `Qwen3.8-27B-UD-IQ1_S.gguf`, SHA-256 `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887` |
| Drafter source | Preserved v27 compact DFlash16, gamma8/LS002, curve step 4000; F16 `8e3edd04ecacd949da675dcdbe0263689fa820ee729e4376137ed816a4b0be31` |
| Q4 arm | `qwen38-compact-dflash16-v27-gamma8-ls002-curve-step-4000-q4km.gguf`, SHA-256 `2a7828cfb7fa3ae704a7df4a36004341ec99ae99ab8bfe6e5262fe28430a63` |
| Q8 comparator | `...curve-step-4000-q8.gguf`, SHA-256 `f71a21453e2fc379585045d22ee55c51add979e529882a17cf0ccb9cecf4e4f4` |
| Runtime | llama.cpp lineage commit `5ecbe1ac17ec0484c5b44af0bd580cdc9c428ed4`; `llama-server` SHA-256 `78ccd846f70b6d632eb290c33be0b02f818c91b21fb0c126926c901cca5eb0d6` |
| Evaluator | `benchmark_client_v21.py` SHA-256 `477b271d3e34616282c3d4c85ea278d67441f1bf0be8dec5a366a7374f9a37a4`; validation wrapper `ea27524aad12b198f6a19c8c861c8a267542bac4e1b0f611a81c5f3f68037590`; target-only wrapper `6fd5a465aa356434bf919450f6684b79eaf1d7d115f70a31e14ab88bc579ebb3` |
| Data/contract | Frozen 12-prompt manifest SHA-256 `30668abcb12a25a8c6b69f8f54bcf5f8942df3b800c996a52ba28d4e9af1f914`; n=4, max completion 64, context 4096, seed 42, temperature 0, top-k 1, one warmup + three timed repetitions, one RTX 3060, no held-out data |
| Receipts | `receipts/EXP-20260821-004-v30-rerun-20260821/summary.json` (target-only `44ec15bb…`, F16 `f906269e…`, Q4 `3f594398…`, Q8 `3fba36ad…`), plus `environment.json`, `terminal.json`, and `cleanup.json` |

## Observed result

| Arm | Accepted/proposed | Mean tok/s | Peak VRAM | Target-content |
|---|---:|---:|---:|---:|
| Target-only | 0/0 | 17.3758 | 6,365 MiB | 12/12 |
| F16 | 102/1,971 | 11.5306 | 8,085 MiB | 7/12 |
| Q4_K_M | 103/1,967 | 11.5745 | 8,015 MiB | 7/12 |
| Q8_0 | 102/1,971 | 11.5572 | 8,033 MiB | 7/12 |

The Q4 comparison is +0.0439 tok/s (+0.38%) versus F16 and −5.8013 tok/s
(−33.4%) versus target-only. This is a local drafter-form delta, not a system
speedup.

## Source claim → local test → falsifier

| Source-backed claim | Local observable and boundary | Falsifier / unresolved point |
|---|---|---|
| QSpec ([2410.11305](https://arxiv.org/abs/2410.11305)) treats draft/target precision as an execution variable that can perturb logits and acceptance. | Only export format changed; target, runtime, evaluator, prompts, n, and flags were fixed. Compare accepted/proposed, target-content, timing, and VRAM separately. | A repeatable Q4 disadvantage, or a material acceptance/content shift, would refute the local near-tie; neither would establish exactness. |
| llama.cpp’s [speculative guide](https://github.com/ggml-org/llama.cpp/blob/master/docs/speculative.md) and [implementation](https://github.com/ggml-org/llama.cpp/blob/master/common/speculative.cpp) separate acceptance accounting from phase/end-to-end cost. | The receipt reports proposal/acceptance and tok/s independently; Q4 is slightly faster than F16 but all drafter arms lose to target-only. | Any claim that the Q4 delta is a general serving gain is falsified by the target-only comparator and by the narrow 12-prompt/n=4 screen. |
| DFlash ([2602.06036](https://arxiv.org/abs/2602.06036)) makes conditional block/hidden-state and losslessness claims. | This screen does not inspect singleton/block committed state, rollback, or exact token identity; 7/12 target-content is only a diagnostic. | A verifier-state/evaluator contract is still required before transferring a DFlash exactness or lossless claim to Qwen. |

## Smallest missing artifact for a true GPU-improvement claim

No existing Qwen artifact supports a material end-to-end improvement claim.
The minimum external artifact is **one immutable, hash-pinned implementation plus
receipt for a new causal change**, with the target/runtime/data/evaluator
identities above preserved. The lowest-risk dependency is the missing
PLAN-001 Arm-A/Arm-B verifier contract: canonical evaluator tuple, exact
deployment-shaped Arm-B layout, tokenizer identity, and committed-state/rollback
outputs. Until that artifact exists, a training-objective (PQ-002) or adaptive
policy (PQ-004) result cannot be interpreted as a Qwen GPU improvement.

This packet therefore records Q4_K_M as the sole already-implemented bounded
axis and preserves the stronger CEO disposition as **BLOCK**.
