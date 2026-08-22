---
id: EXP-20260822-021-qwen-v22-split-flash-n1
date: 2026-08-22
status: preflight
method: source-backed verifier-operation diagnostic
exactness_contract: fresh target-only oracle plus six-prompt output/token/finish checks
heldout_touched: false
tags: [qwen, dflash2, verifier, flash-attention, n1, exactness-first]
---

# Question

Does the preserved v22 singleton-shaped flash-query verifier branch preserve
the frozen target outputs at draft width `n=1`, and if it does, does its
per-query attention decomposition change end-to-end serving time?

## Authorization and scope

- Authorized action: one task-owned v22 build and one sequential off/on `n=1`
  diagnostic on the existing RTX 3060, only after live identity preflight.
- Explicit exclusions: `n>1`, held-out data, training, downloads/installs,
  Arm-B reconstruction, threshold retuning, prompt exceptions, serving
  promotion, and unrelated source edits.
- Stop conditions: any source/build/model/contract/argv mismatch, target-only
  output drift, candidate exactness failure, mask/position/cache error, OOM,
  competing process, disk/GPU issue, or cleanup failure.
- Artifact/storage budget: compact receipts and hashes only; large binaries and
  logs remain on the remote task-owned path.

## Frozen controls

- Target checkpoint: Qwen3.8-27B UD-IQ1_S,
  `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`.
- Drafter: Qwen3.8-27B-DFlash2 Q4_K_M,
  `18a380efc9b7ed8d88677fc895f5c11ae170653434ee378f7348f715c14d0594`.
- Prompt manifest: six public v20 prompts,
  `77a9b5703756102bc088891419a6b85f45bd6a26118c4daded334dec91db8514`.
- Contract: v21 source contract,
  `4be899bfe57fb32aea59dadae4c4eefccb558a7302688f8607a850b8dc3d4662`.
- Seed/settings: seed 42, temperature 0, top-k 1, context 4096, parallel 1,
  cache off, all GPU layers, `draft_tokens_max=1`.
- Runtime: v22 parent revision `5ecbe1ac17ec0484c5b44af0bd580cdc9c428ed4`;
  exact v22 source/build identities must be captured before mutation.

## Intended change

Only `LLAMA_V22_SPLIT_FLASH_QUERIES=off` versus `on`: the preserved v22 branch
splits each non-prompt query row into singleton flash-attention calls while
preserving the materialized K/V cache and causal-mask rows. The tracing and
selector perturbation portions of the historical patch are excluded.

## Baseline

The same v22 build with the split-flash branch disabled, followed by a fresh
target-only oracle and sequential unmodified `n=1` baseline. Historical v22
6/6 evidence is context only and is not reused as proof.

## Preflight gates

- [ ] exact v22 source tree, patch, compiler/CUDA/CMake, binary and model hashes
- [ ] target-only oracle reproduces all six outputs, token counts, and finishes
- [ ] baseline and candidate use the same build, prompt order, and environment
- [ ] all six candidate outputs pass before timing is interpreted
- [ ] per-run acceptance/output accounting and event/schema receipts
- [ ] disk/GPU/process ownership and cleanup

## Results

### Observed checkpoint (2026-08-22)

- Historical patch artifact was malformed; task-local semantic reconstruction
  is recorded by `apply_v22.py` (candidate source SHA
  `674941f7502b09a825e9641ff236d8c7ccad20209c7bfda99abb3e99db09f901`). The
  candidate-only graph/server diff hashes are `2c7d45d6…` and `94d41382…`;
  clean candidate source hashes are `751c7ce4…` and `43551af0…`.
- First `/dev/shm` build used native CUDA detection and hard-stopped at 8%
  when UI provisioning attempted a HuggingFace download; `/dev/shm` is
  `noexec`, and no model/GPU inference started.
- Retry used explicit `CMAKE_CUDA_ARCHITECTURES=86`,
  `LLAMA_BUILD_UI=OFF`, and `LLAMA_USE_PREBUILT_UI=OFF`, but
  `LLAMA_BUILD_APP=ON` still invoked `llama-ui-embed` and hard-stopped at 38%
  with missing embedded assets/permission denied. No model/server/inference
  ran.
- The source-backed continuation is an asset-preseed recipe: provide the
  exact `tools/ui/dist` manifest before configure, keep UI/download paths
  disabled, and set the application/embed target off as required by the
  source build graph. The frozen experiment manifest remains the six-prompt
  v20 SHA `77a9b570…`, v21 contract `4be899bf…`, target
  `3895b6ea…`, drafter `18a380ef…`, seed 42, cache off, and `n=1`.
- A fresh `/workspace` preseed build was then completed successfully; no model
  load, GPU inference, or numeric result is available yet. Treat all
  exactness/timing fields as pending.

### Build-only success (2026-08-22)

The preseed build completed successfully with the exact old UI tree: 140 files,
12,951,994 bytes, manifest SHA `e811817ad5b5f7b8280e9a414816af0764beda9465fcf8c0a882cbc66a6ba803`.
Fresh `llama-server` SHA is `b17850bc59b9b38e003f166bffe66849db572fd5050c4fa4a36abafea6dd5e79`;
Build ID `22ecf3ead16a84cc758ca779e8ef1669d301112b`; implementation/common/
llama hashes are `605d798e…`/`19fdf005…`/`fdb0bc83…`. Configure/build used
CUDA 86, server ON, UI OFF, prebuilt UI OFF, with no network lines. No model,
server, GPU inference, exactness, or timing run has started; exactness remains
pending.

### Interpretation / hypotheses

If all six outputs match, the branch is an exactness-preserving `n=1`
diagnostic and timing can be compared descriptively. A mismatch terminalizes
the candidate for this screen. No result supports `n>1`, losslessness, or a
general speed claim.

## Decision

- Promotion decision: terminal negative for this exactness-first screen; the
  split-OFF mismatch prevented split-ON launch and invalidates candidate timing.
- What this does not establish: Arm-B fidelity, general acceptance, quality,
  exactness beyond the declared six-prompt gate, or general serving speed.

## Artifacts and receipts

Receipts will be stored under
`receipts/EXP-20260822-021-qwen-v22-split-flash-n1/` with source/build hashes,
literal commands, per-arm outputs, evaluator results, and final cleanup state.

## Failures and amendments

2026-08-22: Initial source candidate, build hard stops, build-only success, and
split-OFF exactness mismatch recorded; split-ON was not launched.

### Provenance closure

Literal configure/build argv is preserved in
`receipts/EXP-20260822-021-qwen-v22-split-flash-n1/preseed-argv-receipt.md`.
The preseed copied the exact old `tools/ui/dist`, configured CUDA 86 with UI
and prebuilt-UI OFF, and built the named `llama-server` target with `-j2`;
configure/build both returned 0. No cwd or task-specific environment is
inferred where the receipt marks it UNKNOWN. This closes build provenance only;
the six-prompt exactness run remains pending.

### Exactness-first result (terminal negative)

The target-only oracle was stable on all six public prompts: 227 completion
tokens/run, timed `16.0559131652`, `16.0593077735`, `16.0534317693` tok/s.
Same-build Q4 n=1 split-OFF reached 104/118 accepted and timed
`18.1364859777`, `17.6286615605`, `17.8508739874` tok/s, but failed the
exactness gate on `code_python_debug`: target SHA
`0f76b6ae57040714633aa638719e0c2a9b3c594cc2ff0ce4bafc75cabee56a6c` versus Q4
SHA `1d5020bfedee4bbc2c878d7d3805bf76ccd2e85dfc90817c4b3422af75122646`, both
64 tokens with `length` finish. Split-ON was not launched by the hard stop;
there is no candidate timing, acceptance, or general speed claim. The raw
28-file receipt set, summary, cleanup, terminal, and `SHA256SUMS.txt` remain
under `receipts/EXP-20260822-021-qwen-v22-split-flash-n1/`.

### Read-only mismatch reconciliation

Receipt `mismatch-reconciliation-20260822.json` (SHA `f193e04c…`; note
`be0970f9…`) confirms target/Q4 share contract `a69610f9…`, prompt manifest
`77a9b570…`, target model, same server, nmax=1, block size 8, n_extract=5,
cache_n=0, and prompt-cache off. Only `code_python_debug` differs, at
character 194: target has backtick-wrapped `-1`, Q4 omits backticks; both are
64 tokens/`length`. Five prompts match. Token index and exact seed/sampler/
client argv remain UNKNOWN.

Historical v22 6/6 is stale for this oracle: prompt-token total 747 versus
current 531 (code-python 169 versus 133), indicating rendering/runtime drift;
cause UNKNOWN. Split-ON remains unrun and terminal; no rerun or retuning is
authorized.
