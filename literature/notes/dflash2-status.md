---
id: implementation-dflash2-status
status: reviewed
---

# DFlash2 status: implementation lineage, not a separate paper

## Verified source status

The reviewed primary literature contains the DFlash paper, not a distinct
paper titled “DFlash2.” The name currently appears in this repository and in
runtime/checkpoint lineages as a DFlash-style implementation or model-release
label. The [official DFlash repository](https://github.com/z-lab/dflash) is the
authoritative code entry point found in the source review.

## Interpretation

**Verified fact:** a “DFlash2” checkpoint can change draft depth, block size,
selector, target-layer interface, quantization, or runtime integration without
being a new algorithmic paper.

**Hypothesis:** observed DFlash2 differences may be explained by checkpoint
training and runtime fidelity rather than a new theoretical correctness rule.

## Mapping

For every DFlash2 result, record the checkpoint/revision, architecture config,
block size, target layer IDs, mask/anchor semantics, quantization, runtime
revision, and exactness receipt. Cite the DFlash paper for the mechanism and
the implementation source for the concrete path.
