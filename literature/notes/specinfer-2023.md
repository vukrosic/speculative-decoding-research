---
id: paper-specinfer-2023
status: reviewed
---

# SpecInfer: tree-based speculative inference and verification

**Citation:** [arXiv:2305.09781](https://arxiv.org/abs/2305.09781).

## Mechanism

**Verified fact:** SpecInfer organizes candidates from one or more small models
as a token tree and uses tree attention to verify the candidates in parallel.
The system contribution includes memory management and GPU kernels for serving,
not just the sampling rule.

## Claims and evidence

**Author claim:** the paper reports serving speedups over autoregressive and
prior speculative baselines in its tested workloads.

**Weak point:** tree breadth/depth, padding, and KV-cache layout are runtime
variables. A tree with more candidates does not imply a larger accepted prefix.

## Mapping

Use SpecInfer to motivate a separate tree-shape/verification benchmark. Record
candidate count, accepted-prefix length, target forward time, cache copies, and
scheduler overhead.
