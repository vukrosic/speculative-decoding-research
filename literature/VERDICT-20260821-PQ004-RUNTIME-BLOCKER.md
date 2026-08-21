# Literature verdict — PQ-004 runtime-change blocker

Date: 2026-08-21  
Reviewed: `PQ-20260821-004-RUNTIME-CHANGE-BLOCKER-20260821.md` and the pinned
confidence/adaptive-length source inventory  
Verdict: **PASS on the block; no unsupported policy assumption should be added**

## Assessment

The planner correctly refuses to create a DFlash2 adaptive-scheduler card from
fixed `n_max`, non-DFlash2 `p_min`, DSpark confidence, n-gram statistics, or
adaptive-p sampling. The inventory establishes that these are different
branches or different semantics; none is a source-backed DFlash2 selector.
The listed missing score, threshold, mapping, edge-case, implementation, and
overhead fields are therefore real design unknowns, not clerical omissions.

This matches the literature: llama.cpp documents draft-length controls and
acceptance counters but not a universal adaptive policy ([guide](https://github.com/ggml-org/llama.cpp/blob/master/docs/speculative.md),
[implementation](https://github.com/ggml-org/llama.cpp/blob/master/common/speculative.cpp));
DFlash's block/hidden-state/rollback behavior is runtime-specific ([paper](https://arxiv.org/abs/2602.06036),
[code](https://github.com/z-lab/dflash)); QSpec warns that quantization can
change confidence/logits and acceptance ([arXiv:2410.11305](https://arxiv.org/abs/2410.11305)).

## Smallest source-backed deliverable

Before any implementation card, produce a policy-spec manifest—not a run—that
labels each choice as `source fact`, `hypothesis`, or `recommendation` and
defines: confidence score tensor/position, threshold provenance, deterministic
score-to-`n` mapping, EOS/tie/NaN behavior, implementation boundary/hash,
scheduler overhead counter, and invariants for target verification,
cache/mask/positions, sampler, correction/rollback, and output accounting.
The fixed Q8_0 `n=4` receipt and target-only arm remain controls. If the policy
spec cannot be supplied without inventing these choices, retain BLOCK and do
not create a runtime-change card.
