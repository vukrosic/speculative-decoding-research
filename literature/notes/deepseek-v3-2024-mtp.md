---
id: paper-deepseek-v3-2024-mtp
status: reviewed
---

# DeepSeek-V3 MTP modules

**Citation:** DeepSeek-AI et al., [DeepSeek-V3 Technical Report](https://arxiv.org/abs/2412.19437).

## Mechanism

**Verified fact:** DeepSeek-V3 adds sequential MTP modules that predict
additional future tokens through a causal chain. The released model repository
documents separate MTP-module weights in addition to the main model weights.

## Claims and evidence

**Author claim:** the MTP objective densifies training signals and can improve
data efficiency and future-token planning. The report also describes the MTP
design as an inference aid.

**Weak point:** this is architecture-specific. “NEXTN” or “MTP” runtime support
must match module ordering, cache positions, masks, and target checkpoint
version.

## Mapping

Treat native MTP as a draft interface. Verify it against the exact target
checkpoint and record whether the runtime is using one-step or multi-step MTP,
how many heads/modules are active, and whether output equality is checked.
