# Literature verdict — PQ-002 provenance inventory

Date: 2026-08-21  
Receipt: `v27-v23b-v23f-provenance-inventory-20260821.json`  
Verdict: **PASS as a provenance-complete bounded design; secondary to PLAN-001
for information value**

## Observed provenance closure

The inventory pins the v23f parent checkpoint, v27 step-4000 checkpoint/export,
target layer 62, v23b feature-group manifest and response hashes, v23f token
label manifest/alignment gates, trainer/wrapper file hashes, seed/optimizer
flags, benchmark contract, evaluator client/finalizer, target-only baseline,
and v27 n=4 baseline (103/1967). Held-out windows remain sealed.

Remaining caveats are explicit rather than hidden: trainer files have hashes
but no single source commit, the parent checkpoint lacks AdamW/sampler state,
and the feature directory has no aggregate directory hash. These do not erase
the lineage, but every future receipt must carry the file/manifest hashes and
state-reset interpretation.

## Claim-to-test mapping

The literature supports the proposed separation of metrics: Chen et al.
([arXiv:2302.01318](https://arxiv.org/abs/2302.01318)) and Yin et al.
([arXiv:2411.00841](https://arxiv.org/abs/2411.00841)) motivate measuring
autoregressive acceptance and prefix survival rather than treating CE as a
proxy; DFlash's target-feature/block dependence ([paper](https://arxiv.org/abs/2602.06036),
[code](https://github.com/z-lab/dflash)) requires freezing layer, feature
manifest, shape, and runtime. Therefore the objective formula remains a
hypothesis to test against v27, not a source-backed improvement claim.

## Actionability versus PLAN-001

PQ-002 is now actionable as a *bounded training design* after a fresh approval:
one objective change, frozen lineage/manifests, finite-fit gate, validation
checkpoint selection, and separate acceptance/quality/exactness/speed rows.
It is not the highest-information next Qwen action while PLAN-001's
singleton/block verifier-state mismatch remains unresolved; objective gains
could be masked by the same runtime boundary. Prefer PLAN-001 localization
first, or explicitly defer it before starting PQ-002.

No execution, training, held-out access, or promotion is authorized by this
verdict. Preserve the optimizer/sampler reset caveat, do not infer acceptance
from fit metrics, and keep any candidate validation-only until the correctness
gate passes.
