# EXP021 target-only final terminal

The authorized target-only oracle completed on the remote RTX 3060 using the pinned `b17850bc` server and target model. The literal server argv was:

`CUDA_VISIBLE_DEVICES=0 llama-server -m experiments/qwen38-27b-iq1s-spec-v20-20260820/models/unsloth-qwen38-27b-4ca72078/Qwen3.8-27B-UD-IQ1_S.gguf --host 127.0.0.1 --port 8094 --ctx-size 4096 --parallel 1 --n-gpu-layers all --no-context-shift --metrics --perf -lv 3`

For each of six manifest rows and repetitions 0–3, the client asserted `/apply-template` rendered bytes/hash, `/tokenize` IDs/pieces/count, and contract payload hashes against Stage0 before issuing `/completion`. All 24 row assertions passed. Outputs were byte-identical per row across all four repetitions (6/6 stability). The target arm only was run; Q4, split-OFF, and split-ON were not launched. Raw JSON, server log, and terminal resource snapshots are in `target-only-final-raw/`.

The final GPU snapshot is RTX 3060, 1 MiB used, 0% utilization. The remote server was terminated; no experiment process remains. The `final-procs.txt` snapshot may contain the shell's own `pgrep` line because the inspection pattern matched itself; a fresh remote check showed no `llama-server` or experiment process.
