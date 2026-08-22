---
id: CRITIQUE-QWEN-EXP020-REMOTE-SOURCE-SEMANTICS-PROBE-FINAL-RECHECK2-20260822
date: 2026-08-22
kind: final canonical packet recheck; no-execution gate
packet: experiments/planning/runtime-qwen-exp020-remote-source-semantics-probe-20260822.md
packet_sha256: d79b9ca9ae2ec00f69c58d7d44a65260a46675fa1810b494b79e7d6dc7301e1f
verdict: CONDITIONAL PASS; THREE REMAINING CONCRETE DEFECTS; NO EXECUTION
---

# Recheck decision

The `.part` capture/promotion, non-overwriting partial receipt, byte-counted
SSH failure path, pre/post process and GPU-utilization checks, and explicit
marker dispositions now address the earlier gate failures. The packet is
otherwise bounded to one frozen endpoint, two pinned paths, metadata and
numbered marker context, with no source write, build, model, server, timing,
or GPU action.

**Conditional pass for the snippet-only observation after the remaining
defects below; no SSH or GPU action was performed.** The snippets are
source-derived text crossing the host boundary, so execution still requires
that the user's literal no-download policy permits this narrowly bounded
non-file transfer. No source-backed intervention is authorized.

## Remaining concrete defects

1. **The process expression is not self-safe or complete.**
   `pgrep -af "(^|/)(llama-server|benchmark_client_v21.py|pq020_run)"` is
   embedded in the remote shell command itself. Because `-f` searches full
   command lines, the shell/SSH command can contain `pq020_run` and appear as
   an active process even when the experiment is idle. The expression also
   covers only three spellings and can miss a frozen task wrapper. Replace it
   with a self-safe pattern (or inspect a frozen task-root/launcher set) and
   preserve the raw pre/post snapshot. Do not broaden to unrelated processes.

2. **GPU identity/count is recorded but not pinned across snapshots.** The
   packet checks that utilization fields are nonempty and all parsed values
   are zero, but does not require `post_gpu` to be nonempty, equal to `gpu`,
   or to have the same row count. A malformed or changed device response could
   therefore pass the idle gate. Require the frozen GPU identity and expected
   row count to match before/after while retaining observed memory values.

3. **The all-zero marker hard stop is still executor-only.** The remote body
   always emits `status=PASS_SNIPPET_ONLY` after its other checks; it does not
   assert that at least one marker hit exists. This is safe only if the
   mandatory local marker-index stage is explicitly machine-bound to reject
   an all-zero result as `NO_CANDIDATE_SOURCE_GAP` before writing any PASS
   terminal. Add that dependency to the executor contract or emit an
   aggregate-hit field and fail remotely.

The ordinary `.part` cap/nonempty-stderr failures now call `write_partial`.
The executor should still wrap `wc -c` and the two `mv` promotions so a local
filesystem/receipt error also creates a non-overwriting partial terminal;
this is a small handoff requirement, not a reason to use SSH or GPU.

## Claim boundary

Even after these repairs, a PASS means only bounded marker hits and nearby
numbered context from the two remote paths whose pinned metadata matched
before and after the read. It cannot establish full source provenance, source
semantics, token/state correctness, speed, acceptance, exactness,
losslessness, or a Qwen improvement. Preserve `UNKNOWN` and
`NO_CANDIDATE_SOURCE_GAP` for missing, duplicated, malformed, truncated, or
context-incomplete entries.

Sources: the amended canonical packet above and prior packet critiques. No
remote evidence was collected.
