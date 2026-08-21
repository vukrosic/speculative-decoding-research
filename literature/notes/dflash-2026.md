---
id: paper-dflash-2026
status: reviewed
---

# DFlash: Block Diffusion for Flash Speculative Decoding

**Citation:** Jian Chen, Yesheng Liang, Zhijian Liu, [arXiv:2602.06036](https://arxiv.org/abs/2602.06036); [official code](https://github.com/z-lab/dflash).

## Mechanism

**Verified fact:** DFlash uses a lightweight masked/block diffusion drafter.
An anchor token is known, the remaining block positions are masked, and the
drafter predicts the block in parallel while conditioning on target hidden
states. The target then verifies the proposed block left-to-right.

## Claims and evidence

**Author claim:** the paper reports more than 6x lossless acceleration and up
to 2.5x the EAGLE-3 speedup across its evaluated models/tasks.

**Weak point:** the paper's lossless statement is conditional on its verifier
and target/runtime setup. Block length, mask token, hidden-state layer IDs,
feature projection, and rollback all affect the result.

## Mapping

This is the primary source for the project's DFlash/DFlash2-style work. Keep a
compatibility bridge explicitly labelled as such; do not call it an official
checkpoint. Measure block acceptance, accepted prefix distribution, feature
execution shape, and end-to-end serving separately.
