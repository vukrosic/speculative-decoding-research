---
id: PQ-20260821-004-ADAPTIVE-INVENTORY-VERDICT-20260821
date: 2026-08-21
status: blocked-existing-selector-absent
verdict: BLOCK
receipt: ../../receipts/PLAN-20260821-001/runtime-confidence-adaptive-length-inventory-20260821.json
receipt_sha256: 6ae1c6f74d0bc270f4f741dabea7c6adb8baad208fa0a9f31f9a19d5a1655726
---

# Planner verdict — existing adaptive-length selector inventory

This is a read-only source inventory for PQ-004. No build, binary invocation,
model load, inference, evaluation, patch, download, install, GPU action, or
held-out access occurred.

## Decision

**BLOCK — no existing DFlash2 adaptive selector closes PQ-004.** The pinned
DFlash2 branch uses configured `params.n_max` and loops the fixed block. It
does not consume a confidence/statistic signal to choose `n`. The inventory
found two related mechanisms, neither applicable to this DFlash2 experiment:

- `p_min` probability early-stop exists in standard/Eagle-style and non-DSpark
  paths, but the DFlash2 branch does not apply it.
- DSpark has a sigmoid confidence head and `p_min` truncation, but it is a
  different `draft-dspark` implementation, not the pinned `draft-dflash`
  runtime or Q8_0 v30 drafter.

Acceptance/NG-ram statistics and adaptive-p sampling likewise do not alter
DFlash2 `n_max` or schedule. The working tree also contains unrelated source
modifications, so its file hashes cannot be adopted as a pinned implementation
identity.

## Evidence and unknowns

| Requirement | Inventory finding | Status |
|---|---|---|
| DFlash2 selector source | `common/speculative.cpp` lines 1195, 1231–1304: fixed `n_block_tokens=n_draft+1`, configured `n_max` | PASS: fixed behavior |
| Confidence/entropy score for DFlash2 | None found | UNKNOWN / absent |
| Threshold/calibration policy | None found | UNKNOWN / absent |
| Deterministic mapping to `n∈{1,2,3,4}` | None found | UNKNOWN / absent |
| Existing DFlash2 implementation hash | Pinned commit exists, but no adaptive implementation; working tree modified | BLOCKED |
| Standard `p_min` early-stop | Present outside DFlash2 branch | NOT APPLICABLE |
| DSpark confidence head | Present for `draft-dspark` only | NOT APPLICABLE |
| Acceptance/statistics feedback | Records/reset behavior only; no DFlash2 scheduling | NOT APPLICABLE |

## Exact next card / blocker

The blocker is **absence of an existing DFlash2 adaptive policy**. PQ-004 cannot
be approved or implemented by reusing `p_min`, DSpark, adaptive-p, or n-gram
statistics. If adaptive scheduling remains valuable, the next artifact must be
a separate **DFlash2 adaptive-scheduler runtime-change card** that freezes one
new policy, source/config hash, score/threshold, n-selection and EOS/tie rules,
overhead accounting, and cache/mask/position/correction invariants. That card
requires its own critic review and CEO decision; it must not be silently added
to PQ-004. Otherwise keep PQ-004 blocked/retire it as unexecutable under the
current runtime. No reserved PQ-004 receipts were created.
