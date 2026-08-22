# Research knowledge base

This is the human entry point to the repository's accumulated speculative-
decoding knowledge. It is intentionally easy to browse: start with the latest
ledger, then follow links to the experiment card, receipt, critique, and
literature handoff for any result.

## Latest ledger

- [Experiment wiki — Qwen](EXPERIMENT-WIKI.md)
- [Experiment wiki update receipt](../receipts/PQ-20260821-019-cache-on-n1-20260822/experiment-wiki-update-20260822.json)
- [Qwen research ledger — 2026-08-22](QWEN-RESEARCH-LEDGER-2026-08-22.md)
- [Qwen research ledger — 2026-08-21](QWEN-RESEARCH-LEDGER-2026-08-21.md)
- [Daily lab journal — 2026-08-22](../daily/2026-08-22.md)
- [Daily lab journal](../daily/2026-08-21.md)
- [CEO action log — 2026-08-22](../governance/CEO-ACTION-LOG-2026-08-22.md)
- [CEO action log](../governance/CEO-ACTION-LOG-2026-08-21.md)
- [Current state](../CURRENT-STATE.md)

## Find evidence by question

| Question | Start here | Then inspect |
|---|---|---|
| Is speculative decoding faster on this Qwen? | [Qwen ledger](QWEN-RESEARCH-LEDGER-2026-08-21.md) | [fixed-n card](../experiments/cards/EXP-20260821-010-qwen-fixed-n-runtime.md), [runtime receipts](../receipts/PQ-20260821-006-fixed-n-runtime-20260821/) |
| Did more drafter data help? | [PQ-007 ledger section](QWEN-RESEARCH-LEDGER-2026-08-21.md#pq-007-data-scale) | [fit receipt](../receipts/PQ-20260821-007-data-scale-100k/pq007-fit-12452-v26repair.json), [negative acceptance receipt](../receipts/PQ-20260821-007-data-scale-100k/pq007-n4-screen.json) |
| Did the prefix-survival objective help? | [PQ-002 ledger section](QWEN-RESEARCH-LEDGER-2026-08-21.md#pq-002-prefix-survival-objective) | [objective card](../experiments/cards/EXP-20260821-009-qwen-prefix-objective.md), [acceptance screen](../receipts/PQ-20260821-002-prefix-objective-20260821/acceptance-screen/) |
| Why might acceptance or runtime be failing? | [PQ-008 ledger section](QWEN-RESEARCH-LEDGER-2026-08-21.md#pq-008-verifierstate-localization) | [diagnostic packet](../experiments/planning/PQ-20260821-008-VERIFIER-STATE-LOCALIZATION-PACKET-20260821.md), [metadata reconciliation](../receipts/PLAN-20260821-001/preserved-metadata-reconciliation-20260821.json) |
| Does Q4 vs Q8 drafter precision make n=1 faster? | [EXP-011 ledger section](QWEN-RESEARCH-LEDGER-2026-08-21.md#exp-011-drafter-precision-at-n1) | [precision card](../experiments/cards/EXP-20260821-011-qwen-drafter-precision-n1.md), [runtime receipts](../receipts/PQ-20260821-009-q4-q8-n1-precision-speed/) |
| Which counters explain the Q8 n=1 wall gap? | [PQ-012 ledger section](QWEN-RESEARCH-LEDGER-2026-08-21.md#pq-012-read-only-runtime-counter-analysis) | [analysis receipt](../receipts/PQ-20260821-012-runtime-overhead-decomposition-n1-20260821/analysis.json), [runtime packet](../experiments/planning/PQ-20260821-012-RUNTIME-OVERHEAD-DECOMPOSITION-N1-20260821.md) |
| Could a gate use speculation only on prompts where it pays? | [PQ-013 hypothesis](PQ-013-PROMPT-GATE-HYPOTHESIS-2026-08-21.md) | [read-only receipt](../receipts/PQ-20260821-013-prompt-gate-readonly-20260821.json), [mixed-mode inventory](../experiments/planning/runtime-qwen-mixed-mode-gate-20260821.md) |
| Are prompt-cache semantics enough for a speculative speed experiment? | [PQ-015 recovery options](../experiments/planning/PQ-20260821-015-RECOVERY-OPTIONS-20260821.md) | [cache preflight](../receipts/PQ-20260821-015-cache-reuse/pq015-cache-semantics-preflight-20260821.json), [runtime inventory](../experiments/planning/runtime-qwen-public-gate-cache-control-inventory-20260821.md) |
| Why was the cache-on screen initially blocked? | [PQ-019 decision review](../experiments/planning/PQ-20260821-019-CACHE-ON-N1-DECISION-REVIEW-20260822.md) | [command inventory](../experiments/planning/PQ-20260821-019-CACHE-ON-N1-COMMAND-INVENTORY-20260822.md), [superseding preflight](../receipts/PQ-20260821-019-cache-on-n1-20260822/pq019-q4-route-superseding-preflight-20260822.json) |
| What is the corrected PQ-019 identity/workload? | [canonical preflight note](../receipts/PQ-20260821-019-cache-on-n1-20260822/canonical-contract-workload-preflight.md) | [machine receipt](../receipts/PQ-20260821-019-cache-on-n1-20260822/canonical-contract-workload-preflight.json), [derived contracts](../receipts/PQ-20260821-019-cache-on-n1-20260822/) |
| What did PQ-019 actually show? | [post-run analysis](../receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.md) | [raw arm receipts](../receipts/PQ-20260821-019-cache-on-n1-20260822/raw-remote/), [post-run critique](../experiments/critique/PQ-20260821-019-POSTRUN-CRITIQUE-20260822.md) |
| What is the durable PQ-019 experiment card? | [cache-reuse card](../experiments/cards/EXP-20260822-019-qwen-prompt-cache-reuse.md) | [post-run machine receipt](../receipts/PQ-20260821-019-cache-on-n1-20260822/postrun-analysis.json), [hash ledger](../receipts/PQ-20260821-019-cache-on-n1-20260822/POSTRUN-SHA256SUMS.txt) |
| What is the current promising Qwen lead? | [EXP-020 singleton-correction card](../experiments/cards/EXP-20260822-020-qwen-singleton-correction.md) | [trace contract](../receipts/EXP-20260822-020-qwen-singleton-correction/benchmark-contract-q4-n1-code-python-trace.json), [paper-material claims](../paper-material/claims.md) |
| Where did EXP-020 first diverge, and what was falsified? | [token-divergence analysis](../receipts/EXP-20260822-020-qwen-singleton-correction/token-divergence-analysis.md) | [n_rs causal summary](../receipts/EXP-20260822-020-qwen-singleton-correction/n-rs-axis-r1/summary.json), [claim ledger](../paper-material/claims.md#c003-recurrent-snapshot-countlayout-is-not-the-sole-cause) |
| What did the margin-gated EXP-020 candidate achieve? | [corrected speed-gate summary](../receipts/EXP-20260822-020-qwen-singleton-correction/corrected-speed-gate-r1/summary.json) | [margin safety finding](../receipts/EXP-20260822-020-qwen-singleton-correction/sampler-margin-six-r1/findings.md), [claim ledger](../paper-material/claims.md#c004-margin-gated-correction-recovers-the-frozen-six-prompt-hashes) |
| Did the calibrated policy generalize to independent v23 prompts? | [independent-v23 analysis](../experiments/analysis/PQ-20260822-020-INDEPENDENT-V23-SCREEN.md) | [raw summary](../receipts/EXP-20260822-020-qwen-singleton-correction/independent-v23-screen-r1/raw-remote/summary.json), [claim ledger](../paper-material/claims.md#c006-independent-v23-screen-falsifies-generalization) |
| What blocks the next true Qwen speculative-decoding run? | [post-PQ019 executable audit](../experiments/planning/PQ-20260822-NEXT-EXECUTABLE-AUDIT.md) | [PLAN-001 reconciliation](../receipts/PLAN-20260821-001/pq008-local-output-evaluator-reconciliation-20260822.json), [orchestration receipt](../receipts/PQ-20260821-019-cache-on-n1-20260822/post-pq019-orchestration-receipt.json), [continuation hash manifest](../receipts/PQ-20260821-019-cache-on-n1-20260822/CONTINUATION-DOCUMENTATION-SHA256SUMS.txt) |
| What exact input would reopen Qwen GPU work? | [PQ-016 intake](../experiments/planning/PQ-20260821-016-ARTIFACT-RECOVERY-INTAKE-20260821.md) | [machine intake](../receipts/PQ-20260821-016-artifact-recovery-intake-20260821.json) |
| What is the current remote/GPU state? | [PQ-017 live preflight](../receipts/PQ-20260821-017-live-preflight-20260821.md) | [machine receipt](../receipts/PQ-20260821-017-live-preflight-20260821.json) |
| Are the research navigation links intact? | [PQ-018 link audit](../receipts/PQ-20260821-018-doc-link-audit-20260821.md) | [machine receipt](../receipts/PQ-20260821-018-doc-link-audit-20260821.json) |
| What failed or was stopped? | [Failure index](../failures/INDEX.md) | Linked receipts and dated amendments |
| What does the literature say? | [Literature index](../literature/index.md) | [source notes](../literature/notes/) and dated handoffs |

## Repository map

- `experiments/cards/` — what was tested or proposed.
- `experiments/planning/` — bounded next experiments and hypotheses.
- `experiments/critique/` — adversarial reviews and stop conditions.
- `receipts/` — machine-readable identities, metrics, hashes, and cleanup.
- `results/` — cross-experiment summaries.
- `failures/` — negative results, blocked attempts, and false leads.
- `literature/` — source notes, evidence boundaries, and research handoffs.
- `daily/` — chronological lab notebook.
- `governance/` — action log and historical decisions.

## Documentation habit

For every meaningful action, append a dated note with:

1. what was observed;
2. what was changed, if anything;
3. the exact artifact or receipt path and hash;
4. what remains unknown;
5. the next falsifiable question.

Run results belong in a receipt and a card; the ledger summarizes them without
replacing the raw evidence. Negative results are first-class knowledge and are
never silently overwritten.

Last updated: 2026-08-22.
