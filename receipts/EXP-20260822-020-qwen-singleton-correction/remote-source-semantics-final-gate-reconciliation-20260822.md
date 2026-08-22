---
experiment: EXP-20260822-020-qwen-singleton-correction
date: 2026-08-22
kind: final remote-only source-semantics gate reconciliation
status: CONDITIONAL PASS DESIGN; NOT EXECUTED
---

# EXP020 final remote-only gate

## Evidence identities

- Final planner packet SHA-256:
  `a3c936ebb8af2875a27624b2b97845a5bad60d89136eef48db7f7fbdc227dd16`
- Packet hash reviewed by the final recheck:
  `d79b9ca9ae2ec00f69c58d7d44a65260a46675fa1810b494b79e7d6dc7301e1f`
- Critic final recheck SHA-256:
  `42427490ab4b8e430cd3d6e52c60052ab67f63ee072c765f9b3d1559c3da8f7f`
- Literature final gate SHA-256:
  `2f8df83f158e8b9933020cf3a7b0491bdf8a01f207c3273d90b426e74ac03f8d`

The current `a3c936...` packet incorporates the final recheck repairs relative
to the reviewed `d79b9...` packet: self-safe process matching with preserved
snapshots, pre/post GPU identity and row-count checks, and a machine-failing
aggregate marker-hit assertion, plus the final `gate_refs` update. These are
design controls only; they do not represent remote execution. The local shell
syntax check passed; this is not remote execution evidence.

## Scope and result

The packet is conditionally admissible only as one bounded, read-only SSH
observation that returns metadata and capped marker-context text. It transfers
no source file, model, data, binary, log, or build artifact; it performs no
remote write, install, build, server/model launch, timing, generation, GPU
action, holdout access, fallback, or process kill. The output is capped at
65,536 bytes on both channels, uses `.part` promotion and non-overwriting
partial receipts, and records explicit per-marker presence/count/context
fields.

**Not executed.** No SSH connection, source-derived text observation, source
transfer, remote mutation, build, model/server action, GPU action, or rerun
occurred. The last verified remote state remains the prior idle receipt.

## Claim boundary

A future `PASS_SNIPPET_ONLY` can localize only the returned marker lines and
nearby context. It cannot close full-source provenance, prove complete source
semantics, explain causal cost, or establish speed, tok/s, acceptance,
exactness, losslessness, verifier correctness, or a Qwen improvement. Any
missing/ambiguous marker index is `NO_CANDIDATE_SOURCE_GAP`; no patch, build, or
GPU experiment is authorized by this packet.

The standing no-download rule still controls execution: if any
source-derived remote text egress is forbidden, keep this packet paused and
request separate user authorization. Otherwise, the next action remains the
single bounded probe followed by CPU-only receipt parsing and a fresh gate.
