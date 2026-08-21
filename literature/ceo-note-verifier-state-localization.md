# CEO note: verifier/state-localization proposal

**Status:** proposal only; no experiment or runtime change was run.

## Decision requested

Approve the verifier/state-localization axis as the next documentation-led
research priority. The aim is to determine whether current DFlash2/Qwen
uncertainty is caused by the drafter, the verifier, or committed-state drift.

## Evidence motivating the proposal

- [BlockVerify](notes/block-verification-2024.md) shows that verification itself
  can be improved independently of the drafter.
- [Performance or Illusion](notes/performance-or-illusion-2026.md) reports that
  target verification dominates production execution and that acceptance is
  highly non-stationary.
- [LLM-42](notes/llm42-2026.md) makes decode–verify–rollback state replacement
  explicit for deterministic inference.
- [VeriCache](notes/vericache-2026.md) treats compressed/full KV states as a
  draft/verify pair and identifies cache restoration as part of correctness.

## Proposed invariant

Represent each speculative step as a transaction starting from a committed
state:

`S = (committed tokens, target KV, drafter KV, target hidden-state buffers, position/mask state, sampler/RNG state, allocator pages, batch-shape metadata)`

The drafter creates tentative state `T`. The verifier returns an accepted
prefix, a correction token or residual sample, and a replacement target state.
Only the verifier-produced state for the committed prefix may survive. Every
rejected token, cache page, hidden-state slot, and sampler/RNG advance must be
discarded or restored according to the declared contract.

## Minimum receipt before speed claims

1. Prefix/token hashes and target-only versus speculative output identity.
2. Candidate tokens, target logits/argmax, accepted-prefix length, and
   correction location.
3. Rollback ranges for target KV, drafter KV, hidden-state buffers, positions,
   and allocator pages.
4. Batch shape, sampler/RNG state, numerical mode, runtime revision, and
   quantization metadata.
5. Phase timings: draft, target verification, correction, rollback/cache
   restore, scheduler, and total serving time.

## What this would clarify

The first localization question is whether singleton and block-shaped target
execution produce different hidden-state or KV states before verification. If
they do, the feature interface is suspect; if they do not but committed state
diverges after rollback, the verifier/cache transaction is suspect. Only after
both invariants hold should drafter capacity or objective changes be compared.

## Uncertainties

- Exact state equality may be byte-level, numerical-tolerance, or output-level;
  the chosen contract must be explicit.
- A hidden-state hash is diagnostic, not automatically a correctness oracle.
- Runtime schedulers may change batch shape between target-only and speculative
  runs, so “same prompt” is not sufficient for a matched comparison.

## CEO-facing recommendation

Keep this as a bounded, high-information axis: first design the receipt and
state ownership map, then run one narrowly authorized verifier/state audit. Do
not expand drafter training or claim serving speed until the committed-state
invariant is either passed or explicitly relaxed.
