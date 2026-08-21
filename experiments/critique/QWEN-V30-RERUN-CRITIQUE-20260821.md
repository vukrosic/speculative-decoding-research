---
id: QWEN-V30-RERUN-CRITIQUE-20260821
date: 2026-08-21
status: repair-needed
verdict: BLOCK
---

**2026-08-21 v30 provenance-supplement approval review — BLOCK pending one
repair.** The supplement and updated manifest pass evaluator/runtime
provenance for an approximate rerun (hashed benchmark client/finalizer and
wrappers, pinned llama.cpp commit and binary, Python/dependency identity,
target/v27/candidate hashes, 12-prompt manifest, flags, and a matched
target-only receipt), and the F16/Q4_K_M/Q8_0 export-format change is a single
causal variable using existing artifacts. The exactness boundary is correct:
report acceptance/content/timing as approximate only, preserve strict
identity failure, and make no lossless or general speed claim; held-out,
download/install, and scope-expansion gates remain closed. **One blocker:** no
named v30 rerun receipt provides pre-registered per-arm warmups/repetitions,
output-token accounting, and task-owned terminal cleanup/final GPU state (the
inventory only has indirect historical idle evidence). **Repair:** add one
compact receipt schema/path for EXP-20260821-004 containing those timing,
output-count, process-ownership, cleanup, and final-device fields; then the
CEO may consider the same one-GPU, existing-artifact approximate rerun, with
no quantization or runtime changes.
