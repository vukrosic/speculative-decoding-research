---
id: PQ-20260821-002-OBJECTIVE-FINAL-RECHECK-20260821
date: 2026-08-21
status: repair-needed
verdict: BLOCK
approval: NEEDS CEO APPROVAL
---

**2026-08-21 final objective re-review — BLOCK pending one exact notation
repair.** The obsolete p-hat/probability-product path is removed and the
direct FP32 log-softmax/log-epsilon cumulative-prefix policy is now singular;
mask/EOS behavior, BF16/FP32 precision, finite assertions, frozen lineage/data,
objective-only scope, deterministic selection, current baselines, separated
exactness/speed boundaries, held-out seal, resource limits, and receipt/cleanup
schema pass. One exact mathematical ambiguity remains: the CE equation still
uses `log p_{i,t,v}` although the preceding definition of `p` was removed and
the policy now mandates direct FP32 log-softmax. **Repair:** define
`ℓ_{i,t,v}=log_softmax(z_{i,t,:})_v` and rewrite `L_ce` using `ℓ` (also call
the prefix term log-probability rather than probability); then the math gate is
closed for renewed CEO review. No training or validation is authorized before
that notation repair.
