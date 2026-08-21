# Literature verdict — PLAN-20260821 evaluator/Arm-B inventory

Date: 2026-08-21  
Receipt reviewed: `evaluator-armb-layout-inventory-20260821.json`  
Disposition: **BLOCK — source-backed partial evidence, contract incomplete**

## Observed

The inventory adds immutable hashes for the preserved v22 C++ diagnostic,
finalizer, prompt tracer, runtime `common/speculative.cpp`, DFlash model source,
logs, and historical receipts. It records useful partial fields: prompt and
rendered-prompt hashes, row logits/top-1 summaries, selected-layer tensors,
memory sequence ranges, batch token counts, historical block positions,
sequence IDs, causal-mask controls, and cache-extents diagnostics.

## Literature sufficiency

This evidence is consistent with the literature requirements: DFlash requires
explicit block/anchor/hidden-state semantics ([paper](https://arxiv.org/abs/2602.06036),
[code](https://github.com/z-lab/dflash)); verified speculation treats correction
and committed state as part of the contract ([Leviathan et al.](https://arxiv.org/abs/2211.17192),
[Chen et al.](https://arxiv.org/abs/2302.01318), [LLM-42](https://arxiv.org/abs/2601.17768));
llama.cpp makes shape, backend, sampler, and rollback runtime-specific
([guide](https://github.com/ggml-org/llama.cpp/blob/master/docs/speculative.md),
[implementation](https://github.com/ggml-org/llama.cpp/blob/master/common/speculative.cpp)).
The inventory therefore closes provenance for historical diagnostics, not the
PLAN-001 claim-to-test tuple.

## Remaining blockers

- No single immutable evaluator receipt contains committed prefix, proposed and
  target IDs, correction/commit decision, serialized mask and cache state,
  replay ID, and evaluator/dependency identity together.
- No standalone target-only Arm-B receipt proves that the historical v22 block
  shape is the pinned deployment-shaped schedule; serialized mask/KV contents
  and anchor/n_extract state transitions are absent.
- The preserved singleton memory-after description conflicts with a parsed
  historical receipt (`[171,171]` versus `[170,170]`); this is unresolved and
  must not be repaired by inference.

## Recommendation / boundary

Keep PLAN-001 blocked. The smallest admissible repair is a new source-backed
manifest or receipt that pins the complete evaluator tuple and exact Arm-B
layout, with all unavailable tensor/state fields explicitly `unknown`. No
paper claim, historical shape, or partial hash closes these fields; no
execution, exactness, losslessness, quality, or speed claim is authorized by
this literature verdict.
