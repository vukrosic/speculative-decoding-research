---
id: CRITIQUE-QWEN-EXP020-OFFLINE-RECONCILIATION-SOURCE-MAP-FINAL-20260822
date: 2026-08-22
kind: final offline parser/source-map review
verdict: PASS FOR DESCRIPTIVE RECONCILIATION; NO-CANDIDATE-SOURCE-GAP BLOCKS INTERVENTION
---

# Review verdict

The finalized CPU-only reconciliation is mechanically adequate for descriptive
request/cycle accounting. It correctly splits each preserved server log into
two requests at `new prompt` and closes each at the same-task `release`, keeps
`print_timing` inside the request, joins the corresponding repetition-0 and
repetition-1 client JSON, and groups speculative cycles at each
`PQ020_VERIFY_BATCH_BEGIN`.

The joined receipt is schema `pq020.request_cycle_joined.v1`, status
`completed_cpu_only_log_reconciliation`, and SHA-256
`971da351ddfdfa521dd4e8ebc66a66340d7d8804ca4d3172d8c5308459f0b82d`. Its
parser is `pq020_reconcile_requests.py`, SHA-256
`5d77b59044fbdbe46debac69b9634f5f4e08be9b485e3c66f5293711877a6f1b`.

## Confirmed segmentation and counters

- Target-only has warmup task `1` and diagnostic task `70`; both close with
  same-task release evidence and correctly contain no speculative cycles.
- Q4 n=1 has warmup task `1` and diagnostic task `42`; both close with
  same-task release evidence and contain 35 cycles each.
- Each Q4 request retains 70 batch rows, 70 verify rows, 63 accepted-vector
  rows, and counters 35 proposed, 28 accepted, and 7 rollback. The diagnostic
  request therefore preserves the client 35/28 accounting without mixing the
  warmup into the reported counters.
- Cycle records retain batch/verify rows, draft vectors, raw logits, sampler
  rows, verify results, accepted vectors, memory-after rows, line numbers,
  task IDs where emitted, timestamp units, and source-log linkage.

The segmentation is evidence-backed, not a universal assumption about numeric
task IDs: the parser derives boundaries from the log and records the observed
IDs in order.

## Unknowns and residuals

The reconciliation is correctly fail-closed about unmeasured work. It keeps
target-only speculative fields as `unknown`/`not_applicable`, and leaves draft
vector construction, accepted-vector commit, scheduler/HTTP residual, and
unattributed request residual explicit rather than zero-imputing them. The
marker-bounded memory-to-next-batch gap is separately named as a residual.
These fields must not be interpreted as measured zero cost.

The earlier review identified a documentation completeness gap around the
`spec common_specu: statistics` lines. That gap is closed in the finalized
parser addendum below; the source/log interpretation remains unchanged.

## Source-map disposition and intervention boundary

The source-map audit receipt
`source-map-audit-20260822.json` (SHA-256
`6d1aab16d3efbc1361542d5732163da9429e95b9d58489afb429da5debc3b4f8`) is
read-only and reports `NO_CANDIDATE_SOURCE_GAP`. The exact pinned source bytes
for `common/speculative.cpp` (`6a24e473...`) and
`tools/server/server-context.cpp` (`c060c9f5...`) are absent from the local
workspace; only hash references, marker logs, and parser artifacts remain.
Therefore no marker can be bound to a causal source operation, and no
verify-batch, transaction, graph/allocator, draft-generation, mask, rollback,
or selector intervention may be drafted or authorized from this evidence.

The smallest reopen is source-only intake of both full files with matching
SHA-256 values, followed by the same read-only map. This does not authorize
SSH, download, build, model load, GPU execution, rerun, or source mutation.

## Final disposition

**PASS for offline descriptive reconciliation; BLOCKED for any intervention by
the `NO_CANDIDATE_SOURCE_GAP`.** Preserve the pair and all negative/exactness
boundaries. Do not convert the draft-duration clue or 35/28 counters into
speed, acceptance, exactness, verifier, or causal claims.

## Addendum — finalized parser/statistics closure

The prior documentation gap is now closed. The finalized parser is
`pq020_reconcile_requests.py`, SHA-256
`d8a49d5a0ac2666d500d28836caad207db0cee6c8cf48ffd76b3b8c32659fd96`; the
joined receipt is SHA-256
`42f8ffa3e34101fea2d1960afc3fbfd8cfc1b74e5a6d14c181eda5095e5bbeaa`; and
the compact summary is
`pq020-request-cycle-joined-summary.json`, SHA-256
`eb934236a9ae90e4929e38edf34d5d6574194a0897c664c1f762b7854b67ef38`.

The joined receipt now captures `spec_common_specu` cumulative and per-request
statistics. It records 382.432 ms warmup draft duration, 761.097 ms cumulative
duration, and the diagnostic increment 378.665 ms over 35 calls, while keeping
target-only `not_emitted` and all unbounded phases/residuals explicit. This
closes the accounting/documentation gap; it does not change the interpretation
or source boundary. The source-map audit remains
`NO_CANDIDATE_SOURCE_GAP` (receipt SHA
`6d1aab16d3efbc1361542d5732163da9429e95b9d58489afb429da5debc3b4f8`), so no
source-backed intervention is admissible.

Sources: `receipts/EXP-20260822-020-qwen-singleton-correction/current-65b8-phase-pair-20260822/pq020-request-cycle-joined.json`,
`pq020_reconcile_requests.py`, `source-map-audit-20260822.json`,
`literature/VERDICT-20260822-EXP020-65B8-OFFLINE-RECONCILIATION.md`, and
`experiments/planning/runtime-qwen-exp020-current-65b8-phase-pair-postrun-ranking-20260822.md`.
