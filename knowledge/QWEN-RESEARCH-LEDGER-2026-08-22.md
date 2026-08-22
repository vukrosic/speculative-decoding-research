# Qwen research ledger — 2026-08-22

This dated ledger continues the repository's append-only lab notebook. It
records the cache-on recovery decision and preserves the no-run boundary after
the previous Qwen acceptance, data-scale, precision, verifier-contract, and
runtime-measurement negatives.

## PQ-019 prompt-cache semantics and readiness

The read-only PQ-015 preflight bound the existing runtime's
`--cache-prompt`/`--no-cache-prompt` boolean, the v21 client's `cache_prompt`
request field, and `timings.cache_n`. Its receipt is
[`pq015-cache-semantics-preflight-20260821.json`](../receipts/PQ-20260821-015-cache-reuse/pq015-cache-semantics-preflight-20260821.json),
SHA-256 `e61b6d6187dbbc46f9460d02f1c2b641d2f0886916af225fb659d103801ab48a`.
Preserved cache-off runs report zero cached prompt tokens. They do not contain
a positive cache-hit receipt or a repeated-prefix benchmark.

The planner then wrote the source-backed four-arm packet
[`PQ-019`](../experiments/planning/PQ-20260821-019-CACHE-ON-N1-RUNTIME-PACKET-20260822.md),
SHA-256 `4b9f9679966b99b3e4ee2114d55f24e69399fe5c7c1d3cf114c56027d0807f3e`.
The runtime inventory, critic, and literature review exposed the remaining
workload gate: the existing prompt manifest has a shared system prefix but no
registered prefix groups, request order, cold/warm/reset boundaries, or
expected cache-hit counts. Therefore PQ-019 is **conditionally blocked** and
has not been launched.

The reconciliation is preserved in
[`PQ-019 decision review`](../experiments/planning/PQ-20260821-019-CACHE-ON-N1-DECISION-REVIEW-20260822.md)
and its machine receipt
[`readiness.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/readiness.json)
(SHA-256 `49495bc473516e17e5d1d30730136db76732934c1e21a347dcb97d2e5fb647f7`).
The next safe artifact is a small public, source-backed repeated-prefix
manifest. It must bind prompt/rendered hashes, prefix hashes and lengths,
request order, cold/warm and reset boundaries, expected `cache_n`, and split
provenance. No positive cache hit may be assumed before that receipt exists.

If reopened, the four arms are target-only cache-off/on and Q8 n=1
cache-off/on, run sequentially with one warmup and three timed repetitions.
The comparison is within target-only and within Q8; `cache_n`, prompt timing,
completion tokens, wall/tok/s, acceptance, output hashes, and exactness/content
must remain separate. Even a positive result would be a local prompt-reuse
throughput observation, not proof of speculative acceptance, verifier
correctness, losslessness, or general serving speed.

## Current evidence boundary

The strongest Qwen evidence remains negative or measurement-only: target-only
is faster than every tested Q8 draft arm; Q4/Q8 n=1 are tied and slower;
PQ-002 and PQ-007 improved teacher-forced metrics without improving strict
acceptance; PQ-008's exact deployment bundle was not found; PQ-012 lacks phase
counters; and PQ-013 lacks a mixed-mode dispatcher and unbiased policy split.
No exact Qwen speculative-decoding speedup is established.

## Documentation and next action

No GPU, SSH mutation, model load, inference, held-out access, download,
install, or flag toggle occurred for PQ-019. The dated decision, packet,
command inventory, critique, literature handoff, and machine readiness receipt
are the durable record. The next falsifiable question is whether an explicitly
registered repeated-prefix workload yields positive cache reuse and lower
prompt or end-to-end wall time without changing output identity.

## PQ-019 contract/workload reconciliation (2026-08-22, additive)

The first PQ-019 draft mixed a Q4-bound v21 contract with a Q8 drafter and a
v23 prompt manifest. That provenance error is preserved as historical evidence
and is not used for execution. The selected route is now target-only plus the
exact v21 Q4 drafter (`18a380…`), at fixed n=1, with the canonical v20 six-row
source (`77a9…`) duplicated byte-for-byte into a 12-row cold/warm manifest
(`f911c7d3…`).

The v21 source contract is byte/hash pinned (`4be899…`, 1,741 bytes). Because
it declares `draft_tokens_max=7` while the selected server boundary is n=1,
the run uses two explicit local byte-level derivatives: n1 cache-off
(`d14ee941…`) changes only `draft_tokens_max 7→1`, and n1 cache-on
(`50c3a875…`) changes only `prompt_cache false→true`. The full machine diff is
`cab5e1ea…`; the canonical contract/workload receipt is
`f81744db…` with note `a39fe9dc…`.

This closes the local identity/workload gate but not the live gate. A fresh
remote hash/resource preflight and read-only rendered/prefix-hash check are
still required. Until those pass, no server, model, GPU, or cache flag is run.

## PQ-019 exact-artifact live preflight (2026-08-22, read-only)

A fresh SSH probe superseded the stale v30-Q4 receipt. It verified the exact
v21 Q4 file bound by the source contract: 1,143,006,752 bytes,
`18a380ef…0594`. The target/server/client/contract/workload identities match;
the RTX 3060 is idle at 1 MiB/0%, workspace free space is 2,144,796,672 bytes,
and no task server/client process exists. Receipt:
[`q4-v21-exact-artifact-live-preflight.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/q4-v21-exact-artifact-live-preflight.json),
SHA `6ea483b8…`.

Five of six rendered/token-prefix hashes remain UNKNOWN because the static v20
prompt file does not contain model-template/tokenizer output. This is now the
only known pre-execution gate in this lane; no server/model/GPU workload was
started.

## PQ-019 terminal result (2026-08-22)

The minimum cache diagnostic then ran once, sequentially, on the authorized
RTX 3060. Target-only moved from `16.0895` to `17.8801` tok/s with cache on
(`+11.13%`); Q4 DFlash n=1 moved from `18.1639` to `21.7631` tok/s
(`+19.82%`). Cache-off had zero cached tokens; cache-on had `1,014` cached
prompt tokens per timed repetition and reduced prompt-token work from `1,062`
to `48`. Q4 acceptance/proposed stayed `208/236` in both modes and each timed
rep produced 454 completion tokens. Within each model arm, output/message
content hashes match across cache modes.

The complete analysis is [`postrun-analysis.md`](../receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.md)
and machine receipt [`postrun-analysis.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.json).
Raw JSON/logs, order hashes, environment, cleanup, and terminal receipts are
preserved in the same directory. Final GPU state was 1 MiB/0%, no task process.

Disposition: **positive local repeated-prefix cache/prompt-processing effect**,
not a speculative-decoding speedup claim. Rendered/token-prefix hashes and
strict token-ID exactness remain UNKNOWN; no acceptance, quality, losslessness,
verifier, or general serving claim is allowed. The next research priority
returns to the unresolved verifier/state contract, not more blind cache sweeps.

## EXP-020 singleton-correction diagnostic (2026-08-22)

The current-runtime Qwen card [`EXP-20260822-020-qwen-singleton-correction`](../experiments/cards/EXP-20260822-020-qwen-singleton-correction.md)
is active after a narrow cache-off observation: Q4 DFlash n=1 measured
`18.1638816661` output tok/s versus target-only `16.0895399687`, a
`+12.892486%` difference on the frozen workload. Both arms emitted 454
completion tokens; Q4 accepted `208/236` proposals. Output hashes agree for
5/6 unique prompts (10/12 duplicated rows), while `code_python_debug` is the
sole deterministic mismatch in all three repetitions and both arms emit 64
tokens.

This is a promising but non-promotable raw lead. EXP-020's trace/singleton
correction result is pending; no running trace result is inferred here. Exact
token IDs, rejected-boundary localization, and a fresh matched throughput
screen remain promotion gates. The next admissible GPU action requires the
exact source-backed Arm-B/evaluator/state bundle or separately authorized
source-backed regeneration, with positions/sequence IDs, serialized
mask/cache/anchor/rollback semantics, evaluator/logger/replay/dependency
identities, resolved split, and the `[171,171]`/`[170,170]` conflict recorded.

## Post-PQ019 executable audit and recovery (2026-08-22)

The planner, critic, literature, and runtime lanes independently re-audited the
portfolio after PQ-019. They converge that no new source-backed Qwen GPU
improvement is admissible now: cache, precision, fixed-n, data-scale, objective,
mixed-mode, and aggregate-counter branches are terminal, negative, or missing
their required runtime artifacts. The planner audit is
[`PQ-20260822-NEXT-EXECUTABLE-AUDIT.md`](../experiments/planning/PQ-20260822-NEXT-EXECUTABLE-AUDIT.md),
SHA `76c5a99b…`; the critic and runtime audits are preserved beside it.

The smallest recovery action was a local-only PLAN-001 output/evaluator
reconciliation. It recovered all six target-only oracle assistant/content/
reasoning hashes, 321 completion tokens, 333 target decode calls, 17,743.828857
ms, evaluator/client/finalizer hashes, strict predicate/RNG settings, and
historical Arm-B fields. It did **not** recover the exact PLAN-001 Arm-B
serialization/source tie, complete logger/replay/dependency tuple, explicit
split, or the `[171,171]` versus `[170,170]` memory conflict. Receipt:
[`pq008-local-output-evaluator-reconciliation-20260822.json`](../receipts/PLAN-20260821-001/pq008-local-output-evaluator-reconciliation-20260822.json),
SHA `945548c5…`; note SHA `76b8a4ae…`. PLAN-001 remains blocked; no GPU or
model work was launched.

A fresh read-only remote check at `2026-08-21T23:01:47Z` confirms host
`9719ca4634c7`, RTX 3060 at 1 MiB/0%/54 C, no task processes, and
2,144,088,064 workspace-free bytes. Receipt:
[`live-state-check-20260822.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/live-state-check-20260822.json),
SHA `7b1dd3cb…`. The next GPU run remains conditional on one exact
source-backed deployment/selector/paired-state/runtime artifact; repeating a
terminal branch would not advance the stated objective.

## Scoped remote artifact probe (2026-08-22)

A narrow read-only SSH probe inspected the remote experiments tree to depth five
for `plan001`, `arm-b`, `replay`, `logger`, and `evaluator` filenames. It found
no candidate paths. The RTX 3060 remained at 1 MiB/0% with no task process.
Receipt: [`remote-artifact-probe-20260822.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/remote-artifact-probe-20260822.json),
SHA `f0b244bc…`. This confirms the external artifact boundary without broadening
the search or mutating the remote checkout.

## Recovery probe r2 (2026-08-22)

A second narrow read-only SSH check extended the filename search to depth seven
and included verifier names. It found no PLAN-001, Arm-B, replay, logger,
evaluator, or verifier candidate paths. Host `9719ca4634c7` reported RTX 3060
memory `1 MiB`, utilization `0%`, temperature `55 C`, and no task process (the
inspection shell was excluded). Receipt:
[`remote-artifact-probe-r2-20260822.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/remote-artifact-probe-r2-20260822.json),
SHA `6bffd9b3…`; note SHA `2c586f53…`.

Disposition: the external contract blocker remains confirmed. This probe adds
no scientific result and does not authorize a GPU run; reopening still requires
an exact source-backed deployment/evaluator/state artifact.

## Lane review after recovery r3 (2026-08-22)

Planner, critic, runtime, and literature lanes independently reviewed the
content-level no-found result. Their machine-bound consensus is recorded in
[`r3-lane-review-receipt-20260822.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/r3-lane-review-receipt-20260822.json).
No new one-variable Qwen acceptance/speed axis is admissible without the exact
Arm-B/evaluator/state bundle. PQ-019 remains a local cache diagnostic only;
the next action is external artifact supply or separately authorized
source-backed regeneration.

## Recovery content probe r3 (2026-08-22)

The remote checkout was searched by content across experiment, script, config,
runtime, and tool roots. The broad pass found only historical logs, build
files, and existing runtime sources. A narrowed pass excluding logs, builds,
and receipts found zero source/config/planning matches for PLAN-001, Arm-B,
replay, serialized mask/cache, evaluator, rollback, or memory-conflict fields.
Receipt:
[`remote-content-probe-r3-20260822.json`](../receipts/PQ-20260821-019-cache-on-n1-20260822/remote-content-probe-r3-20260822.json),
SHA `63768b01…`; note SHA `ff272da9…`.

Disposition: content-level recovery is exhausted for the scoped checkout. No
GPU run is authorized without external artifact supply or a separately
authorized source-backed regeneration task.
