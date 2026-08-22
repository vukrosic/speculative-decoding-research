# Authoritative 747-token Q4 reconciliation

The previous `q4-first-row-reconciliation` receipt and note are superseded as **531-token contaminated**. The authoritative replacement is `q4-off-final-raw/q4-off-r0.json`, which passed one Stage0 row before completion: rendered hash `a83e3752…`, 169 prompt tokens, cache_n=0, and the frozen b178/target/drafter/manifest/contract/tracer identities.

Against the stable target oracle (`a382e0c0…`), Q4 output `6400f118…` is 64 tokens and finishes by limit. Q4 proposed and accepted 31/31. The first generated divergence is token 2 (zero-based): target token 760 versus Q4 token 248069. Q4’s content begins `</think>\\n\\n</think>`, a duplicate closing-think sequence; target begins `</think>\\n\\nThe function…`.

This is a valid 747-token exactness failure and the arm hard-stopped before timed repetitions. The precise rollback/mask/verifier cause is UNKNOWN; no normalization or split-ON run is admissible.
