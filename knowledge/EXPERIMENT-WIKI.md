# Qwen speculative-decoding experiment wiki

Last updated: 2026-08-22  
Scope: Qwen3.8-27B DFlash2-style drafting on the authorized RTX 3060.

This page is the compact map of the lab history. It is not a replacement for
raw receipts: every row links to the experiment card, machine receipt, or
review that carries the authoritative details. Claims are deliberately split
into teacher-forced training, acceptance, exactness/content, and serving
throughput.

## Current decision

The research goal is still active: improve Qwen speculative decoding. There is
no new GPU run authorized at this boundary. The next high-information action is
to recover an exact source-backed PLAN-001/PQ-008 verifier/state bundle. The
latest read-only reconciliation recovered oracle/evaluator facts but did not
recover the exact deployment Arm-B serialization/source tie, complete
logger/replay/dependency identity, explicit split, or the `[171,171]` versus
`[170,170]` memory conflict.

- [Current state](../CURRENT-STATE.md)
- [Latest Qwen ledger](QWEN-RESEARCH-LEDGER-2026-08-22.md)
- [Next executable audit](../experiments/planning/PQ-20260822-NEXT-EXECUTABLE-AUDIT.md)
- [Local PLAN-001 reconciliation](../receipts/PLAN-20260821-001/pq008-local-output-evaluator-reconciliation-20260822.json)
- [Scoped remote no-found probe](../receipts/PQ-20260821-019-cache-on-n1-20260822/remote-artifact-probe-20260822.json)
- [Follow-up no-found probe](../receipts/PQ-20260821-019-cache-on-n1-20260822/remote-artifact-probe-r2-20260822.json)
- [Content-level no-found probe](../receipts/PQ-20260821-019-cache-on-n1-20260822/remote-content-probe-r3-20260822.json)
- [r3 planner/critic/runtime/literature consensus](../receipts/PQ-20260821-019-cache-on-n1-20260822/r3-lane-review-receipt-20260822.json)
- [This wiki update receipt](../receipts/PQ-20260821-019-cache-on-n1-20260822/experiment-wiki-update-20260822.json)

## Results at a glance

| ID | Axis | Evidence | Disposition |
|---|---|---|---|
| PQ-002 | Prefix-survival objective | Best n=4 accepted/cycle `0.1996047`, below the `0.20198` incumbent gate | Negative; do not repeat unchanged |
| PQ-006 | Fixed draft length | Target-only mean `17.3497` tok/s; n=1 `16.0129`, n=2 `13.7929`, n=3 `12.3748`, n=4 `11.5310` | Negative for serving speed; n=2 had the highest observed acceptance, not a promotion |
| PQ-007 | +2,000 source-disjoint training windows | Validation CE `2.48420` vs parent `2.68951`; n=4 acceptance `0.176699` vs `0.20198` | Teacher-forced improvement, terminal-negative acceptance |
| EXP-011 / PQ-009 | Q4 vs Q8 at fixed n=1 | Q4 `16.0923`, Q8 `16.0878`, target-only `17.4025` tok/s; both `98/508` accepted | Precision near-tie; retired as a speed lever |
| PQ-019 | Repeated-prefix prompt cache | Target `16.0895→17.8801` (+11.13%); Q4 n=1 `18.1639→21.7631` (+19.82%); cache-on `1,014` cached prompt tokens/rep | Positive local cache/prompt-processing effect only |
| EXP-020 | Rejection-only singleton correction (active diagnostic) | Q4 n=1 cache-off `18.1638816661` vs target `16.0895399687` tok/s (+12.892486%); `208/236` accepted; 5/6 unique prompt output hashes agree | Narrow lead; non-promotable until exact token IDs and trace result |
| PQ-008 | Verifier/state localization | Exact deployment bundle not found; several contract fields remain UNKNOWN/CONFLICT | Terminal recovery blocker; no Arm A/B/D run |
| PQ-012 | Runtime phase decomposition | Aggregate counters exist; per-phase draft/verify/cache/scheduler timers and exactness binding do not | Measurement-gap negative |
| PQ-013 | Prompt-level gating/mixed mode | No source-backed dispatcher and no unbiased calibration/held-out policy split | Terminalized planning-only hypothesis |

### Interpreting the table

The cache result is the only recent positive throughput observation, but it is
about repeated prompt reuse. It does not show that speculation is faster. All
tested Qwen speculative arms remain below target-only on the registered
serving screens, and the exact token-ID/content contract is not complete for
the frozen wrapper.

## Experiment records

### PQ-002 — prefix-survival objective

The objective improved some training metrics but did not clear the strict
acceptance gate. The best recorded n=4 result was `0.1996047` accepted/cycle,
below the `0.20198` incumbent. Preserve the negative result; do not scale the
same objective or data without a new causal variable.

- [Planning/critique history](../experiments/critique/PQ-20260821-002-POSTRUN-NEGATIVE-AND-FIXED-N-SWEEP-CRITIQUE-20260821.md)
- [Acceptance receipts](../receipts/PQ-20260821-002-prefix-objective-20260821/acceptance-screen/)

### PQ-006 — fixed-n runtime screen

This was the cleanest direct serving comparison. Increasing n reduced wall
throughput on this RTX 3060. n=1 was the fastest draft arm but still slower
than target-only; n=2 had higher acceptance but did not pay for its draft cost.

- [Experiment card](../experiments/cards/EXP-20260821-010-qwen-fixed-n-runtime.md)
- [Runtime receipts](../receipts/PQ-20260821-006-fixed-n-runtime-20260821/)

### PQ-007 — added data and fit

The augmented fit used 11,944 train rows (9,944 frozen + 2,000 new) and 508
validation rows. The one-epoch repair fit improved validation loss and token
accuracy, proving only a teacher-forced fit change. The exported checkpoint
then produced `91/2010 = 0.176699` accepted/cycle at n=4, below the parent
`0.20198`; target-content and strict exactness fields were unavailable.

- [Fit receipt](../receipts/PQ-20260821-007-data-scale-100k/pq007-fit-12452-v26repair.json)
- [Negative acceptance receipt](../receipts/PQ-20260821-007-data-scale-100k/pq007-n4-screen.json)
- [Final critique](../experiments/critique/PQ-20260821-007-N4-POSTRUN-NEGATIVE-CRITIQUE-20260821.md)

### EXP-011 / PQ-009 — drafter precision at n=1

Q4_K_M and Q8_0 were effectively tied (`+0.028%` Q4 versus Q8) and both
lagged target-only by roughly 7.5%. Acceptance was identical at `98/508`.
This retires precision as the next speed axis for this configuration.

- [Precision card](../experiments/cards/EXP-20260821-011-qwen-drafter-precision-n1.md)
- [Raw receipts and cleanup](../receipts/PQ-20260821-009-q4-q8-n1-precision-speed/)
- [Post-run critique](../experiments/critique/EXP-20260821-011-PQ009-POSTRUN-CRITIQUE-20260821.md)

### PQ-019 — repeated-prefix prompt cache

The selected route was target-only plus the exact v21 Q4 drafter at n=1. The
workload duplicated six public API-message rows byte-for-byte into a cold then
warm sequence. Cache-off reported `cache_n=0`; cache-on reported positive reuse
and reduced prompt work from 1,062 to 48 tokens per receipt. Q4 acceptance and
completion-token counts stayed unchanged.

This is a bounded local cache-cost diagnostic. Rendered/token-prefix hashes
and strict token-ID exactness remain UNKNOWN, so the result must not be
described as general speculative speed, quality, losslessness, or verifier
improvement.

- [Durable experiment card](../experiments/cards/EXP-20260822-019-qwen-prompt-cache-reuse.md)
- [Post-run analysis](../receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.md)
- [Machine summary](../receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.json)
- [Raw arm receipts](../receipts/PQ-20260821-019-cache-on-n1-20260822/raw-remote/)
- [Post-run critique](../experiments/critique/PQ-20260821-019-POSTRUN-CRITIQUE-20260822.md)

### EXP-020 — singleton correction diagnostic (active)

The current-runtime diagnostic was activated after the cache-off Q4 n=1
screen showed a narrow raw-throughput lead: `18.1638816661` tok/s versus
target-only `16.0895399687` tok/s (`+12.892486%`). Both arms produced 454
completion tokens and Q4 accepted `208/236` proposals. Only 5/6 unique prompt
output hashes agree (10/12 duplicated rows); `code_python_debug` is the sole
deterministic mismatch across three repetitions, with 64 tokens on each arm.

This is a useful lead, not a result to promote: strict token-ID equality,
rejected-boundary localization, and the current trace outcome are still
pending. The card explicitly forbids inventing a speed or correctness result
before those gates close. The GPU lane can reopen only with the exact
source-backed runtime/evaluator/state contract (or separately authorized
source-backed regeneration), including Arm-B positions/sequence IDs,
mask/cache/anchor/rollback semantics, evaluator/logger/replay/dependency
identities, resolved device split, and the `[171,171]` versus `[170,170]`
memory conflict.

- [EXP-020 card](../experiments/cards/EXP-20260822-020-qwen-singleton-correction.md)
- [Trace contract](../receipts/EXP-20260822-020-qwen-singleton-correction/benchmark-contract-q4-n1-code-python-trace.json)
- [Paper-material claim boundary](../paper-material/claims.md)

### PQ-008 — verifier/state recovery

The historical source reconciliation recovered target-only oracle hashes,
completion accounting, strict predicate/RNG settings, and partial Arm-B
metadata. It did not recover an exact PLAN-001 deployment bundle. The scoped
remote probe also found no candidate files under the experiments tree. This is
a real artifact boundary, not evidence that Qwen cannot be improved.

- [Recovery packet](../experiments/planning/PQ-20260821-008-METADATA-RECOVERY-PACKET-20260821.md)
- [Remaining-field disposition](../experiments/planning/PQ-20260821-008-REMAINING-FIELDS-DISPOSITION-20260821.md)
- [No-found lookup](../receipts/PLAN-20260821-001/pq008-final-artifact-lookup-20260821.json)
- [Latest reconciliation](../receipts/PLAN-20260821-001/pq008-local-output-evaluator-reconciliation-20260822.json)

## Evidence and documentation protocol

Every meaningful action gets a durable record in the following order:

1. **Card or plan:** hypothesis, one changed variable, baseline, stop rules.
2. **Preflight receipt:** model/runtime/prompt/data hashes, host/GPU/process/
   storage state, and held-out boundary.
3. **Raw run receipt:** exact argv/environment, per-repetition metrics, logs,
   output hashes, and failure details.
4. **Cleanup receipt:** final GPU/process/storage state and task-owned cleanup.
5. **Review:** adversarial critique plus literature/evidence handoff.
6. **Ledger/wiki:** one dated summary that links every artifact and preserves
   the claim boundary.
7. **Trace:** append one JSON object to `state/inference-traces.jsonl` so the
   decision history is machine-searchable.

Do not overwrite a failed or superseded artifact. Add a dated amendment and
link the old receipt. Keep teacher-forced, acceptance, exactness/content, and
serving-speed evidence in separate fields. A positive cache observation is not
an acceptance result; a lower validation loss is not a serving result.

## Reopening the GPU lane

The next GPU run requires an externally supplied or separately authorized
source-backed bundle containing, at minimum:

- exact Arm-B positions, sequence IDs, mask/cache serialization, anchor and
  rollback semantics, and source/config tie;
- evaluator, logger, finalizer, replay, RNG, and dependency identities;
- resolved device split and the `[171,171]` versus `[170,170]` memory conflict;
- a frozen one-variable intervention, matched target-only control, exactness
  oracle, and complete cleanup/receipt contract.

Until those inputs exist, the correct action is documentation and bounded
artifact recovery—not another precision, n sweep, data expansion, gate, or
guessed runtime flag.

## Canonical navigation

- [Knowledge-base README](README.md)
- [Daily journal](../daily/2026-08-22.md)
- [Results index](../results/INDEX.md)
- [Failures index](../failures/INDEX.md)
- [Experiment queue](../experiments/queue/QWEN-PORTFOLIO-QUEUE-20260821.md)
- [Inference trace](../state/inference-traces.jsonl)
