---
id: PQ-20260821-002-OBJECTIVE-MATH-RECHECK-20260821
date: 2026-08-21
status: repair-needed
verdict: BLOCK
approval: NEEDS CEO APPROVAL
---

**2026-08-21 amended objective recheck — BLOCK pending one textual repair.**
The direct cumulative-log implementation closes the prior numerical math gate:
`r=max(log_softmax, log ε)`, FP32 cumulative sums, no prefix exponentiation,
explicit finite assertions, masks/EOS, BF16/FP32 policy, and gradient path are
now adequate. Frozen lineage/data hashes, objective-only scope, deterministic
checkpoint/tie/multiplicity rule, current baseline receipts, separated
exactness/speed boundaries, sealed-heldout and resource/receipt/cleanup gates
also pass as design. One exact ambiguity remains in the preceding numerical
policy paragraph, which still instructs implementers to use `p̂=max(p,ε)` and
“gradients through p̂,” while the amended objective correctly uses direct
`max(log_softmax, log ε)` and never computes `p̂` or a prefix probability. This
stale alternative could produce two implementations. **Repair:** delete or
replace that obsolete `p̂` sentence so the direct FP32 log-space definition is
the sole executable policy; then the math gate closes for renewed CEO review.
