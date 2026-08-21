# Literature verdict — PQ-004 runtime confidence inventory

Date: 2026-08-21  
Receipt: `runtime-confidence-adaptive-length-inventory-20260821.json`  
Verdict: **BLOCK for a DFlash2 adaptive-length run; precedent found, no
admissible existing DFlash2 selector**

## Mapping of preserved mechanisms

**Observed:** the pinned DFlash2 branch uses configured `n_max` and loops the
whole block; it does not inspect `p_min` or a confidence statistic. Its
`n_block_tokens` is `n_draft + 1`, so fixed block sizing is the only preserved
DFlash2 length control.

**Observed:** `p_min` early-stop exists on standard/EAGLE and non-DSpark paths,
but the inventory explicitly shows that it does not apply to DFlash2.

**Observed:** DSpark has a sigmoid confidence head and truncates at the first
confidence below `p_min`; this is a relevant implementation precedent, not
evidence that the DFlash2 model or path has the same head or semantics.

**Observed:** n-gram statistics record acceptance fractions and reset an
n-gram map after low-acceptance rounds; adaptive-p sampling changes token
sampling around a probability target. Neither adapts DFlash2 `n_max` or block
length.

These findings are consistent with the literature boundary: llama.cpp exposes
fixed draft-length controls and acceptance counters ([guide](https://github.com/ggml-org/llama.cpp/blob/master/docs/speculative.md),
[implementation](https://github.com/ggml-org/llama.cpp/blob/master/common/speculative.cpp));
DFlash's block shape and hidden-state/rollback interface are algorithm- and
runtime-specific ([paper](https://arxiv.org/abs/2602.06036),
[code](https://github.com/z-lab/dflash)); QSpec warns that quantized confidence
and acceptance can shift numerically ([arXiv:2410.11305](https://arxiv.org/abs/2410.11305)).

## Claim-to-test boundary

The fixed Q8_0 `n=4` result remains the only local evidence: 102/1971 accepted,
11.5572 tok/s, 7/12 target-content matches, and diagnostic exactness failure.
There is no adaptive-policy result. A DSpark or non-DFlash2 `p_min` mechanism
cannot be substituted into PQ-004 without changing the model/runtime path; a
new DFlash2 confidence scheduler would be a runtime implementation change.

## Recommendation

Keep PQ-004 **blocked** under its current card. The smallest repair is either a
new card that explicitly scopes an existing DSpark/non-DFlash2 path, or a new
runtime-change proposal that defines and hashes the DFlash2 confidence score,
threshold, score-to-`n` mapping, EOS/tie behavior, overhead accounting, and
unchanged cache/mask/position/sampler/correction semantics. Do not infer an
adaptive selector from fixed `n_max`, `p_min` outside DFlash2, n-gram statistics,
or sampler adaptation; no adaptive speed, quality, exactness, or losslessness
claim is supported.
