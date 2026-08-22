---
id: EXP-20260822-020-qwen-singleton-correction
date: 2026-08-22
status: active-diagnostic
method: current-runtime trace then rejection-only singleton correction
exactness_contract: target-only greedy output hashes first; token IDs required before promotion
heldout_touched: false
tags: [qwen, dflash2, verifier, block-shape, rollback, performance]
---

# Question

Can the current Qwen v21 Q4 DFlash n=1 path retain its observed cache-off
throughput advantage while eliminating the one deterministic target-output
divergence by confirming only rejected speculative boundaries in a singleton
target schedule?

## Authorization and scope

- Authorized action: the user's 2026-08-22 instruction to solve the current
  blocker and continue the Qwen GPU optimization objective.
- Explicit exclusions: no downloads, installs, training, sealed held-out data,
  publishing, additional GPU rental, baseline overwrite, or Mac GPU execution.
- Stop conditions: identity mismatch; competing GPU process; trace cannot bind
  positions/draft/accept/rollback; target/Q4 output accounting changes; nonzero
  error; task-owned storage crosses its reserve; or the proposed confirmation
  path cannot be isolated to rejected boundaries.
- Artifact/storage budget: compact source patches, logs, and JSON/Markdown
  receipts only; no model or checkpoint copies into this repository.

## Frozen controls

- Target checkpoint SHA-256:
  `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`.
- Drafter: v21 Q4_K_M DFlash2,
  SHA-256 `18a380efc9b7ed8d88677fc895f5c11ae170653434ee378f7348f715c14d0594`.
- Runtime: llama.cpp commit
  `5ecbe1ac17ec0484c5b44af0bd580cdc9c428ed4`, frozen server SHA-256
  `78ccd846f70b6d632eb290c33be0b02f818c91b21fb0c126926c901cca5eb0d6`.
- Current runtime source: `common/speculative.cpp` SHA-256
  `e59a1058229ba65dcdc0d6cc056c915f1c071a921d18a9d731a142c4ff841f40`;
  `tools/server/server-context.cpp` SHA-256
  `5a17b34cc365f0921c5a8b440c0760be299edfe1e34c2ca8a15cc0b8aa4b797d`.
- Public v20 prompt source SHA-256:
  `77a9b5703756102bc088891419a6b85f45bd6a26118c4daded334dec91db8514`.
- Registered repeated-prefix workload SHA-256:
  `f911c7d3...` (full hash must be rebound at preflight).
- Seed/settings: greedy, temperature 0, top-k 1, parallel 1, context 4096,
  prompt cache disabled for the speculative-speed comparison.
- Hardware: assigned NVIDIA RTX 3060 12 GiB; one task-owned GPU process.

## Intended change

Phase 0 changes only log verbosity on the unchanged binary and is diagnostic;
its timings are not promotion evidence. A later candidate may change exactly
one verifier behavior: after a speculative rejection, obtain the correction
token from a singleton target decode instead of the numerically shape-dependent
block row. No other proposal, model, sampler, prompt, or cache rule may change.

## Baseline

Authoritative source: `receipts/PQ-20260821-019-cache-on-n1-20260822/`.

- Target-only, cache off: `16.0895399687` output tok/s mean, SD
  `0.0105072995`, 454 completion tokens per repetition.
- Q4 DFlash n=1, cache off: `18.1638816661` output tok/s mean, SD
  `0.0169409963`, 454 completion tokens, `208/236 = 0.8813559322`
  accepted/proposed.
- Narrow observed speed difference: `+12.892486%` on this exact workload.
- Output-hash agreement: 5/6 unique prompts (10/12 duplicated rows). The sole
  deterministic mismatch is `code_python_debug`; both arms produce 64 tokens
  but different assistant/content hashes in all three repetitions.

The correctness oracle is the matched target-only arm. The current speculative
incumbent is v21 Q4 n=1 cache-off. The target-only arm remains the behavior
oracle; the Q4 arm is the narrow raw-speed frontier, not yet promotable.

## Profile basis and ceiling

Observed whole-request counters show target decode calls falling from 478 to
272 per repetition while Q4 accepts 208 of 236 proposals. The remaining issue
is one deterministic output divergence plus the cost of 28 rejected proposals.
If singleton confirmation is required only at rejected boundaries, its upper
work share is approximately 28/236 verification boundaries before measuring
actual decode cost. This is a hypothesis, not a measured Amdahl share.

## Preflight gates

- [ ] exact target/drafter/runtime/client/workload hashes
- [ ] live GPU/process/storage ownership
- [ ] unchanged-binary trace exposes draft IDs, target batch positions,
      sequence IDs, accepted count, rollback extent, and correction token
- [ ] target-only and speculative `code_python_debug` outputs reproduce
- [ ] task-owned source diff and static tests (only if instrumentation needed)
- [ ] trace-mode output accounting is complete; trace timing is diagnostic only
- [ ] no held-out access

## Promotion gate

Promotion requires all of the following on a fresh matched cache-off screen:

1. complete token IDs equal the target-only greedy oracle for every evaluated
   output;
2. repeated Q4 candidate end-to-end output tok/s remains above target-only by
   more than observed A/A noise;
3. completion-token counts, prompt order, runtime dispatch, acceptance, peak
   VRAM, and cleanup are complete;
4. the only runtime change is the rejected-boundary singleton confirmation.

## Cheap kill criterion

Stop the correction candidate if the unchanged trace shows the divergence does
not occur at a rejected boundary, if a singleton correction cannot be isolated
without replaying accepted work, or if a one-prompt smoke loses target output
identity. Preserve the diagnostic and move to a different state-fidelity
mechanism.

## Results

### Observed — trace localization

The preserved target-only and instrumented Q4 traces share an exact 42-token
prefix. The first divergence is output token 43 (zero-based index 42): target
token `90563` versus Q4 token `471`. Q4 accepted token `471` as the draft in
cycle 25 (sampled predecessor `460` at position 174; accepted draft at 175;
correction token `16`; no rollback). Seven one-token rejection/rollback cycles
precede this accepted-draft divergence. The target token `90563` is neither
the sampled predecessor, accepted draft, nor correction token. This localizes
the mismatch to an accepted-draft decision after the shared prefix, while
remaining a state-path hypothesis rather than proof of a single cause.

Receipts: `receipts/EXP-20260822-020-qwen-singleton-correction/
token-divergence-analysis.{json,md}`. Parser SHA-256 is
`a7e53cf4c2e63dc9359f12db9ea0682d66ee8398a84d3ed406e5f96a46c7e5ff` and
analysis JSON SHA-256 is
`a6df8676dea3875a130110b0363f8d9130fbef732911fbdedf738a77e531559d`.

### Observed — bounded `n_rs` causal axis

The one-prompt two-arm diagnostic then forced target-only `n_rs_seq=1` and Q4
n=1 `n_rs_seq=0`, retaining the frozen artifacts and full-checkpoint Q4 path.
Target-only still produced the target hash
`0f76b6ae57040714633aa638719e0c2a9b3c594cc2ff0ce4bafc75cabee56a6c` at
`18.7416124147` diagnostic tok/s. Q4 still produced divergent hash
`1d5020bfedee4bbc2c878d7d3805bf76ccd2e85dfc90817c4b3422af75122646` at
`16.3178374758` diagnostic tok/s. Both emitted 64 tokens. Therefore changing
the recurrent snapshot count/layout alone, or merely matching the target-only
layout while retaining speculative verification, is falsified as the sole
cause. These timings are diagnostic, not promotion evidence.

Receipt: `receipts/EXP-20260822-020-qwen-singleton-correction/n-rs-axis-r1/`.

### Interpretation / hypotheses

The first mismatch is now localized to an accepted draft after seven prior
rejection cycles. The `n_rs` axis rejects snapshot count/layout as a sufficient
single-variable fix; the remaining candidate mechanisms include rollback
checkpoint contents, target block-vs-singleton numerical state, or another
verifier state transition. No correction runtime has been promoted.

## Artifacts and receipts

- Candidate receipts: `receipts/EXP-20260822-020-qwen-singleton-correction/`
- Paper-material log:
  `paper-material/experiments/2026-08-22-qwen-singleton-correction.md`
- Frozen PQ-019 inputs:
  `receipts/PQ-20260821-019-cache-on-n1-20260822/raw-remote/`

## Failures and amendments

Historical PLAN-001 remains terminally blocked and is not being reconstructed
as if its missing bytes existed. This card defines a new source-backed current-
runtime experiment with a new identity.
