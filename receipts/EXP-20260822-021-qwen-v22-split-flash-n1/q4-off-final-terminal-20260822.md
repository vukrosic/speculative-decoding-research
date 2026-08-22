# Q4 split-OFF n=1 terminal

The authorized Q4 split-OFF control launched the pinned b178 server with the pinned Q4 drafter, n=1, and `CUDA_VISIBLE_DEVICES=0`. `LLAMA_V22_SPLIT_FLASH_QUERIES` and related active split variables were explicitly unset. The six-row `/apply-template` then `/tokenize` Stage0 contract passed for `code_python_debug` before completion.

The arm hard-stopped during warmup repetition 0 on `code_python_debug`: Q4 output SHA `6400f11885d9e71a331d1946f15b7218cfc1ee81948f0afc06f5db9476a9ee08` differed from the target oracle SHA `a382e0c0a624fe959b44c052f92a30de335240c5865499747f82b90e10775013`. Diagnostic counters were 31 draft proposed / 31 accepted, 64 predicted tokens, finish `limit`. No timed repetitions, split-ON arm, or speed claim was performed. The server was then terminated and the RTX 3060 returned to 1 MiB used / 0% utilization with no experiment process.
