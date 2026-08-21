# Literature verdict — PQ-002 implementation inventory

Date: 2026-08-21  
Receipt: `objective-implementation-inventory-20260821.json`  
Verdict: **BLOCK fitting; defer or separately scope implementation**

## Finding

The inventory found no preserved artifact implementing the complete frozen
PQ-002 tuple: FP32 `log_softmax`, `log_epsilon=log(1e-8)`, direct true-label
clamp, cumulative-log prefix sums, `L_prefix`, `λ=1`, EOS/mask handling, FP32
reduction, and finite gates. The listed v31 KD/CE scripts, llama.cpp
perplexity/imatrix helpers, and runtime sampler are generic log-softmax/NLL or
knowledge-distillation support; they are not the manifest's training
objective and cannot be promoted by analogy.

## Source/claim boundary

Log-softmax is a standard mathematical primitive, not evidence for the
prefix-survival objective. Chen ([arXiv:2302.01318](https://arxiv.org/abs/2302.01318))
and Yin ([arXiv:2411.00841](https://arxiv.org/abs/2411.00841)) support measuring
acceptance separately from fit loss, but neither supplies this repository's
implementation. The `1/t`, `λ=1`, clipping, mask, and cumulative-log choices
remain the frozen project hypothesis.

## Recommendation

Defer fitting. If the objective is still desired, create a separately scoped
implementation task/card (or an explicitly named approved wrapper) that
preserves the exact source bytes/hash, base trainer/dependencies, manifest
version, and unit/finite-gradient gates before any training. It must not alter
runtime, data, features, optimizer, evaluator, or selection policy. A generic
perplexity/KD/sampler helper is not an admissible substitute. No fitting,
exactness, quality, or speed claim is authorized by this verdict.
