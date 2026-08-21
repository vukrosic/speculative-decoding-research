---
id: PQ-20260821-002-OBJECTIVE-MANIFEST-CRITIQUE-20260821
date: 2026-08-21
status: repair-needed
verdict: BLOCK
approval: NEEDS CEO APPROVAL
---

**2026-08-21 objective-manifest critique — BLOCK pending one mathematical
repair.** Lineage is now coherent on v27 step-4000 (`d3caaa63…`), v23b/v23f
manifests and trainer/config hashes are pinned, the objective scope is one
training-objective change, EOS/masks, BF16/FP32 precision, gradients, one-look
checkpoint/tie/multiplicity rule, current v30 baseline hashes, separate
approximate exactness/speed rows, sealed-heldout boundary, and reserved fit/
validation/cleanup/terminal receipts are all specified. The remaining gate is
numerical executability: the manifest defines `S_{i,k}=exp(Σ log p)` and then
`-log S_{i,k}`; with 16 positions and `ε=1e-8`, the exponent can underflow in
FP32, making a finite-fit gate fail or silently change gradients. **Concrete
repair:** define and implement `L_prefix` directly from the FP32 cumulative
log-probability sums (`-Σ_k m_k Σ_{t≤k} m_t r_t / K_i`), without exponentiating,
and require the receipt to log those cumulative sums plus finite-value checks.
Until this stable equivalent is frozen, no training or validation run is
approved; after the repair the remaining provenance/selection/cleanup design
gates are ready for renewed CEO review.
