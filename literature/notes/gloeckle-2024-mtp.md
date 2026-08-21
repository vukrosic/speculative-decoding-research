---
id: paper-gloeckle-2024-mtp
status: reviewed
---

# Better & Faster Large Language Models via Multi-token Prediction

**Citation:** Fabian Gloeckle et al., [arXiv:2404.19737](https://arxiv.org/abs/2404.19737).

## Mechanism

**Verified fact:** the model uses a shared trunk with independent output heads
to predict several future tokens at each training position. The paper presents
MTP primarily as an auxiliary training objective, not as a complete verifier.

## Claims and evidence

**Author claim:** the authors report improved sample efficiency/downstream
performance and up to 3x faster inference for four-token prediction in their
experiments.

**Weak point:** independent heads are not the same as recursively conditioned
MTP modules. A runtime must define how head proposals are verified and cached.

## Mapping

Use this note to keep “MTP improves training” separate from “MTP is a
lossless speculative decoder.” Compare head predictions under exact replay and
measure the incremental head cost.
