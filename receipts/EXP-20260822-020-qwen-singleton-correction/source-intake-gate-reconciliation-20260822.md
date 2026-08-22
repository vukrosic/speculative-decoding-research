---
experiment: EXP-20260822-020-qwen-singleton-correction
date: 2026-08-22
kind: source-intake gate reconciliation
status: CONDITIONAL PASS; NOT EXECUTED
---

# EXP020 source-intake gate reconciliation

## Packet and reviews

The hardened read-only packet is
`experiments/planning/runtime-qwen-exp020-source-intake-20260822.md`,
SHA-256
`74b0244707b2bb093f93d3da36485672e9f795fdb3a6d2454ffd50101319c909`.
The critic gate is
`experiments/critique/QWEN-EXP020-SOURCE-INTAKE-GATE-20260822.md`,
SHA-256
`c305b76415fa3dff9a921a76aa604bd798e0b98b78b379902b3923cc9590c22d`;
the literature gate is
`literature/VERDICT-20260822-EXP020-SOURCE-INTAKE-GATE.md`, SHA-256
`426c0330c2e6929f47e6202eb5445455aff1247f05a615ca8dd500586b6909d4`.
Both reviews are **conditional PASS on paper**, not execution authorization.

## Conditional gates

1. **Frozen transport and mutation gate.** Any future executor may use only
   `root@125.240.239.50:35738` and the frozen project/task/source roots, with
   `BatchMode=yes`, strict host-key checking, bounded connect/liveness
   settings, one metadata preflight, and one post-transfer no-mutation check.
   No fallback host, tunnel, kill, checkout/write, cleanup, or second path is
   allowed. Drift, unexpected process/GPU/resource state, or pre/post hash
   change is a fail-closed `NO_CANDIDATE_SOURCE_GAP`.

2. **Exact source-only byte gate.** Only these two files may cross the
   boundary: `common/speculative.cpp` (112,689 bytes,
   `6a24e473529b70367598f6718f33ecc6ab9a14701469469415afef90ed7869e0`) and
   `tools/server/server-context.cpp` (223,748 bytes,
   `c060c9f5b5c9aa41cbb04204973c07c7ba6ba5fb518fc4ee38d62367ea0fb6a2`).
   The hard combined cap is exactly `336437` bytes. Per-file size/hash checks,
   immutable `.part` failure handling, and a CPU-only marker index are
   required; model/data/checkpoint/binary/library/build/log/patch/unrelated
   artifacts are prohibited.

## Standing no-download and no-execution decision

The packet is a narrowly bounded **source-only transfer design**, not a
generic download. Under the standing no-download policy, it remains blocked
unless the CEO/executor separately admits this exact two-file read-only
intake. No SSH connection, source transfer, remote observation, build, model
load, server/benchmark launch, timing, generation, GPU use, holdout access,
install, or remote mutation has occurred in this lane. The current state
remains `NO_CANDIDATE / SOURCE GAP`.

Even if both files later pass the gates, the result would close only marker
provenance. It would not authorize a source patch, runtime candidate, build,
inference, rerun, speed/exactness/acceptance claim, or promotion. A future
source map and any intervention require their own planner/critic/literature
review and CEO decision.
