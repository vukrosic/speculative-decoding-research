# Literature verdict — PLAN-20260821 evaluator/Arm-B reconciliation

Date: 2026-08-21  
Receipt reviewed: `evaluator-armb-contract-reconciliation-20260821.json`  
Verdict: **BLOCK — reconciliation is complete as documentation; comparison is
not source-backed yet**

## Source mapping

DFlash requires block width, mask/anchor semantics, target-layer/hidden-state
interface, and rollback to be tied to the concrete runtime ([paper](https://arxiv.org/abs/2602.06036),
[code](https://github.com/z-lab/dflash)). LLM-42 makes committed-state
replacement and replay part of verified inference ([2601.17768](https://arxiv.org/abs/2601.17768)).
llama.cpp's [guide](https://github.com/ggml-org/llama.cpp/blob/master/docs/speculative.md)
and [implementation](https://github.com/ggml-org/llama.cpp/blob/master/common/speculative.cpp)
require runtime-specific shape, sampler, and numerical provenance. The receipt
correctly preserves these as requirements rather than promoting historical
v22 examples.

## Remaining unknowns

The evaluator still lacks a single immutable tuple binding rendered prompt and
replay ID, committed/proposed/target token IDs, correction and commit decision,
per-divergence logits/shape/dtype, serialized mask/positions, cache state before
and after rollback, sampler/RNG replay, dependency hash, and output-token
accounting. Arm-B still lacks exact width, positions, sequence IDs, serialized
mask/cache state, source/config tie, and anchor/extract transition. The
`[171,171]` versus `[170,170]` memory-after conflict remains unresolved.

## Smallest authorized metadata repair

Keep PLAN-001 blocked and authorize only one narrowly scoped **read-only
source/introspection/evaluator-contract task** to produce an immutable manifest
that either closes each field with a source/hash or records it as `unknown`.
The task must not load models, invoke inference, build/patch runtime code, or
use GPU/held-out data. If no existing source can bind the exact Arm-B schedule,
the manifest must say so; historical v22 values cannot be substituted. Only
after this metadata repair, a new CEO amendment and critic re-review may
consider Arm A/B/D execution.
