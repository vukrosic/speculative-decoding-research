---
date: 2026-08-22
kind: literature/evidence handoff
scope: EXP020 current-65b8 target-only/Q4 n=1 phase pair
status: terminal descriptive diagnostic; no promotion
---

# Post-run interpretation

## What is closed

The pair is provenance-valid for its narrow purpose. Both arms used the
task-owned instrumented server `fcbf4b9d…`, resolved
`libllama-common` `65b8a862…`, the same target, `code_python_debug` prompt,
cache-off contract family, seed 42, greedy settings, device 0, and no
`PQ020_LOW_MARGIN_TOP2` or split-flash variables. The terminal receipt states
that neither `d07ed8b4…` nor `1bbaf7b5…` was loaded, and cleanup left the RTX
3060 idle. This closes the cross-library concern for this pair; it does not
make the historical d07 Q4 trace comparable.

The target-only response matched its current oracle (`0f76b6ae…`, 64 tokens,
length). Q4 produced a separate 64-token response (`1d5020bf…`), with 35
proposed and 28 accepted draft tokens in the diagnostic client record. The
parser reports 70 proposals, 56 accepted, and 14 rollback events over the
combined warmup plus diagnostic log; those totals must not be relabeled as
diagnostic-request-only counts.

## What the phase evidence says

The current parser records target-only prompt/prefill 504.999 ms and
non-speculative target decode 2772.969 ms. Q4 records prompt/prefill 633.091
ms, verify-batch construction 3599.022 ms, target verification 114.615 ms,
and correction/rollback 1.206 ms. Q4 draft-vector construction, non-spec
decode, accepted-vector commit, and scheduler/HTTP residual are `unknown`;
target-only verifier phases are not applicable/unknown. Q4 phase intervals
and marker counts are log-wide across warmup plus diagnostic, whereas the
client wall/timing fields are for the diagnostic repetition. The clocks and
aggregation scopes therefore cannot be subtracted or pooled into a speed
comparison.

These receipts close a descriptive within-runtime event stream: they show
that the existing instrumentation observed draft, verify, correction, and
rollback events under 65b8. They do **not** establish exactness, verifier
correctness, acceptance improvement, losslessness, end-to-end speed, or a
causal bottleneck. The Q4 content-hash difference is an explicit boundary, not
a phase diagnosis.

## Next source-backed action

Do not rerun or patch from this result. First perform a documentation/parser
reconciliation over the preserved logs that isolates warmup from diagnostic
request boundaries (or marks that separation `UNKNOWN`) and emits a
per-request phase table with the existing `pq020.phase.v1` schema, clock units,
and interval provenance. Keep unknown phases unknown; never impute them as
zero. This is the smallest action that can make the current evidence
interpretable without introducing a new runtime variable.

If a later intervention is justified, use only that reconciled table to design
one source-backed runtime hypothesis (for example, verify-batch or
draft-vector overhead), with a new planner/critic packet and its own exactness
and cleanup gates. Preserve this pair as a one-prompt 65b8 diagnostic and keep
the external Arm-B/state-evaluator gap open for any verifier claim.

Sources: `receipts/EXP-20260822-020-qwen-singleton-correction/current-65b8-phase-pair-20260822/summary.json`,
`terminal.md`, `raw/target-phase.json`, `raw/q4-phase.json`, and the paired
client diagnostics. No new execution occurred in this literature review.

## Machine receipt identity

The completed receipt directory is
`receipts/EXP-20260822-020-qwen-singleton-correction/current-65b8-phase-pair-20260822/`.
SHA-256s: `summary.json`
`4e51b43710694f2895e4b783e01ee993e52f2cfb24d6195926161e1d57c7204b`,
`terminal.md` `a6d2c9fe6227e852d04a7c9fdb56501f1ca30744eadc1e2378deac4e7f6fdfd0`,
`SHA256SUMS.txt` `070950d2bca67fa7586b35e98029a5c1d589b346b44433a6508b488d3e61f9b2`,
and `cleanup.json` `92e16f04cf29c7bd0be4664efdb6c85bca4930b63e0b93a600fabdad151f79cb`.
Runtime identities are server `fcbf4b9d5847f19ad2391af0109b3d0d067de19d0448bb96acc1a1011af20d41`,
`libllama-common` `65b8a862607e2894f7ec87eb073a74d70e3501b3bbd6bec709dc2a1d8dafca56`,
implementation `fd5a9bf6ac5237f0c8821bc66a75e81c7c1b1a24b4ac487a496d4fbe4386a066`,
runner `1adb22e41338f57e11910505e149d6b73d50e3b5a33e4c5e76688a6455601843`,
parser `610f8466e64e7b9a1d30bbd07796485898ced38f5598be1b22109ca5c57dbc1b`.
Workload identities are target `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`,
Q4 drafter `18a380efc9b7ed8d88677fc895f5c11ae170653434ee378f7348f715c14d0594`,
client `477b271d3e34616282c3d4c85ea278d67441f1bf0be8dec5a366a7374f9a37a4`,
prompt `374eea10112daeac6cd6d9499230abd6ac68cfebf7804c14e96bb71a7223b7d5`,
target contract `d8bf1e89052b8a4602763142cfc1e306e452fc1006363452934713bbfcdaf08b`,
Q4 contract `710f45034dafdda853a09f14c7398aa140ee21ffc6d172d05242c2018601532c`.
The final cleanup receipt reports NVIDIA GeForce RTX 3060, 1 MiB used, 0%
utilization, no task compute processes, and no task processes. These exact
receipt identities supersede the preflight's blocked-before-execution status;
the preflight remains useful historical evidence of the former identity gate.

## Offline parser reconciliation and source-map closeout

The CPU-only parser `pq020_reconcile_requests.py` is SHA-256
`d8a49d5a0ac2666d500d28836caad207db0cee6c8cf48ffd76b3b8c32659fd96`; compact
summary SHA is `eb934236a9ae90e4929e38edf34d5d6574194a0897c664c1f762b7854b67ef38`,
joined JSON SHA is `42f8ffa3e34101fea2d1960afc3fbfd8cfc1b74e5a6d14c181eda5095e5bbeaa`.
Schema is `pq020.request_cycle_joined.v1`. It derives Q4 warmup task `1` and diagnostic
task `42`, each with 35 cycles; target diagnostic task `70` has no speculative
markers. Q4 diagnostic intervals are `VERIFY_BATCH_BEGIN→VERIFY_BEGIN
1745.412 ms`, `VERIFY_BEGIN→VERIFY_RESULT 55.829 ms`, and
`VERIFY_RESULT→MEMORY_AFTER 0.601 ms`; warmup is `1853.610/58.786/0.605 ms`.
The draft-generation increment is approximately `378.665 ms` over 35 calls.
Per-request server timing is target prompt/eval/total
`505.00/2772.97/3277.97 ms` and Q4 `633.09/2184.52/2817.61 ms`. Raw
`spec common_specu` log summaries report warmup
`dur(b,g,a)=0.002, 382.432, 0.010 ms` and diagnostic
`0.003, 761.097, 0.018 ms`; these remain descriptive log fields.

Source-map receipt
`receipts/EXP-20260822-020-qwen-singleton-correction/current-65b8-phase-pair-20260822/source-map-audit-20260822.json`
has SHA-256 `6d1aab16d3efbc1361542d5732163da9429e95b9d58489afb429da5debc3b4f8`.
Offline literature verdict
`literature/VERDICT-20260822-EXP020-65B8-OFFLINE-RECONCILIATION.md` has SHA
`e99d1c676ff3028811495cf705e6c5dbeff28c1d5f7b875152964567ff9e40c3` and
closes the local source-map candidate as **NO_CANDIDATE / SOURCE GAP**. Only
hash references exist for `common/speculative.cpp` `6a24e473…` and
`tools/server/server-context.cpp` `c060c9f5…`; the sole reopen is source-only
intake of both full matching files. No patch, build, GPU, rerun, speed,
exactness, acceptance, verifier, or causal claim is authorized.
