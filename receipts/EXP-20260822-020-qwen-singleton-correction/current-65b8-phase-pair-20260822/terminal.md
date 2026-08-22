# EXP020 matched current-65b8 phase pair terminal

The task-local current-library runner/parser derivative was staged and hashed before model load. Its runner SHA is `1adb22e41338f57e11910505e149d6b73d50e3b5a33e4c5e76688a6455601843`; parser SHA is `610f8466e64e7b9a1d30bbd07796485898ced38f5598be1b22109ca5c57dbc1b`. The server's RUNPATH and `ldd` resolution point to the task-owned current `libllama-common.so.0` symlink resolving to the exact `65b8a862...` `.so.0.1.2` object. No `d07ed8b4...` or `1bbaf7b5...` library was used.

The literal remote launcher was:

```text
ssh -p 35738 root@125.240.239.50 "cd /workspace/smollm-eagle3-prototype && bash /dev/shm/pq020-matched-current-phase-20260822T1430Z/pq020_run_current_65b8_phase_pair.sh /dev/shm/pq020-matched-current-phase-20260822T1430Z"
```

Both arms used cwd `/workspace/smollm-eagle3-prototype`, `CUDA_VISIBLE_DEVICES=0`, `LLAMA_TRACE=1`, `PQ020_TRACE=1`, and `LD_LIBRARY_PATH=/workspace/smollm-eagle3-prototype/experiments/pq020-instrumented-runtime-20260822T0546Z/build/bin`. `PQ020_LOW_MARGIN_TOP2`, `LLAMA_V22_SPLIT_FLASH_QUERIES`, `LLAMA_V22_SPLIT_FLASH_ACTIVE`, and `LLAMA_V22_SPLIT_FLASH` were explicitly unset in the child environment. The complete literal server/client argv arrays are in `summary.json`; the raw shell renderings are `raw/target-command.txt` and `raw/q4-command.txt`. Target server argv used port 8100 and the target-only flags. Q4 server argv used the same target flags on port 8101 plus `-md ...Qwen3.8-27B-DFlash2-Q4_K_M.gguf --spec-type draft-dflash --spec-draft-n-max 1 --spec-draft-ngl all`. Each arm used benchmark client repetition 0 warmup then repetition 1 diagnostic, with the pinned one-row prompt, contract, `--wait-seconds 300`, and cache-off.

Target-only ran first with one warmup and one diagnostic request. The fresh target oracle passed assistant hash `0f76b6ae...`, 64 completion tokens, and `length`. Q4 n=1 then ran with one warmup and one diagnostic request on the same current runtime, with no low-margin or split-flash overrides. Q4 is not an exactness oracle here: its diagnostic output hash was `1d5020bf...` (not the target hash), 64 tokens, `length`. The diagnostic client JSON reports 35 proposed and 28 accepted draft tokens (`cache_n=0`); the parser's 70 proposed, 56 accepted, 14 rollback, and 126 accepted-vector rows are log-wide totals across warmup plus diagnostic. No acceptance or speed claim is made.

The Q4 server log contains the expected startup memory-fitting diagnostic (`dflash requires ctx_other to be set` / `failed to measure draft model memory`), immediately followed by the runtime's explicit note that this warning is normal during memory fitting. Model load, both requests, parser gates, and cleanup completed.

The parser emitted versioned `pq020.phase.v1` JSON for both arms, timestamped in milliseconds from llama.cpp `H.MM.SSS.uuu` log prefixes. Q4's phase intervals and marker counts are log-wide over warmup plus diagnostic; target-only has no verifier markers and records those phases as unknown/not-applicable rather than zero. Unknown phases are not imputed as zero. This is descriptive phase evidence only; it does not support speed, exactness, acceptance, verifier, losslessness, or general claims.

Both servers were stopped sequentially. Final state: RTX 3060 at 1 MiB used and 0% utilization, with no task process. Raw logs, client JSON, commands, loader receipts, parser outputs, and cleanup state are preserved under `raw/`.
