# Literature knowledge updates

Append-only review log. This file records durable changes in the literature
map; it does not record experiments or runtime mutations.

## 2026-08-21 — verifier/state localization becomes a first-class axis

### Findings

- [BlockVerify](notes/block-verification-2024.md) shows that verifier design
  can improve expected accepted length independently of drafter architecture.
- [Performance or Illusion](notes/performance-or-illusion-2026.md) reports that
  target verification dominates production-vLLM execution and that acceptance
  length is position-, request-, and dataset-dependent.
- [LLM-42](notes/llm42-2026.md) treats fixed-shape replay, KV replacement, and
  rollback as part of a deterministic inference contract.
- [VeriCache](notes/vericache-2026.md) treats compressed KV as a draft state and
  full KV as the verification state, making cache restoration part of
  correctness.

### Knowledge update

The research bottleneck should be localized before increasing drafter capacity:
the minimum unit of analysis is a speculative transaction over tokens, target
KV, drafter KV, hidden-state buffers, masks/positions, sampler state, allocator
pages, and batch-shape metadata.

### Uncertainties preserved

- Byte-equal state, numerically tolerant state, deterministic replay, and
  output identity are different contracts.
- A hidden-state or KV hash is diagnostic evidence, not automatically a proof
  of target equivalence.
- A matched prompt does not imply a matched runtime state when dynamic batching,
  quantization, or graph shape changes.

### Decision gate

Before any serving-speed claim, produce a verifier/state receipt showing the
committed-prefix identity, rollback ranges, state replacement, sampler/RNG
state, runtime/quantization metadata, and phase timings. The full proposal is
in [ceo-note-verifier-state-localization.md](ceo-note-verifier-state-localization.md).

## 2026-08-21 — v30 export-format rerun remains approximate and near-tied

### Observed

On the frozen 12-prompt n=4 screen, F16/Q4_K_M/Q8_0 drafter arms produced
11.5306/11.5745/11.5572 tok/s versus 17.3758 tok/s target-only; accepted
tokens were 102/1971, 103/1967, and 102/1971, and target-content matches were
7/12 for every arm and repetition. Exactness was failed diagnostically and
cleanup passed.

### Interpretation / hypothesis

The result is consistent with QSpec's warning that quantization is a distinct
numerical axis, but changing export format alone did not materially change
acceptance or the approximate screen. The small Q4_K_M timing edge is not a
general speedup; target verification/serving overhead remains the leading
hypothesis.

### Boundary

Preserve this as approximate validation evidence only. It does not establish
quality, exactness, losslessness, or a serving improvement, and it remains
separate from PLAN-001's verifier/state-localization contract. See the
[v30 result handoff](HANDOFF-20260821-V30-RESULT.md).
