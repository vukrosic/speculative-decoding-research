# Literature re-check — PQ-002 objective manifest amendment

Date: 2026-08-21  
Verdict: **PASS for CEO consideration; cumulative-log repair is source-neutral
and numerically clearer**

The amendment correctly replaces probability-product reconstruction with direct
FP32 `log_softmax`, clipped true-label log probabilities, and a cumulative
log-survival sum. This removes unnecessary exponentiation/underflow risk while
leaving the proposed causal objective unchanged. EOS masks, finite-value and
gradient gates, all-position supervision, one-checkpoint selection, and metric
separation remain explicit.

The repaired arithmetic is implementation policy, not evidence that the
objective improves acceptance. The `1/t` weights, `λ=1`, unsmoothed prefix
term, clipping epsilon, and teacher-forced prefix-survival-to-acceptance link
remain hypotheses. Chen ([arXiv:2302.01318](https://arxiv.org/abs/2302.01318))
and Yin ([arXiv:2411.00841](https://arxiv.org/abs/2411.00841)) still require
autoregressive acceptance to be measured separately from fit loss; DFlash's
target-feature/block runtime dependence ([paper](https://arxiv.org/abs/2602.06036),
[code](https://github.com/z-lab/dflash)) still limits interpretation.

CEO readiness remains conditional on the existing provenance caveats and a
fresh approval/fit gate. The candidate remains secondary to PLAN-001; no
training, exactness, quality, or speed claim is authorized.
