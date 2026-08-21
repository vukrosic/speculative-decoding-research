# Final literature gate — PQ-002 objective math

Date: 2026-08-21  
Verdict: **PASS for CEO consideration; not execution approval**

The direct FP32 log-softmax/log-epsilon policy is conceptually source-neutral
and preserves the intended objective-only causal change. The notation repair
now defines `ell=log_softmax(z)` in FP32, uses `ell` in `L_ce`, uses
`log_epsilon` in `r`, and describes the prefix term as log probabilities. The
acceptance-calibration boundary remains correct: `1/t`, `λ=1`, the
prefix-survival proxy, and any acceptance improvement are hypotheses, while
Chen/Yin require autoregressive acceptance to be measured separately from fit
loss.

The manifest is now suitable for CEO consideration (still not execution
approval), subject to the existing provenance caveats, fit gate, sealed
held-out data, and separate acceptance/exactness controls. It remains
secondary to PLAN-001's verifier/state localization.
