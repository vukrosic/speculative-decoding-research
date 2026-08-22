---
date: 2026-08-22
kind: literature/evidence disposition
scope: EXP-20260822-021 Qwen v22 split-flash n=1
---

# Final disposition: 747-contract split-OFF failure

## Verdict

The authoritative reconciliation is the 747-token tracer route (contract
`a69610f96d2786fb4c47bf7e595548e2313cf95c9aa332241a6a9bf7ba77f326`, manifest
`77a9b5703756102bc088891419a6b85f45bd6a26118c4daded334dec91db8514`). Its
same-build Q4 split-OFF control fails exactness on the first row: 31/31
proposals were counted as accepted, yet the emitted output SHA differs from
the target oracle and begins with duplicated `</think>` tokens. This is a
valid exactness/control failure under the 747 contract, not evidence from the
stale 531-token route.

There is **no split-flash-on result**. Because split-OFF does not pass the
exactness gate, the split-flash branch is terminalized for this packet/candidate:
split-ON must not be run, timed, or described as positive or negative evidence.
The failure cannot be attributed to split-flash. The compact receipt does not
localize it to verifier state or rollback; proposal/verification transition,
sampler/EOS handling, and output-format behavior remain live alternatives.

Acceptance (`31/31`) is only a proposal counter and cannot override the
exact-output failure. No acceptance, speed, losslessness, Arm-B, or general
speculative-decoding claim is admissible from EXP021.

## Exact reopen artifact

Reopen only after a source-backed first-divergence/evaluator bundle for the
valid 747 Q4 split-OFF failure, containing:

1. target and Q4 token-ID arrays plus the first divergent index;
2. proposal logits, sampling decision, correction token, accepted/rejected
   boundary, and verifier rollback/commit/cache state;
3. literal tracer argv/environment, parser/evaluator identity, and the
   candidate server BuildID with resolved library hashes; and
4. the bound model, drafter, tokenizer/template, manifest, and contract hashes.

That bundle is the minimum needed to distinguish verifier transition from
sampling/format behavior. A complete PLAN-001 Arm-B deployment/evaluator
bundle is additionally required before making any Arm-B or verifier-general
claim. After repair, obtain a fresh target oracle and require six-of-six
same-contract split-OFF exact rows before permitting a single split-ON n=1
diagnostic. Preserve the stale 531 receipts as a separate invalid evidence
class; never merge them into this branch.

Sources: `experiments/planning/runtime-qwen-exp021-splitoff-mismatch-localization-20260822.md`,
authoritative 747 raw receipts, and source-candidate recheck receipt
`status=terminal_no_new_candidate` / `verdict=NO-CANDIDATE`.
