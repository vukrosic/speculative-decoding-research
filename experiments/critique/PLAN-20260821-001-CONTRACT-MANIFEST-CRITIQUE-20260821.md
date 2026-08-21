---
id: PLAN-20260821-001-CONTRACT-MANIFEST-CRITIQUE-20260821
date: 2026-08-21
status: blocked-preflight
verdict: BLOCK
---

**2026-08-21 contract-manifest adversarial review — BLOCK.** The manifest
correctly closes target/tokenizer/runtime/prompt provenance and keeps
historical components from being promoted, but its required evaluator tuple is
still incomplete for the card's state contract: it omits cycle/position,
target top-1/logit summary, state shape/dtype, and the per-record mask/position
IDs, and it does not identify the evaluator's exact working path/command and
dependency/runtime version. Its Arm-B section correctly leaves the exact
source/config hash and full serialized mask/cache state unknown. The
exactness boundary is also only implicit; the manifest must explicitly state
that the only admissible contract is six-prompt strict-greedy token-ID
identity against the target-only oracle, with state hashes diagnostic and no
general `exact`/`lossless`/quality/speed claim. **Concrete repair:** add one
`evaluator_contract` block containing those omitted fields plus evaluator path,
command, dependency/runtime identity, and the explicit diagnostic-only
exactness statement; leave unresolved Arm-B source/config identity as
`unknown` and keep the run blocked until it is source-backed.
