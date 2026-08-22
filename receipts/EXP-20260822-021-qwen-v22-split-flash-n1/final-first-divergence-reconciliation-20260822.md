# Final first-divergence reconciliation

The copied final raw receipts do not run under the required 747-token tracer contract. Every target and split-OFF request has prompt totals 133/86/79/75/60/98 (531 total), although the six rendered prompt hashes are equal between modes. This is the older 531-token packet and must not be treated as the 747-token exactness gate.

At this 531-token tuple, four rows are byte/token exact between target-only and split-OFF: `code_rust_parser` (1 token, EOS), `math_modular` (64, limit), `technical_explain` (1, EOS), and `structured_extract` (33, EOS). `code_python_debug` diverges at zero-based generated token 50: target 1049 versus split-OFF 1510; both produce 64 tokens and finish by limit. `logic_schedule` diverges at token 37: target 159029 versus split-OFF 92217; both produce 64 tokens and finish by limit. Split-OFF counters are draft 33/30 and 35/27 respectively.

There is no repeated target-only run in this copied packet, so “six stable” can only mean six preserved single-run baselines, not demonstrated repeat stability. The exactness gate is failed/blocked: no split-ON or speed interpretation is admissible, and a fresh run would need to bind the 747-token capture rows explicitly.
