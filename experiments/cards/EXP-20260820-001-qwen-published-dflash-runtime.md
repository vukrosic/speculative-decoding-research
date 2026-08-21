---
id: EXP-20260820-001-qwen-published-dflash-runtime
date: 2026-08-20
status: completed-negative
method: published DFlash2 drafter in llama.cpp PR runtime
exactness_contract: strict greedy token identity
heldout_touched: false
tags: [qwen, dflash2, runtime, quantization, exactness, approximate]
---

# Is the published Qwen DFlash2 path both exact and faster on RTX 3060?

## Frozen controls

- Target: Unsloth `Qwen3.8-27B-UD-IQ1_S.gguf`, SHA-256
  `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`.
- Drafter: matching published Q4_K_M DFlash2 GGUF; about 1.9B parameters;
  seven proposals. Exact hash should be backfilled from the v21 receipt.
- Runtime: isolated pinned llama.cpp DFlash2 PR lineage `5ecbe1ac`.
- Hardware: RTX 3060 12 GB; 4K context; six frozen representative prompts.
- Decoding: matched greedy settings, target-only receipt as oracle.

## Baseline

Same target under the same PR runtime, without the drafter.

## Observed

- Metadata compatibility and runtime load passed.
- Acceptance: 245/466 = 52.58%, approximately 3.50 accepted tokens per
  verification cycle.
- Target-only: 18.0908 tok/s.
- DFlash2: 22.4079 tok/s, +23.86% under this approximate comparison.
- Strict output identity failed on 4/6 prompts. Fresh target-only under the PR
  runtime matched the prior target oracle 6/6.

## Interpretation / hypotheses

The published drafter quality is useful, but the verifier/runtime path does not
meet the strict lossless contract for this IQ1_S target. The throughput result
is an approximate serving result, not an exact speculative-decoding speedup.
Later diagnosis found shape-dependent quantized target execution to be relevant,
but it did not establish a single exclusive cause.

## Reproduction

```bash
# Historical isolated-runtime command; exact flags are preserved in v20-v22
# benchmark receipts and must be copied here before rerunning.
/path/to/pinned/llama-dflash2/bin/llama-server --model Qwen3.8-27B-UD-IQ1_S.gguf --draft-model matching-dflash2-q4_k_m.gguf
```

## Artifacts and receipts

- Preserved external receipt lineage: v20 target/MTP, v21 DFlash2 comparison,
  v22 first-divergence diagnosis.
- This repository intentionally does not copy the target or drafter GGUFs.
- Held-out training/evaluation data was not used.

