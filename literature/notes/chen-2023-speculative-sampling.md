---
id: paper-chen-2023-speculative-sampling
status: reviewed
---

# Accelerating Large Language Model Decoding with Speculative Sampling

**Citation:** Charlie Chen et al., Google DeepMind, [arXiv:2302.01318](https://arxiv.org/abs/2302.01318).

## Mechanism

**Verified fact:** an autoregressive approximation model samples a lookahead
sequence; the large model evaluates the sequence in parallel; each token is
accepted with a probability based on target/proposal probabilities, with a
residual resample on the first rejection.

## Claims and evidence

**Author claim:** the Chinchilla 70B experiment reports 2–2.5x decoding speedup
in a distributed setup without changing the target model or sample quality.

**Verified fact:** proposal quality alone is not the objective; the acceptance
rule is what preserves the target distribution.

**Weak point:** proposal length can increase variance and wasted work. Matching
the paper requires the same sampling temperature, target/proposal distributions,
and numerical precision.

## Mapping

This is the baseline for distinguishing stochastic exactness from greedy
identity. A repository benchmark should state which contract is being tested.
