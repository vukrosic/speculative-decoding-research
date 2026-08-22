# EXP-020 independent public-v23 screen

Date: 2026-08-22  
Status: completed-negative; preserve as the no-retuning generalization result.

## Question

Does the task-owned `PQ020_LOW_MARGIN_TOP2=0.08` correction, calibrated on the
original six-prompt public screen, preserve target output projections on a
separate 12-prompt public-v23 validation manifest without threshold changes or
prompt-specific exceptions?

## Frozen tuple

- Prompt manifest: `validation-acceptance-screen-prompts-v23.jsonl`, 12 rows,
  all `split=validation`, SHA-256
  `30668abcb12a25a8c6b69f8f54bcf5f8942df3b800c996a52ba28d4e9af1f914`.
- Source v23 contract: SHA-256
  `42cf6a40304e278c8c4f4a01ecd612191cef55d22ae6d182b277a134bf416c39`.
- Target-only oracle: all 12 frozen output hashes reproduced; 625 completion
  tokens; no held-out data.
- Corrected arm: the same Q4 DFlash n=1 runtime and the frozen `0.08`
  threshold; no retuning, no prompt-specific exceptions.
- Runtime correction source: `sampling.cpp.low-margin-top2`, SHA-256
  `c1b1f6f05561deb597c86a94a3464e4e5e003fd430e51094768873532fc48768`.

## Result

The target oracle gate passed, but the corrected Q4 arm matched only 6 of 12
full output projections. The mismatching IDs were:

`v23-coding-00126`, `v23-explanation-00005`, `v23-explanation-00095`,
`v23-instruction-00160`, `v23-instruction-00316`, and
`v23-reasoning-00170`.

The six matching IDs were `v23-coding-00438`, `v23-math-00019`,
`v23-math-00127`, `v23-reasoning-00080`, `v23-structured-00021`, and
`v23-structured-00201`. Completion-token counts and finish reasons matched
for every row; the mismatches are assistant-output hashes.

No low-margin override fired on this independent set (`override_events=0`).
The corrected Q4 arm nevertheless measured 19.954249 tok/s versus
17.659459 tok/s for target-only, a +12.994677% diagnostic difference. Because
the output projection gate failed, this timing is not a promotion or general
serving-speed claim.

## Interpretation and stop rule

The six-prompt calibration result remains a useful local lead (+12.496004% with
all six hashes matching), but this independent screen does not establish
general losslessness. The calibrated correction is therefore not promoted as a
general policy. Do not retune `0.08`, add prompt-specific exceptions, or claim
quality/exactness from this run. Preserve the positive six-prompt result and
this negative generalization result together.

## Provenance and cleanup

Raw remote files and the machine-readable summary are preserved under
`receipts/EXP-20260822-020-qwen-singleton-correction/independent-v23-screen-r1/raw-remote/`.
Summary SHA-256:
`bb65c097f20f36f063f46ca3f3730a229f4a954decc43705b05b9d0b8dbd97c8`.
The remote terminal state was clean: RTX 3060 at 1 MiB/0%, no task processes,
and `/dev/shm` retained 6,702,350,336 bytes free. No held-out access,
training, export, serving mutation, or deletion occurred.
