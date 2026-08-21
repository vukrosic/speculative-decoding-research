---
id: paper-quantspec-2025
status: reviewed
---

# QuantSpec: Self-Speculative Decoding with Hierarchical Quantized KV Cache

**Citation:** Rishabh Tiwari et al., [arXiv:2502.10424](https://arxiv.org/abs/2502.10424), [code](https://github.com/SqueezeAILab/QuantSpec).

## Mechanism

**Verified fact:** QuantSpec combines self-speculative decoding with a
hierarchical quantized KV cache for long-context/edge settings. The proposal
path and cache compression are co-designed rather than adding a conventional
second full draft model.

## Claims and evidence

**Author claim:** the paper reports memory and throughput improvements on its
long-context benchmarks while retaining task quality.

**Weak point:** quantized cache error and early/self-exit behavior can change
acceptance and output distributions. The quality contract is workload- and
precision-dependent.

## Mapping

Include KV precision and cache eviction/rollback policy in runtime metadata.
QuantSpec is adjacent to QSpec: one changes the cache and self-draft path,
the other switches execution precision for draft versus verify.
