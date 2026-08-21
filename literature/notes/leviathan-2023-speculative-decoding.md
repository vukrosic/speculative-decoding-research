---
id: paper-leviathan-2023-speculative-decoding
status: reviewed
---

# Fast Inference from Transformers via Speculative Decoding

**Citation:** Yaniv Leviathan, Matan Kalman, Yossi Matias, ICML 2023,
[arXiv:2211.17192](https://arxiv.org/abs/2211.17192).

## Mechanism

**Verified fact:** a small approximation model drafts a sequence, the target
model scores all draft positions in parallel, and a modified rejection sampler
accepts a prefix or samples a correction from the residual target distribution.

**Verified fact:** the algorithm does not require changing or retraining the
target model, and the theorem is distributional rather than a claim that every
floating-point implementation will be bit-identical.

## Claims and evidence

**Author claim:** experiments with T5-XXL report roughly 2–3x acceleration with
identical outputs in the tested setup.

**Weak point:** the speed number depends on target/draft placement, batch shape,
proposal length, and the cost of target verification. The paper's theorem does
not establish a speedup for a different runtime or quantization.

## Mapping to this repository

Use this paper as the correctness reference for a stochastic sampler and as the
reason to keep an exactness oracle separate from acceptance and throughput.

**Hypothesis:** a batch-one replay that samples from the residual distribution
is a stronger first gate than comparing only greedy argmax tokens.
