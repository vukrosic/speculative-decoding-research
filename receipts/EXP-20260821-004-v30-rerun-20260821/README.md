# Receipt schema — EXP-20260821-004 v30 rerun

Status: `completed-negative; bounded approximate rerun terminalized`  
Scope: existing F16/Q4_K_M/Q8_0 artifacts; approximate validation only

The CEO-approved rerun completed within scope. See
[`summary.json`](summary.json) for arm aggregates,
[`cleanup.json`](cleanup.json) for task-owned cleanup/final device state, and
[`terminal.json`](terminal.json) for terminal disposition and claim boundary.
The initial Q8 path typo is preserved in `launch-error.log`; it occurred before
any process and was corrected without changing scope.

## Frozen comparison

- Target/runtime/evaluator/prompt manifest/contract exactly as pinned in
  `governance/QWEN-V30-QUANTIZATION-MANIFEST-20260821.md` and
  `receipts/PLAN-20260821-001/v30-provenance-supplement-20260821.json`.
- Arms: existing F16 `8e3edd04…`, curve Q4_K_M `2a7828cf…`, curve Q8_0
  `f71a2145…`; no re-quantization, training, or artifact mutation.
- Fixed n=4, 64 max completion tokens, strict greedy flags, 12 prompts, one
  RTX 3060, one process, maximum one hour.
- One warmup and three timed repetitions per arm plus one matched target-only
  baseline. No held-out access.

## Required files and fields

- `environment.json`: host/GPU/process ownership, target/drafter/runtime/
  evaluator/prompt/contract hashes, command/configuration, start state.
- `target-only-baseline.json`: prompt/output counts, target-content metric,
  output-token accounting, timing/VRAM, and exact receipt hash.
- `f16.json`, `q4km.json`, `q8.json`: per-prompt/per-repetition outputs and
  hashes, proposed/accepted counts, target-content matches, output-token
  counts, latency/tok/s, peak VRAM, and any errors.
- `summary.json`: pre-registered arm aggregation, warmup exclusion, mean and
  spread, acceptance/content/timing/VRAM separated, and approximate-only
  interpretation. Exactness is recorded as failed/diagnostic-only and cannot
  become a lossless or general speed claim.
- `cleanup.json`: task-owned process termination, tmux/server state, final
  `nvidia-smi` utilization/memory/compute-app state, and cleanup errors.
- `terminal.json`: terminal disposition, artifact hashes/paths, commands,
  failures, cleanup state, and knowledge update.

## Hard stops

Stop before comparison on any identity/artifact mismatch, target-only baseline
mismatch, missing output-token accounting, resource contention, held-out access,
scope expansion, or cleanup failure. The run is terminal and no further
execution is authorized by this receipt. Any follow-up requires a new planner
packet, critic review, literature input, and CEO decision; anything outside the
delegated bounded scope remains `SEPARATE USER APPROVAL REQUIRED`.
