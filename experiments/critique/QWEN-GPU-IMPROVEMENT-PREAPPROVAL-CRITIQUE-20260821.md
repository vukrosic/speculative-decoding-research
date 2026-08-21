---
id: QWEN-GPU-IMPROVEMENT-PREAPPROVAL-CRITIQUE-20260821
date: 2026-08-21
status: blocked-preapproval
verdict: BLOCK
scope: best existing Qwen improvement candidate under explicit GPU request
authorization: documentation-only; no approval, build, or GPU action
---

# Qwen GPU-improvement pre-approval critique — 2026-08-21

## Candidate choice

The best existing *improvement* candidate is **PQ-20260821-002**, the
acceptance-calibrated FP32 cumulative-log prefix objective. It is the only
remaining proposal that directly changes training behavior toward contiguous
accepted prefixes while preserving the target/drafter architecture. The v30
Q4_K_M export is already terminal: it is a bounded approximate form-selection
baseline, not an end-to-end improvement (11.5745 tok/s versus 17.3758
target-only; 7/12 target-content; exactness diagnostic/failed). Repeating v30
cannot satisfy the user's improvement goal.

## Verdict

**No bounded GPU run is currently safe.** The new explicit GPU request removes
the legacy user-approval wording as a decision blocker, but it does not close
the objective implementation/provenance gate or authorize an unpinned code
change. The current CEO packet remains suspended before fitting.

## Single exact blocker

**Missing immutable implementation identity for the approved PQ-002 objective.**
The read-only inventory (`objective-implementation-inventory-20260821.json`,
SHA-256 `c063fd2dd2738647748de1c74dd0c2c42773812e99ee0e39a23ea0cbeb715a38`)
found no preserved file implementing the full tuple: FP32 `log_softmax`,
`log_epsilon=log(1e-8)` true-label clamp, cumulative FP32 prefix sums,
`L_prefix`, `lambda=1`, mask/EOS rules, FP32 reductions, and finite/nonzero
gradient gates. The pinned v23f/v27 trainer has only the prior CE path; generic
KD, perplexity, imatrix, or sampler helpers are not substitutes. Consequently
there is no approved wrapper/module path, complete source/file-set SHA-256,
loss-only diff, exact command/dependency identity, or synthetic correctness
receipt to audit.

## Gate status

- **Policy/causal scope:** defined as objective-only in the manifest.
- **Lineage/data intent:** materially pinned (target, v23b/v23f manifests,
  v23f→v27 parent, optimizer/seed); this does not make the loss executable.
- **Implementation/correctness:** **BLOCK** — no artifact or synthetic
  finite-gradient evidence.
- **Evaluator/baseline:** **BLOCK until amended preflight** — exact runtime,
  evaluator, command, output-token accounting, and target-only comparison must
  be captured for the new training artifact; approximate v30 metrics cannot
  substitute for this contract.
- **Resource/safety/receipts:** policy is bounded (one remote RTX 3060,
  one process, four hours, held-out sealed), but no run may start while the
  implementation gate is open and the reserved receipt directory must remain
  free of fit/validation receipts.

## Smallest repair

Supply the existing additive implementation manifest with one named,
objective-only wrapper/module and complete immutable identity: absolute path,
source/file-set SHA-256, base trainer hashes, interpreter/dependencies, exact
argv/cwd/environment/device capture, and a machine-readable source diff proving
no architecture/data/label/optimizer/runtime/evaluator/selection change. Add a
deterministic synthetic receipt proving FP32 log-space clamp/cumulative sums,
mask/EOS behavior, finite nonzero gradients, and no probability product. Then
obtain fresh critic review and a CEO amendment before any build or fit. Do not
use an ephemeral wrapper or generic helper under the existing approval.
