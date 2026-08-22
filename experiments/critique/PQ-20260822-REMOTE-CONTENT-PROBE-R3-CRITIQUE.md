# Remote content probe r3 adversarial critique (2026-08-22)

## Verdict

**PASS as a scope-bounded negative recovery result; BLOCK for any claim that
the missing PLAN-001 artifact does not exist outside the searched checkout.**
The probe searched 21,493 text files under the declared remote experiment,
script, config, runtime, and tools roots, then performed a narrowed source/
config/planning search excluding logs, build trees, and receipt archives. It
found no new file that binds the exact Arm-B verifier/evaluator/state contract.
The RTX 3060 was idle and no mutation/model/inference/training/held-out action
occurred.

## What the result establishes

- Within the stated roots and file classes, no matching PLAN-001/Arm-B/replay/
  logger/evaluator/state artifact was found by content.
- Matches from the broad pass were historical validation logs, build dependency
  files, and existing runtime `speculative.cpp` sources; these do not bind the
  missing deployment-shaped mask/positions/cache/evaluator tuple.
- The narrowed pass returned zero source/config/planning matches for the named
  patterns. This strengthens the prior filename/depth probe and supports the
  planner's `TERMINAL-NO-NEW-GPU-CANDIDATE` disposition for the scoped checkout.

## Adversarial limitations

1. The broad pass limited text files to `<2 MiB`; larger text, binary, generated,
   compressed, or symlink-target artifacts may be outside the search. The
   narrowed pass explicitly excluded logs, build, and receipts, so it cannot
   disprove a usable artifact in those locations.
2. Pattern matching is lexical. A contract encoded under different field names,
   JSON keys, binary serialization, or an unanticipated path would evade the
   search. Existing `speculative.cpp` source can document generic runtime
   behavior but cannot be promoted to the exact historical Arm-B layout without
   source/config/receipt tie evidence.
3. The search covers the specified remote checkout only. It says nothing about
   external artifact stores, other host paths, deleted files, or a separately
   authorized regeneration. Do not convert “zero matches” into “artifact never
   existed.”
4. GPU temperature (56 C) and 1 MiB/0% utilization show observed idle state at
   probe time, not a durable availability guarantee for a later run.

## Source-backed GPU path assessment

No source-backed GPU path remains in the searched checkout for the unresolved
PLAN-001 verifier/state diagnostic. The existing runtime source and historical
logs do not supply the complete Arm-B block width/positions/sequence IDs/mask,
cache schema/extents, anchor/`n_extract`, evaluator/logger/dependency tuple, or
the `[171,171]` versus `[170,170]` memory-after resolution. Guessing these from
generic `speculative.cpp` behavior would violate causal isolation and provenance
rules. PQ-019's completed cache-cost result does not repair this gap.

## Smallest recovery action

Stop further broad searching in this checkout. Reopen only when one exact,
source-backed recovery bundle arrives: (a) the PLAN-001 deployment/evaluator
bundle, (b) a separately authorized regeneration that records all source/build/
state fields, or (c) another pinned runtime artifact with a complete one-axis
packet. The recovery receipt must include path, bytes, SHA-256, producer,
source/config line evidence, and access notes. Until then, perform only
documentation/literature/critic work; do not launch a GPU run, patch the
runtime, use held-out data, or infer Arm-B from historical files.

