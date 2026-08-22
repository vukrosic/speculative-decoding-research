# EXP-020 six-prompt raw-margin inventory

Status: complete public-validation diagnostic; no correction was active.

The instrumented Q4 DFlash `n=1` runtime reproduced all six preserved Q4
outputs and exactly 227 completion tokens. Across 118 draft checks it accepted
104 drafts and rejected 14. The trace contains 228 raw-logit rows, 222 sampler
rows, and exactly one unpaired initial target row for each prompt.

The unsafe shortcut is now ruled out: replacing every accepted raw winner with
the runner-up when the target margin is below `0.1` would touch an
already-correct prompt.

- `code_python_debug` (the sole divergent output): accepted draft `471`, clean
  target runner-up `90563`, raw margin `0.0684490204`.
- `logic_schedule` (already matches target): accepted draft `271`, runner-up
  `198`, raw margin `0.0897636414`.
- No accepted draft in the six-prompt inventory has a raw margin below `0.05`.
- With a strictly predeclared `0.08` boundary, the divergent decision is the
  only observed accepted-draft trigger. This is a calibration fact on six
  public prompts, not a general exactness guarantee.

The next bounded candidate is therefore a default-off, public-validation
calibrated intervention: only at greedy `n=1` draft checks where the accepted
draft is the raw top-1 and `top1_logit - top2_logit < 0.08`, emit the raw
runner-up as the rejection correction. It must pass all six target output
hashes before any repeated timing gate. Failure retires this heuristic; it is
not broadened or retuned on the same workload.

Bound machine evidence:

- diagnostic summary SHA-256: `48dd0e988807b18d2e9998e68f3655f023abf5a31d5d22a88026b053b6a33465`
- server log SHA-256: `37e8b2dbf124d335a70d37007576d3d340ccb0563146a8865a69b5d97bdfcad5`
- client result SHA-256: `4f836bf9b42e1f17f12b29afc0cdf7b99bfe00c784a3b34112f02d0c6909d153`
- analysis SHA-256: `aa56895b06a69dd18c6bc9482e7bd4e1694f528efb951c5ca6d78f15fb1f00f1`
- analyzer SHA-256: `ee3667fc48dc3f1ddbdaec9636fad7f78185484fc0a7fb019d3b81035bcc7f63`
- frozen six-prompt contract SHA-256: `49de56c5e4249962753507fd2568e01502fc88cf7fce5e5371ca3c4aeea27d6b`

No held-out data, training, export, serving promotion, or general exactness
claim is involved.
