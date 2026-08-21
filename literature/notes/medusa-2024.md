---
id: paper-medusa-2024
status: reviewed
---

# Medusa: Simple LLM Inference Acceleration Framework with Multiple Decoding Heads

**Citation:** Tianle Cai et al., ICML 2024, [arXiv:2401.10774](https://arxiv.org/abs/2401.10774).

## Mechanism

**Verified fact:** Medusa adds multiple heads on top of a backbone to predict
future tokens and verifies a candidate tree with a single target pass.
Medusa-1 freezes the backbone while Medusa-2 jointly fine-tunes it; the paper
also describes self-distillation and a typical-acceptance variant.

## Claims and evidence

**Author claim:** Medusa-1 reports over 2.2x speedup and Medusa-2 reports
2.3–3.6x in the paper's setups, with no quality compromise for Medusa-1.

**Weak point:** “lossless” refers to the declared verifier/quality contract;
extra heads can be poorly calibrated on new models, prompts, or quantized
backends. The backbone/head training recipe is part of the method.

## Mapping

Compare Medusa against native MTP as head-based proposals, not against a
separate-model drafter on only draft-token accuracy. Keep tree construction and
target verification costs in the serving receipt.
