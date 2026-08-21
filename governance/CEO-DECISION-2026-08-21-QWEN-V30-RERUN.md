# CEO decision — Qwen v30 quantization rerun

Date: 2026-08-21  
Queue item: [EXP-20260821-004-RERUN](../queue/2026-08-21-EXP-004-v30-rerun.md)  
Existing experiment card: [EXP-20260821-004](../experiments/cards/EXP-20260821-004-qwen-v30-quantization.md)

## Decision

**CEO APPROVED — one bounded approximate rerun, exactly as specified below.**

This approval is separate from the still-blocked PLAN-20260821-001
state-localization probe. It does not authorize Arm-B localization, exact or
lossless claims, training, new quantization, or any scope expansion.

## Written lane inputs

| Lane | Written input | CEO finding |
|---|---|---|
| Planner | [`QWEN-V30-RERUN-VERDICT-20260821`](../experiments/critique/QWEN-V30-RERUN-VERDICT-20260821.md) and v30 manifest | **PASS.** Existing artifacts, fixed n=4/64-token/12-prompt contract, one warmup plus three timed repeats, matched target baseline, one GPU/hour, and receipts are specified. |
| Critic | [`QWEN-V30-RERUN-VERDICT-20260821`](../experiments/critique/QWEN-V30-RERUN-VERDICT-20260821.md) | **PASS.** The prior receipt-schema blocker is repaired; exactness remains diagnostic/failed and all hard stops are explicit. |
| Literature | v30 gate review recorded in the CEO action log and QSpec/llama.cpp source mapping | **PASS with caveat.** Export precision is an isolated approximate axis; no exact/lossless/quality/general-speed claim is allowed. |

## Exact approved scope

- Existing target Qwen3.8-27B IQ1_S, SHA-256
  `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`.
- Existing drafter artifacts only: F16
  `8e3edd04ecacd949da675dcdbe0263689fa820ee729e4376137ed816a4b0be31`,
  curve Q4_K_M
  `2a7828cfb7fa3aece704a7df4a36004341ec99ae99ab8bfe6e5262fe28430a63`, and
  curve Q8_0
  `f71a21453e2fc379585045d22ee55c51add979e529882a17cf0ccb9cecf4e4f4`.
- Runtime: llama.cpp DFlash lineage commit
  `5ecbe1ac17ec0484c5b44af0bd580cdc9c428ed4`; binary SHA-256
  `78ccd846f70b6d632eb290c33be0b02f818c91b21fb0c126926c901cca5eb0d6`.
- Evaluator/wrappers: benchmark client SHA-256
  `477b271d3e34616282c3d4c85ea278d67441f1bf0be8dec5a366a7374f9a37a4`,
  finalizer `84101a5f11f44ccee00f75cf594eb7b42925caf408507cd6cafa8c7a11f79a60`,
  validation wrapper `ea27524aad12b198f6a19c8c861c8a267542bac4e1b0f611a81c5f3f68037590`,
  target-only wrapper `6fd5a465aa356434bf919450f6684b79eaf1d7d115f70a31e14ab88bc579ebb3`.
- Prompt manifest SHA-256 `30668abcb12a25a8c6b69f8f54bcf5f8942df3b800c996a52ba28d4e9af1f914`;
  contract SHA-256 `42cf6a40304e278c8c4f4a01ecd612191cef55d22ae6d182b277a134bf416c39`.
- Fixed contract: 12 prompts, n=4, max 64 completion tokens, context 4096,
  seed 42, temperature 0, top-k 1, no prompt cache, parallel 1.
- Arms: one warmup plus three timed repetitions per F16/Q4/Q8, plus one
  matched target-only baseline. Existing artifacts only; no quantization command.
- Resource boundary: one remote RTX 3060 slot, one process, maximum one hour.

## Metrics and receipt

Write compact receipts only under
`receipts/EXP-20260821-004-v30-rerun-20260821/` using the pre-registered
[schema](../receipts/EXP-20260821-004-v30-rerun-20260821/README.md). Report
acceptance, target-content matches, output-token counts, timing, and VRAM in
separate rows. Exactness is diagnostic/failed only; do not claim losslessness,
general exactness, quality, or general speed improvement.

## Hard stops

Stop before comparison on any identity/artifact mismatch, target-only baseline
mismatch, missing output accounting, unexpected resource/process contention,
held-out access, scope expansion, or cleanup/final-device failure. Record the
partial receipt and terminal disposition; do not improvise or retry.

## Prohibitions

No Arm-B state localization, PLAN-001 evaluator work, training, new
quantization, source/runtime patches, downloads, installs, publication,
spending, sealed-holdout access, or external actions. GPU execution remains
single-threaded. Any change requires a new planner packet, critic review, and
CEO decision; anything outside the delegated boundary is
`SEPARATE USER APPROVAL REQUIRED`.

## Terminal disposition — 2026-08-21

The executor completed the approved sequence and cleanup. The post-run review
is [`QWEN-V30-RERUN-POSTRUN-CRITIQUE-20260821.md`](../experiments/critique/QWEN-V30-RERUN-POSTRUN-CRITIQUE-20260821.md);
the literature synthesis is [`HANDOFF-20260821-V30-RESULT.md`](../literature/HANDOFF-20260821-V30-RESULT.md).

Observed means over three timed repetitions were target-only 17.375777
tok/s, F16 11.530593, Q4_K_M 11.574492, and Q8_0 11.557184. Each arm emitted
625 completion tokens per repetition. The drafter forms had 7/12 target-content
matches each; acceptance was 102/1971 (F16), 103/1967 (Q4_K_M), and 102/1971
(Q8_0). Peak VRAM was 8085, 8015, and 8033 MiB, versus 6365 MiB target-only.
Exactness is diagnostic/failed. This is a completed-negative approximate
serving-form screen: no lossless, general quality, exactness, or general speed
claim is supported, and v30 export-format repetition is not recommended.

Receipt paths and hashes:

- [summary.json](../receipts/EXP-20260821-004-v30-rerun-20260821/summary.json), SHA-256 `9cbed376175ecec5b76b77bc45c0cc53f3df3aca1af40ff87e22b467141765e4`;
- [cleanup.json](../receipts/EXP-20260821-004-v30-rerun-20260821/cleanup.json), SHA-256 `16082ca64a4ac0c1a3fd423471f15fcd7bbbc80dc0eb04386eeb8df0274be188`;
- [terminal.json](../receipts/EXP-20260821-004-v30-rerun-20260821/terminal.json), SHA-256 `3e458c1476fd3a7376dbac270999926294a3cf43b67496350e3191b3de69db27`, with the preserved launch-error receipt;
- final state: RTX 3060 idle at 1 MiB used / 0% utilization, no task-owned process.

The initial malformed Q8 path is preserved as a pre-execution error and did
not affect any result artifact. The next CEO action is documentation and
repair of the blocked PLAN-001 evaluator/layout contract; no new GPU run is
approved by this terminal disposition.
