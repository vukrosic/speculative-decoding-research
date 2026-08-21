# Literature gate — PQ-002 ephemeral objective wrapper

Date: 2026-08-21  
Verdict: **PASS conditionally as an implementation detail; BLOCK execution until
provenance and approval gates are closed**

## Recommendation

An ephemeral wrapper is source-consistent and remains one causal change **only
if** it implements the already-frozen manifest objective and changes no model,
feature/label, data split, optimizer, precision policy, runtime, evaluator, or
selection behavior. It is not a new literature method: the cumulative-log
prefix term is this project's hypothesis, while Chen/Yin support measuring
autoregressive acceptance separately from fit loss ([2302.01318](https://arxiv.org/abs/2302.01318),
[2411.00841](https://arxiv.org/abs/2411.00841)).

If the wrapper adds a new confidence rule, sampling path, feature transform,
optimizer behavior, data handling, or runtime patch, it becomes a new
training/runtime implementation proposal and requires a new card and review.

## Required provenance before any run

- Preserve the exact wrapper bytes or immutable path and SHA-256; “ephemeral”
  must not mean unrecoverable after execution.
- Record base trainer path/hash, exact command/config, Python/interpreter,
  framework/compiler/dependency versions, and working directory.
- Bind parent checkpoint, target hash/layer, feature/label identity bundle,
  train/validation split hashes, seed, optimizer flags, BF16/FP32 policy, and
  manifest version to the wrapper receipt.
- Add a construction/unit gate with synthetic logits that checks FP32
  `log_softmax`, `log_epsilon` clipping, EOS masks, cumulative prefix sums,
  finite loss/gradients, and the `λ=0` CE-only reduction against the baseline
  implementation. This is a correctness gate, not a result.
- Receipt the wrapper hash, unit-gate output, fit/validation metrics, held-out
  sealing, cleanup, and terminal state. Do not run a serving screen unless
  the fit/validation gate and separate acceptance gate pass.

No wrapper execution, training, exactness, quality, or speed claim is
authorized by this verdict. The wrapper must remain subordinate to the CEO
decision and the existing PLAN-001 verifier/state priority.
