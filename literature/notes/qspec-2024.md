---
id: paper-qspec-2024
status: reviewed
---

# QSpec: Speculative Decoding with Complementary Quantization Schemes

**Citation:** Juntao Zhao et al., EMNLP 2025, [arXiv:2410.11305](https://arxiv.org/abs/2410.11305), [official implementation](https://github.com/hku-netexplo-lab/QSpec).

## Mechanism

**Verified fact:** QSpec uses the same quantized weights and KV cache but
switches execution precision: a fast activation-and-weight quantized path
drafts, while a higher-precision weight-only path verifies.

## Claims and evidence

**Author claim:** the paper reports up to 1.64x over high-precision quantized
baselines and up to 1.55x in batched comparisons with other speculative methods,
without quality loss in the tested workloads.

**Verified fact:** the paper's acceptance discussion uses greedy top-1
agreement for reproducibility; that is narrower than the stochastic
rejection-sampling theorem.

**Weak point:** switching precision can change logits, ties, and accepted
prefixes. “No quality compromise” is not a proof of exact target identity.

## Mapping

Quantization experiments should make precision a frozen axis and report target
format, draft format, activation/KV precision, acceptance, exact replay, and
serving time. QSpec is a useful design baseline for shared-weight mixed
precision, not a license to merge approximate and exact results.
