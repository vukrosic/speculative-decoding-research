# Literature verdict — PQ-002 objective manifest

Date: 2026-08-21  
Reviewed: `PQ-20260821-002-OBJECTIVE-MANIFEST-20260821.md`  
Verdict: **PASS for CEO consideration as a bounded proposal; not execution
approval**

## Source-consistent fields

- One causal change is isolated: objective only; architecture, target layer,
  feature/label manifests, optimizer, runtime, evaluator, and splits are
  frozen and hashed.
- EOS/mask handling, FP32 reduction, finite/gradient gates, held-out sealing,
  and one-checkpoint selection are explicit and reproducible.
- Fit loss/accuracy, contiguous-prefix survival, autoregressive acceptance,
  target-content, timing, VRAM, and diagnostic exactness remain separate. This
  matches Chen ([arXiv:2302.01318](https://arxiv.org/abs/2302.01318)) and Yin
  ([arXiv:2411.00841](https://arxiv.org/abs/2411.00841)): proposal fit is not an
  acceptance or speed oracle.

## Hypothesis fields that must stay labelled

The `a_t=1/t` weighting, `λ=1.0`, unsmoothed prefix term, `ε=1e-8`, and the
claim that teacher-forced prefix survival will improve autoregressive
acceptance are proposed choices, not results or literature theorems. The
prefix product is a training diagnostic/proxy; it does not establish the
target/proposal distribution relationship required by the speculative-sampling
contract. DFlash's target-feature and block-shape dependence ([paper](https://arxiv.org/abs/2602.06036),
[code](https://github.com/z-lab/dflash)) means any acceptance gain must still
be checked under the frozen runtime path.

## CEO-readiness and boundary

The manifest is sufficiently specified for CEO consideration after the
provenance caveats are carried into receipts (trainer file hashes rather than
a source commit, optimizer/sampler reset, and feature-manifest identity
bundle). It remains secondary to PLAN-001's verifier/state localization: a
better drafter objective may not repair a target singleton/block mismatch.
Approval must require a finite-fit gate, validation-only checkpoint selection,
separate acceptance and exactness rows, sealed held-out data, and a fresh
correctness gate before any timing or quality interpretation. No training,
exactness, losslessness, quality, or speed claim is authorized by this verdict.
