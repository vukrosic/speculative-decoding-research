# EXP021 launch-contract enforcement audit

The final terminal note and summary claim `/apply-template` → `/completion` and 747 tokens, but the authoritative raw files contain pre-rendered prompts with 531 total tokens and no `/apply-template` or `/tokenize` evidence. Their hashes (`bf39f3f6…`, `f8f27bd8…`) and counts (133, 75) differ from Stage0 xhigh (`a83e3752…`, `27400339…`; 169, 111). The literal executor script/argv was not preserved, so the exact selection mechanism is UNKNOWN; the payload shape is the pinned benchmark-client route.

The receipt defines a fail-closed design: six `/apply-template` calls, six Stage0-flagged `/tokenize` calls, all hash/ID/count assertions and total 747 check must pass before any `/completion` request. Any mismatch or wrong route hard-stops with zero generation. The design is documentation-only; no wrapper was written or executed.

Disposition: invalidate the final packet as 747 evidence; preserve its 531-path observations only. Split-ON and speed claims remain prohibited.
