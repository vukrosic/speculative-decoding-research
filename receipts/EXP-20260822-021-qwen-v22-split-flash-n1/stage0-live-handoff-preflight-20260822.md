# Stage0 live handoff preflight

Stage0 is validated as a six-of-six CPU equivalence gate. Candidate packet `8f74cf64…` and receipt `2e1d50b5…` agree with the capture-r2 manifest, target, row order, rendered bytes/hashes, token IDs/pieces, payload hashes, and exact tokenize flags. The six rows total 747 prompt tokens.

The workload identities are target `3895b6e…`, Q4 drafter `18a380ef…`, manifest `77a9b570…`. Two contract hashes exist in preserved material: v22 `a69610f9…` and planner v21 `4be899bf…`; Stage0 does not bind a contract path, so the executor must freeze one explicitly before target-only. Mixing them is a hard stop.

Live read-only SSH at 2026-08-22T11:19:33Z found RTX 3060 idle (1 MiB, 0%, no compute apps), no stale llama-server/client process, and 1.5 GB workspace free. Target and b178 hashes match the frozen receipts. b178 resolved library hashes are preserved in the JSON. The handoff packet prefix `96820b66…` is a queue reference only; its full artifact is not present locally.

Disposition: ready for the separately authorized sequence target-only → same-build split-OFF; split-ON is conditional on six-of-six exactness. This preflight itself launched no model, used no GPU, and mutated nothing.
