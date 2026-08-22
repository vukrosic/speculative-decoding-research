# EXP-020 token-divergence localization

Date: 2026-08-22

Scope: log-only comparison of the preserved target-only trace and the
instrumented Q4 DFlash `n=1` trace. No model was loaded and no inference was
run for this analysis.

## Bound inputs

- target server log SHA-256: `90d6c2e64b2eb60b7cd06301d47042fb70618ea63cac7d2e316721fead3d1ccc`
- instrumented Q4 server log SHA-256: `a96c18030ba65cbc2f8f47b06a8af823081697a16780fa72243054a7c9291c11`
- parser SHA-256: `a7e53cf4c2e63dc9359f12db9ea0682d66ee8398a84d3ed406e5f96a46c7e5ff`
- machine-readable output SHA-256: `a6df8676dea3875a130110b0363f8d9130fbef732911fbdedf738a77e531559d`

## Finding

Both traces emit 64 tokens. They share an exact 42-token prefix. The first
divergence is output token 43 (zero-based index 42):

- target-only: token `90563`, logged piece tail `` `- ``
- Q4 DFlash: token `471`, logged piece tail ` -`

The Q4 token is not a rejection correction. It is the draft token accepted by
verifier cycle 25:

- sampled predecessor: token `460` at position 174
- proposed and accepted draft: token `471` at position 175
- cycle correction: token `16`
- accepted draft count: 1/1
- rollback: 0
- target memory extent after the cycle: `[175, 175]`

The clean target token `90563` matches neither the cycle's sampled token,
draft token, nor correction token. Therefore the final-text mismatch is first
caused by an accepted-draft decision made from target verifier state that is
not behaviorally equivalent to the clean singleton target state at the same
42-token prefix.

Seven one-token rejection/rollback cycles occur before the divergence,
including consecutive rejections at cycles 22 and 23. The Q4 target context
also records `n_rs_seq=1`, while the target-only context records `n_rs_seq=0`.
This makes the recurrent-state snapshot/rollback path the next bounded causal
axis. It is evidence for a state-path mismatch, not yet proof that rollback is
the only cause.

## Claim boundary

This receipt localizes the first mismatch. It does not prove exactness, a
corrected runtime, or a deployable speedup. The previously observed matched
cache-off speed lead remains a separate result: Q4 DFlash `n=1` averaged
18.1638816661 tok/s versus 16.0895399687 tok/s target-only (+12.892486%), with
five of six prompt output hashes matching.
