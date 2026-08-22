# Repaired-wrapper CPU identity preflight

Prepared only; nothing was launched. The proposed check binds b178 `llama-server` SHA `b17850bc…`, Build ID `22ecf3e…`, exact preseed RUNPATH and resolved library hashes, tracer SHA `6d2349a…`, target `3895b6e…`, manifest `77a9b570…`, and an explicitly frozen contract. The preserved Stage0 receipt does not bind a contract path; the packet records v21 `4be899bf…` as the planned contract and v22 `a69610f9…` as an alternate that must not be mixed.

The literal CPU-only argv uses one server, `--n-gpu-layers 0`, context 4096, parallel 1, and `CUDA_VISIBLE_DEVICES=`. It permits exactly six `/apply-template` calls and six `/tokenize` calls in frozen order, with no `/completion`. Every rendered byte/hash, token ID/prefix hash, piece list, and count must equal Stage0 (169/122/115/111/96/134; total 747) before the server is cleaned up.

Any identity, contract, endpoint, row, resource, or cleanup mismatch hard-stops. Execution remains pending CEO approval.
