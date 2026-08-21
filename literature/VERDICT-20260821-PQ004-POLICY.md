# Literature verdict — PQ-20260821-004 policy inventory

Date: 2026-08-21  
Receipt reviewed: `PQ-20260821-004-POLICY-INVENTORY-20260821.md`  
Verdict: **BLOCK for adaptive execution; fixed-`n=4` baseline remains valid approximate evidence**

## Fixed evidence versus adaptive evidence

**Observed — fixed `n=4`:** the pinned v30 Q8_0 receipt records 102/1971
accepted/proposed, 11.5572 tok/s, 7/12 target-content matches, and failed
diagnostic exactness under the frozen target/runtime/evaluator/prompt contract.
Its logs expose `n_max=4`, `block_size=17`, mask ID, and fixed runtime flags.
These are realized outcomes after a fixed proposal and do not measure a
confidence score.

**Observed — adaptive policy:** no confidence statistic, score source,
threshold, deterministic score-to-`n` mapping, EOS/tie rule, `n=1` path,
implementation hash, or policy-overhead counter is preserved. Fixed-log
acceptance counters cannot be promoted to adaptive evidence.

## Literature contract

llama.cpp documents draft-length controls and separates acceptance from timing
([guide](https://github.com/ggml-org/llama.cpp/blob/master/docs/speculative.md),
[implementation](https://github.com/ggml-org/llama.cpp/blob/master/common/speculative.cpp)).
DFlash makes block shape, masks, hidden-state extraction, and rollback
runtime-specific ([paper](https://arxiv.org/abs/2602.06036),
[code](https://github.com/z-lab/dflash)). QSpec warns that quantization can
change logits and acceptance ([arXiv:2410.11305](https://arxiv.org/abs/2410.11305)).
Therefore an adaptive claim requires a frozen policy definition and evidence
that cache/mask/position, sampler, and correction semantics remain unchanged.

## Boundary and smallest repair

The confidence-gated idea remains a bounded hypothesis, not a result. Keep
PQ-004 blocked until a source-backed policy artifact or new card pins the score
definition/source, threshold provenance, selector mapping, EOS/tie behavior,
implementation hash, and scheduler-overhead accounting. Then compare once to
the fixed Q8_0 baseline, reporting acceptance, target-content, timing, and
exactness separately. No adaptive speed, quality, exactness, or losslessness
claim is supported by the current inventory; creating the policy implementation
would be a new runtime change requiring fresh review and approval.
