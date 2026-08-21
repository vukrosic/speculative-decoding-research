---
id: paper-vericache-2026
status: reviewed
---

# VeriCache: Turning Lossy KV Cache into Lossless LLM Inference

**Citation:** Jiayi Yao et al., [arXiv:2605.17613](https://arxiv.org/abs/2605.17613).

## Mechanism

**Verified fact:** VeriCache uses a compressed KV cache to draft tokens and a
full KV cache to verify them. It keeps the full cache off the fast HBM path and
stages verification so compressed-KV drafting and full-KV reload use different
resources.

## Claims and evidence

**Author claim:** the framework supports a family of lossy KV compressors while
producing the same output as full-KV decoding, with up to 4x throughput in the
reported long-context and remote-prefix settings.

**Weak point:** the claim depends on full-KV availability, swap scheduling,
cache restoration, and the declared greedy/sampling contract. It is not evidence
that an arbitrary compressed cache is target-equivalent by itself.

## Mapping

VeriCache generalizes the state-localization idea beyond a separate drafter:
the compressed and full caches are two execution states with one commit oracle.
It is a useful adjacent reference for quantization/KV experiments.
