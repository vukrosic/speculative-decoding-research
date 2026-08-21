---
id: PQ-20260821-002-OBJECTIVE-IMPLEMENTATION-INVENTORY-CRITIQUE-20260821
date: 2026-08-21
status: review-complete-blocked
scope: read-only objective-implementation inventory review
receipt: receipts/PQ-20260821-002-prefix-objective-20260821/objective-implementation-inventory-20260821.json
receipt_sha256: c063fd2dd2738647748de1c74dd0c2c42773812e99ee0e39a23ea0cbeb715a38
authorization: documentation-only; no build, patch, fit, evaluation, or GPU action
---

# PQ-002 implementation-inventory critique

## Verdict

**BLOCK. None of the seven listed files implements the complete approved
PQ-002 objective tuple.** The inventory is a valid terminal negative result:
the v31 scripts are hard-CE/KD or label-smoothing variants, the llama.cpp
perplexity/imatrix files are inference statistics helpers, and the sampler is
runtime probability code. Their `log_softmax` occurrences do not establish a
training loss implementation. No candidate may be promoted by renaming,
wrapping, or combining it; that would create a new executable artifact and
scope boundary.

## Tuple audit

The frozen tuple requires FP32 `log_softmax`; true-label clamp at
`log_epsilon=log(1e-8)`; cumulative FP32 prefix sums; `L_prefix`; `lambda=1`;
mask/EOS behavior; FP32 reductions and finite gates. The receipt's absence
search reports zero matches for `log_epsilon`, `L_prefix`, `prefix_loss`,
`cumulative-log`, and `prefix-survival` in the inspected scope.

- `train_kd_gamma8_ls002.py` and `_alpha005.py` have generic `torch.log_softmax`
  but implement hard CE plus target-logit KD; no clamp, prefix sum, or
  `L_ce + L_prefix` policy.
- `train_mixedls_early4_gamma8.py` has generic `F.log_softmax` and an early-
  position CE mask; it is the v29-style objective, not cumulative prefix
  survival.
- `perplexity.cpp` (both preserved copies) and `imatrix.cpp` aggregate generic
  inference NLL/statistics; they are not a differentiable trainer loss and do
  not define masks/EOS or prefix gradients.
- `llama-sampler.cpp` contains runtime sampling helpers only; it cannot satisfy
  the training-objective or finite-gradient gates.

The preserved v31 tree has no source commit (`NO_GIT`), and the inventory does
not provide an approved wrapper/module path, exact training command, complete
file-set hash, or source-diff proof. Those remain unknown rather than inferred.

## Smallest safe next action

Keep fitting and the reserved PQ-002 receipt directory stopped. Produce the
already-required additive implementation manifest/card naming one objective-
only wrapper/module (absolute path, complete source/file-set SHA-256, base
trainer hashes, interpreter/dependencies, exact command, and machine-readable
loss-only diff), plus a deterministic synthetic FP32/mask/EOS/finite-gradient
smoke receipt. Obtain fresh critic review and a CEO amendment authorizing that
artifact before any build or fit. Do not use an ephemeral wrapper or any listed
candidate under the current approval.

