# Raw-contract audit correction

Every final-run JSON contains a pre-rendered prompt in its request and `return_tokens=true`; responses are benchmark/completion generations. No `/apply-template`, `/tokenize`, or `trace_one_prompt_v22.py` evidence appears in the copied logs. The packet therefore uses the benchmark path, not the six-row 747-token capture path.

Rendered prompt hashes are identical between target and Q4 for each ID, but prompt counts are 133, 86, 79, 75, 60, and 98 (531 total). The 747-token capture contract is absent from these requests. Exact file hashes and all six rendered hashes are frozen in the JSON receipt.

Correction: these outputs remain valid for the older 531-token tuple only. They cannot be used to claim target-only or split-OFF exactness under the 747-token tracer. No rerun or GPU work was performed.
