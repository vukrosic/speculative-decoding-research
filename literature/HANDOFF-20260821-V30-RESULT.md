# 2026-08-21 literature handoff — v30 export-format result

This note maps the completed `EXP-20260821-004` rerun to the canonical
quantization/runtime literature. It is an approximate validation result, not a
PLAN-001 verifier-state or exactness result.

## Observed

- Frozen target/runtime/evaluator/prompt contract completed three timed
  repetitions per arm after one warmup; target-only baseline was
  **17.3758 tok/s** (stdev 0.0667).
- Drafter throughput was **11.5306 tok/s** (F16), **11.5745 tok/s** (Q4_K_M),
  and **11.5572 tok/s** (Q8_0). Q4_K_M was 0.38% above F16; all three were
  slower than target-only.
- Accepted/proposed totals were 102/1971 (F16), 103/1967 (Q4_K_M), and
  102/1971 (Q8_0). Target-content matches were **7/12 on every repetition**
  for every drafter arm; exactness was recorded as failed/diagnostic-only.
- Peak VRAM was 8,085 MiB (F16), 8,015 MiB (Q4_K_M), 8,033 MiB (Q8_0), and
  6,365 MiB target-only. Cleanup passed and the GPU/process state was idle.
- A pre-execution Q8 path typo was corrected before any server/model process
  started; the terminal receipt states no result artifact was affected.

## Source mapping and hypotheses

**Observed / source-consistent:** QSpec's complementary-quantization framing
([arXiv:2410.11305](https://arxiv.org/abs/2410.11305)) treats draft/verify
precision as a real execution variable and warns that numerical changes can
alter logits and acceptance. The near-identical acceptance and content rows
here show no material screen improvement from the export-format change.

**Observed / runtime-consistent:** llama.cpp's [speculative guide](https://github.com/ggml-org/llama.cpp/blob/master/docs/speculative.md)
and [implementation](https://github.com/ggml-org/llama.cpp/blob/master/common/speculative.cpp)
separate acceptance counters from end-to-end timing and note backend/precision
effects. This rerun therefore supports only the measured approximate rows;
it does not support a speedup claim.

**Hypothesis:** under this target/runtime and n=4 screen, drafter export
precision is not the binding bottleneck; target verification and serving
overhead dominate. This is consistent with the broader runtime observation in
[Performance or Illusion](notes/performance-or-illusion-2026.md), but is not
isolated causally by this rerun.

## Recommendation and boundaries

Keep the result as negative/near-tie approximate evidence: Q4_K_M is the
slightly fastest drafter arm, but all drafter arms remain below target-only and
all have 7/12 target-content matches. Do not call target-content match
“quality,” and do not infer acceptance, exactness, or general serving speed
from it. The result neither proves nor refutes DFlash's source-level
distribution/losslessness claim; it only fails this local strict-greedy
diagnostic. Do not merge this screen with PLAN-001's singleton/block state
localization contract.

Receipts: [summary](../receipts/EXP-20260821-004-v30-rerun-20260821/summary.json),
[environment](../receipts/EXP-20260821-004-v30-rerun-20260821/environment.json),
[terminal](../receipts/EXP-20260821-004-v30-rerun-20260821/terminal.json), and
[cleanup](../receipts/EXP-20260821-004-v30-rerun-20260821/cleanup.json).
