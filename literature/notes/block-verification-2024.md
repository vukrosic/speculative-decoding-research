---
id: paper-block-verification-2024
status: reviewed
---

# Block Verification Accelerates Speculative Decoding

**Citation:** Ziteng Sun et al., [arXiv:2403.10444](https://arxiv.org/abs/2403.10444).

## Mechanism

**Verified fact:** the paper replaces independent token-by-token verification
with a block-level coupling. It formulates verification as an optimal
transport problem over the drafted block and gives an efficient verifier that
does not require additional draft or target calls.

## Claims and evidence

**Author claim:** BlockVerify is optimal in expected tokens produced per
iteration under the paper's formulation, preserves the target distribution,
and gives 5–8% wall-clock improvement over token-level verification in the
reported tasks.

**Weak point:** the optimality statement concerns expected accepted length, not
all runtime costs. The implementation still depends on target logits, sampler,
block shape, and numerical behavior.

## Mapping

This is a verifier-axis baseline orthogonal to drafter architecture. A future
comparison should hold the drafter fixed and swap TokenVerify versus BlockVerify
before changing model capacity or training objectives.
