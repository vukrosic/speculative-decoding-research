---
id: PQ-20260821-002-IMPLEMENTATION-GATE-CRITIQUE-20260821
date: 2026-08-21
status: blocked-preflight
verdict: BLOCK
approval: CEO AMENDMENT REQUIRED
---

**2026-08-21 urgent implementation-gate critique — BLOCK.** The executor's
read-only inventory confirms that the pinned v23f/v27 trainer tree contains
only the original position-weighted CE implementation; no code path applies
the approved FP32 cumulative-log prefix objective. An ephemeral wrapper or
trainer edit is **not allowed under the existing CEO approval**: it would be a
new implementation artifact/code mutation whose path, diff, hash, command,
dependency identity, and one-variable invariant were not named in the
approved command boundary (“objective implementation must be the manifest
policy and no other code or flag may change”). It cannot be improvised on the
remote host or left un-hashed. Target/data/checkpoint provenance, objective
math, sealed-heldout/resource boundary, and planned fit/cleanup receipts remain
valid, but no training can start without an implementation identity. **Smallest
new deliverable:** a new additive
`PQ-20260821-002-OBJECTIVE-IMPLEMENTATION-MANIFEST`/card that records the
minimal loss-wrapper source or patch hash, exact working path/command and
dependencies, proves only the objective changes (including FP32 cumulative-log
and finite-gradient gates), and reserves the existing receipts; then obtain a
new critic review and CEO amendment. Until that exists, preserve the approved
scope, do not create an ephemeral wrapper, and leave all run receipts empty.
