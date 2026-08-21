---
id: QWEN-V30-RERUN-VERDICT-20260821
date: 2026-08-21
status: ready-needs-approval
verdict: READY-NEEDS-APPROVAL
approval: NEEDS CEO APPROVAL
---

**2026-08-21 final v30 pre-run verdict — READY-NEEDS-APPROVAL.** The named
receipt schema repairs the prior blocker: it pre-registers one warmup and
three timed repetitions per F16/Q4_K_M/Q8_0 arm plus a matched target-only
baseline, output-token accounting, per-arm metrics, process ownership,
task-owned cleanup, final GPU state, hashes, commands, and terminal
disposition. The provenance supplement and manifest pin the target and v27
parent/candidate hashes, llama.cpp source/binary/compiler/CUDA/driver/backend/
threads/device settings, evaluator wrappers/finalizer and dependency identity,
12-prompt manifest, contract/flags/seed/context, and existing target-only
baseline. The only causal change is drafter export format; no quantization or
artifact mutation may occur. Exactness is explicitly diagnostic/failed from
historical evidence: report acceptance, target-content, timing, and VRAM as
separate approximate rows and make no lossless, general exactness, or general
speed claim. Held-out data, downloads, installs, training, patches, publishing,
and scope expansion remain excluded. CEO approval is still required for exactly
one RTX 3060 slot, one process, one-hour maximum, existing artifacts only; any
identity mismatch, target-only baseline mismatch, missing output accounting,
resource contention, held-out access, or cleanup failure is a hard stop. No
rerun has started.
