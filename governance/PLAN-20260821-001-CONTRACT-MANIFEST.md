# PLAN-20260821-001 contract manifest

Status: `BLOCKED — documentation manifest; not an execution approval`  
Date: 2026-08-21  
Source receipts: [remote-preflight-supplement-20260821.json](../receipts/PLAN-20260821-001/remote-preflight-supplement-20260821.json);
[read-only evaluator/layout inventory](../receipts/PLAN-20260821-001/evaluator-armb-layout-inventory-20260821.json)
(SHA-256 `bb1d4a6dd6bf3567454992d526219fdb2b393c1084f33ab6afaacd1bf98c623e`).

## Frozen identities already closed

- Target GGUF SHA-256: `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`.
- Embedded tokenizer: `gpt2` model, `qwen35` pre-tokenizer, 248,320 tokens,
  247,587 merges, EOS `248046`, PAD `248055`, BOS `248044`, mask `248070`;
  tokenizer identity is bound to the target GGUF because no separate artifact
  exists.
- Runtime source: llama.cpp DFlash PR lineage `5ecbe1ac17ec0484c5b44af0bd580cdc9c428ed4`.
- Runtime binary SHA-256:
  `78ccd846f70b6d632eb290c33be0b02f818c91b21fb0c126926c901cca5eb0d6`.
- Prompt manifest SHA-256:
  `77a9b5703756102bc088891419a6b85f45bd6a26118c4daded334dec91db8514`;
  six frozen prompt IDs, context 4096, seed 42, greedy flags.

## Required PLAN-001 evaluator tuple

The eventual evaluator must pin, in one receipt or manifest:

1. committed prefix and prompt/rendered-prompt hash;
2. proposed token IDs and target token IDs;
3. correction token and acceptance/commit decision;
4. cache/state before and after each rollback transaction;
5. deterministic replay identifier and exact target-only oracle output; and
6. evaluator/logger commit and artifact hash.

The record schema must additionally carry, for every prompt and cycle:

- cycle index and absolute position IDs;
- proposed IDs, target IDs, correction ID, and target top-1/logit summary;
- state shape, dtype, sequence IDs, and committed-prefix identifier;
- per-record mask/position IDs and cache before/after summaries;
- evaluator path, exact command/configuration, dependency/version identity,
  and deterministic replay ID.

The evaluation boundary is **six-prompt strict-greedy diagnostic only**. It
does not support general exactness/losslessness, quality, acceptance, or
end-to-end speed claims, and it cannot touch sealed holdouts.

Historical partial components are retained as context, not promoted to this
contract:

- `test-v22-block-equivalence.cpp`, SHA-256
  `636e9fb4a9b1c16d8f433fdfac9f1eaa320d19d70b012945c2bd9178656aef92`;
- `finalize_diagnosis_v22.py`, SHA-256
  `54b48fc99364807a23e6064c0503b5ff599157af9b38cce5541ed7aedb4a29d5`;
- `trace_one_prompt_v22.py`, SHA-256
  `6d2349a1e29512dcf946e365e0b14fd1093a77c9e5d8a34c900f1863cae11f8e`;
- historical terminal receipt SHA-256
  `080fe7cf3337c7b7ed1fe67ef321f1651afbe049099dbc36de074dd0d1c38f06`.

Current evaluator status: **unknown as a complete PLAN-001 tuple**; the
required fields above must remain explicit `unknown` until pinned.

## Required Arm-B layout manifest

The manifest must explicitly identify the exact deployment-shaped target-only
schedule emitted by the pinned runtime: block width, absolute positions,
sequence IDs, causal mask/schema, cache extents and serialized state before/
after the block, anchor/n_extract semantics, and the source/config hash tying
these fields to PLAN-001 Arm B.

Historical v22 evidence records block2/block7 positions, causal-mask controls,
cache extents, and negative perturbations, but does not prove equivalence to
the pinned deployment-shaped Arm-B schedule and does not preserve full mask or
cache tensors. It remains reference evidence only.

Current Arm-B status: **unknown as the exact PLAN-001 deployment schedule**.

The read-only inventory captured historical runtime metadata (`n_max=7`,
`block_size=8`, mask token `248070`, `n_extract=5`,
`sample_from_anchor=true`, selector top-k 16, target layers `[6,20,34,48,62]`)
and source/receipt hashes. These values remain historical/context evidence;
they do not close the PLAN-001 mapping. Serialized mask/cache schema, the
complete evaluator tuple, and a singleton memory-after discrepancy (`[171,171]`
versus `[170,170]`) remain explicitly unknown.

## Gate and recovery

This manifest is documentation-only. The single blocker is an end-to-end
PLAN-001 execution contract that pins both the evaluator tuple and exact Arm-B
layout. The smallest safe recovery is a read-only source-backed manifest or
receipt that closes those fields; no model/inference/evaluation action may be
used to fill them under the current decision. After closure, literature,
planner, and critic must re-review and the CEO must issue a new written
amendment before any Arm A/B/D comparison.
