---
id: paper-eagle-2024
status: reviewed
---

# EAGLE: Speculative Sampling Requires Rethinking Feature Uncertainty

**Citation:** Yuhui Li, Fangyun Wei, Chao Zhang, Hongyang Zhang, ICML 2024,
[arXiv:2401.15077](https://arxiv.org/abs/2401.15077).

## Mechanism

**Verified fact:** EAGLE performs autoregression over a target-derived feature
(the paper motivates the second-to-top layer) rather than only over tokens. A
one-step-shifted token sequence reduces feature uncertainty; the draft then
produces token candidates that the target verifies.

## Claims and evidence

**Author claim:** on LLaMA2-Chat 70B, EAGLE reports 2.7–3.5x latency speedup and
roughly doubled throughput while maintaining the generated distribution.

**Weak point:** target-layer selection, feature extraction, and tree/sequence
shape are architecture- and runtime-dependent. A feature drafter is target-
dependent, unlike the original small-model interface.

## Mapping

The paper is the conceptual bridge to the project's DFlash work: both consume
target-side hidden information. Capture the exact target layer IDs, execution
shape, and feature dtype in every reproduction.
