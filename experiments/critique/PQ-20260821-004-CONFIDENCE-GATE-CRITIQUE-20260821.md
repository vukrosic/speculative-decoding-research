---
id: PQ-20260821-004-CONFIDENCE-GATE-CRITIQUE-20260821
date: 2026-08-21
status: repair-needed
verdict: BLOCK
approval: NEEDS CEO APPROVAL
issue_labels: [PROV, BASELINE, CONF, METRIC, RUNTIME]
---

# CEO-readiness critique — PQ-20260821-004

**BLOCK — not ready for CEO approval.** Current v30 receipts provide a usable
starting baseline: target-only 17.3758 ± 0.0667 tok/s and fixed Q8_0 n=4
11.5572 ± 0.0141 tok/s, with 102/1,971 accepted/proposed and 7/12
target-content matches per repetition; hashes, runtime/evaluator, prompts,
flags, output counts, and cleanup are pinned in the v30 receipt set. The
proposal keeps the causal scope to scheduling policy and correctly forbids
held-out access, training, quantization changes, and exactness/speed inference
from acceptance. However, the adaptive policy is not executable or
pre-registered: it gives no confidence statistic/source, threshold value or
calibration rule, per-prefix n-selection pseudocode (including EOS/ties and
the n=1 path), or accounting for confidence-computation and extra scheduler
overhead. It also has no named receipt schema for per-prompt chosen n,
confidence values, target-call/correction counts, output-token totals, repeated
timings/VRAM, and terminal cleanup. The baseline row must reference the fresh
v30 receipt hash rather than only the historical 11.550 value. **Smallest
repair:** create one immutable PQ-004 card/receipt contract that freezes the
confidence statistic, threshold/calibration split, deterministic n-selection
policy, current v30 baseline receipt hash, overhead-inclusive timing schema,
and cleanup/terminal fields; until then the plan remains blocked and no run is
authorized.
