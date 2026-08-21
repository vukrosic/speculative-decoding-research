---
id: paper-performance-or-illusion-2026
status: reviewed
---

# Speculative Decoding: Performance or Illusion?

**Citation:** Xiaoxuan Liu, Jiaxiang Yu, Jongseok Park, Ion Stoica, Alvin Cheung,
[arXiv:2601.11580](https://arxiv.org/abs/2601.11580).

## Contribution

**Verified fact:** this is a systematic study of n-gram, EAGLE/EAGLE-3,
draft-model, and MTP variants on production-grade vLLM across workloads,
model scales, and batch sizes. It compares measured speed against a theoretical
upper bound.

## Findings

**Author claim:** target verification dominates execution; acceptance length
varies substantially by output position, request, and dataset; measured speed
often falls well below the theoretical upper bound.

**Weak point:** the conclusions are vLLM-specific and do not establish a
universal ranking of drafters or runtimes.

## Mapping

This source supports reporting distributions and phase timings, not only mean
acceptance. It also motivates a verifier/state receipt that makes target
verification, correction, rollback, and scheduler overhead separately visible.
