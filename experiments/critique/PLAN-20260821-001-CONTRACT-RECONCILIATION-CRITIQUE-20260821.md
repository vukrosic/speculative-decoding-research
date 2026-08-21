---
id: PLAN-20260821-001-CONTRACT-RECONCILIATION-CRITIQUE-20260821
date: 2026-08-21
status: blocked-preflight
verdict: BLOCK
receipt: receipts/PLAN-20260821-001/evaluator-armb-contract-reconciliation-20260821.json
receipt_sha256: 1d0dc945cc25b7dc8ac990b44cacfbfd0fe08ec023df2a2a66ce5b9fe8193d58
authorization: documentation-only; no execution or scope expansion
---

# PLAN-001 evaluator/Arm-B reconciliation critique

## Dated verdict — 2026-08-21

**BLOCK remains.** The new receipt is hash-valid and materially improves
provenance: it binds the pinned runtime lineage and binary SHA-256, target GGUF,
six-prompt manifest, historical source-component hashes, and the strict-greedy
diagnostic boundary. It also correctly preserves unresolved values rather than
inferring them. These are documentation gates only; no evaluator comparison or
GPU action occurred.

## Contract gates

### Closed or improved

- Receipt identity and read-only/no-execution scope are closed.
- Runtime lineage `5ecbe1ac17ec0484c5b44af0bd580cdc9c428ed4`, binary SHA
  `78ccd846f70b6d632eb290c33be0b02f818c91b21fb0c126926c901cca5eb0d6`, target
  SHA `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`, and
  prompt-manifest SHA `77a9b5703756102bc088891419a6b85f45bd6a26118c4daded334dec91db8514`
  are now pinned to preserved evidence.
- Historical sampler settings, positions, cache extents, mask behavior, and
  source hashes are useful reference fields, but remain historical—not proof
  of the exact PLAN-001 Arm-B schedule.

### Still hard-blocked

1. **Evaluator tuple is not bound.** The receipt leaves unknown per-record
   rendered-prompt hashes, deterministic replay IDs, committed-prefix/proposed/
   target token IDs, first divergence, correction/commit decision, sampler/RNG
   hash, exact logits shape/dtype/summary, state shape/dtype, serialized
   mask/position hashes, cache schema/state hashes and rollback transaction,
   complete evaluator/logger path and dependency hash, output-token accounting,
   and the target-only oracle token-hash binding.
2. **Arm-B deployment mapping is not proven.** Exact block width, positions,
   sequence IDs, serialized mask/hash, cache extents/state hashes, full KV
   contents, anchor transition, and source/config tie remain `UNKNOWN`. The
   historical `n_max=7`, block size 8, positions 169–175, and block2/block7
   extents are reference examples only and cannot close the PLAN-001 contract.
3. **Memory-after discrepancy remains unresolved.** The source description
   records `[171,171]`, while the parsed historical receipt records `[170,170]`.
   The receipt correctly marks this `UNRESOLVED UNKNOWN`; it must not be
   reconciled by inference or silently selected before an authorized recheck.

## Smallest repair and boundary

The smallest safe repair is a new approved source/introspection/evaluator-
contract task that emits one immutable PLAN-001 tuple and exact Arm-B layout
manifest, including the fields above and an explicit reconciliation or retained
unknown for the memory-after values. Until that artifact is reviewed and a CEO
amendment records the host/metadata unblock, keep Arm A/B/D comparison stopped.
No training, runtime patch, evaluator invention, SSH/GPU action, or receipt
population is authorized by this critique.

