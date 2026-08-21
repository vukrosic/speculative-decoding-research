# Cross-agent research CEO synthesis

Date: 2026-08-21  
Mode: read-only evidence reconciliation and proposal ranking  
Execution status: no run, GPU action, download, install, external message, or
approval performed

This synthesis reads the literature map and synthesis, the planner queue, the
critic review, the latest SmolLM capacity cards and receipts, and the Qwen
v27–v31 cards. It does not change those source records.

## Executive decision

**Observed:** The strongest local pattern is not “more drafter capacity wins.”
On the guarded SmolLM fixed-90 screen, 2, 3, and 5 layers all reached 7.1566%
draft-token acceptance, while the 1-layer draft was fastest. Throughput fell
by 2.39%, 6.32%, and 13.51% for 2, 3, and 5 layers respectively in the
matched receipts. The 35.40M capacity ablation improved teacher-forced metrics
but fell to 6.8334% acceptance and has no serving receipt.

**Observed:** On Qwen, the v27 n=4 validation point is 5.175% acceptance and
11.476 tok/s versus 17.592 tok/s target-only; v28 smaller capacity, v29
early-position-only training, and v31 block-shaped feature continuation did
not improve the acceptance screen. v30 Q8_0 changed the approximate screen by
only +0.65% versus F16. The published path reported 52.58% approximate
acceptance and +23.86% approximate throughput, but strict greedy identity
failed on 4/6 prompts.

**Interpretation / hypothesis:** The highest-information branch is verifier
and target-state fidelity, followed by a component-level serving break-even
diagnosis. A contiguous-prefix objective is plausible but should not be tried
until its selection protocol is repaired. A paired state-consistency objective
is a later, high-cost discriminator. Another blind depth sweep is low-value.

**Recommendation:** Use the ranked portfolio as a reconciliation of the
existing entries in `queue/INDEX.md` and
`experiments/planning/EXPERIMENT-QUEUE.md`; it does not create new queue items.
Every bounded executable proposal is `NEEDS CEO APPROVAL`; actions outside the
delegated boundary are `SEPARATE USER APPROVAL REQUIRED`. Queue state is not
consent.

## Evidence reconciliation

### Acceptance versus end-to-end speed

**Observed:** The SmolLM capacity branch isolates the systems trade-off better
than a raw acceptance table:

| Drafter | Parameters | Acceptance | End-to-end speed | Exact guard |
|---|---:|---:|---:|---|
| 1 layer | 6.52M | 6.0045% | 14.1751–14.4526 tok/s across matched receipts | 180/180 |
| 2 layers | 10.13M | 7.1566% | 13.8359 tok/s | 180/180 |
| 3 layers | 13.74M | 7.1566% | 13.5385 tok/s | 180/180 |
| 5 layers | 20.96M | 7.1566% | 12.4785 tok/s | 180/180 |

The receipt-level baseline timings vary slightly between runs, but every
capacity comparison makes the same directional observation: the extra draft
compute and memory cost more than the extra accepted tokens on this runtime.
Acceptance, accepted tokens per cycle, and exact guarded output identity are
therefore not interchangeable with complete serving speed.

**Hypothesis:** target verification, singleton exact-guard work, launch and
synchronization overhead, and cache movement may dominate the marginal draft
cost. The cards do not yet contain a component timing breakdown, so attribution
remains unknown.

### Drafter capacity

**Observed:** SmolLM 35.40M versus 10.13M improved validation loss/accuracy but
reduced fixed-slice acceptance from 7.1566% to 6.8334%. The later 2/3/5-layer
comparisons tied at 7.1566% acceptance, with increasingly worse throughput.
Qwen v28 reduced parameters from 47.21M to 36.72M and lost validation accuracy,
acceptance, and throughput.

**Interpretation / hypothesis:** There is no demonstrated monotonic capacity
law. The SmolLM 3- and 5-layer candidates were identity-initialized and selected
at epoch 0 after validation loss worsened, so their result is primarily a
bounded capacity/initialization observation, not proof of optimal depth.
Qwen v28 also changes attention heads, KV heads, and FFN width together; it is
not a parameter-count-only ablation.

### Verifier and runtime overhead

**Observed:** The literature notes treat block/tree verification, masks,
target-state capture, rollback, cache layout, scheduler mode, and numerical
precision as part of the method. The Qwen published path is fast only under an
approximate contract and fails the strict identity check. v31 measured material
singleton/block target-state differences (nonzero hidden-state RMSE) even while
anchor/mask checks passed exactly.

**Interpretation / hypothesis:** Qwen's strict divergence may be caused by
shape-dependent target execution, cache/position/mask transaction semantics,
quantized numerical paths, or their interaction with the drafter. v31's
alignment continuation did not improve acceptance, so “alignment alone” is
not an adequate explanation. The first-divergence localizer is more
discriminating than another model sweep.

### Training objective

**Observed:** v27 acceptance was non-monotonic across training steps and had
different best checkpoints for n=4, n=8, and n=16. v29 zeroed loss on positions
5–16 and fell from 5.175% to 4.819% n=4 acceptance. v31 improved validation
teacher-forced accuracy from 42.434% to 43.051% but fell from 5.175% to 4.812%
at n=4. SmolLM capacity likewise improved fit metrics without acceptance gain.

**Interpretation / hypothesis:** Average hard-label CE is a proxy, not the
promotion metric. Later-position supervision may maintain shared block
coherence, and the deployed verifier-state distribution may matter more than
singleton teacher-forced fit. A prefix-survival objective is testable, but only
with a pre-registered formula, same-step control, and a fresh selection policy.

### Exactness

**Observed:** SmolLM 2/3/5-layer comparisons passed the declared fixed-90
target-equivalent guard for all timed calls. This establishes a bounded
contract-scoped result only; the final sealed set was not used. Qwen custom
cards report target-content matches such as 7/12, not formal token identity.
The published Qwen path fails strict identity on 4/6. v31 exact anchor/mask
matches coexist with nonzero hidden-state deltas.

**Interpretation:** Exactness is a property of the complete sampler,
verifier, numerical path, randomness, cache transaction, and rollback. No local
Qwen lossless or exact serving claim is supported. Approximate acceptance and
target-content matches must remain separate fields.

### Evaluation confounds and evidence debt

The critic's findings remain binding:

- compact receipt/provenance closure is incomplete for most Qwen cards and some
  early SmolLM work; missing values remain `unknown`;
- SmolLM 1k test material and any overlapping fixed-90 screen are exposed, not
  a final sealed holdout;
- Qwen 508/152-window validation screens were searched repeatedly across
  checkpoints, lengths, and neighboring epochs, creating selection optimism;
- v28 changes multiple architecture variables, v29 bundles objective and
  continuation path, v31 changes feature shape and corpus size, and the
  SmolLM depth candidates differ in parent/checkpoint history;
- Qwen acceptance denominators and cycle definitions are not proven comparable
  with the published runtime; many Qwen speed rows lack matched warmups,
  repetitions, latency distributions, or a fresh target-only baseline;
- paper and author claims are not local reproduction evidence.

These defects limit promotion and generalization; they do not erase the
bounded observations or justify deleting a negative result.

## Alternative hypotheses ranked by expected information gain

The existing planner queue can map these hypotheses to controlled proposals.
The labels P1–P5 below are synthesis priorities, not new experiment IDs or
authorizations. Costs are rough planning budgets, not commitments.

Mapping to the existing queue: P1 reconciles `PLAN-20260821-001` / `PQ-001`;
P2 is a diagnostic requirement to apply within the existing adaptive-length
`PQ-004` decision, not a standalone new experiment; P3 maps to `PQ-002`; P4
maps to `PQ-005`; and P5 is a promotion gate, not an experiment. The existing
intermediate-depth `PQ-003` is explicitly de-prioritized below.

1. **Verifier/state localization (P1).** The first strict divergence is caused
   by singleton-versus-block target execution or cache/rollback state handling.
   A six-prompt, first-divergence trace can distinguish a runtime/state issue
   from a drafter-quality issue before training more models.
2. **Serving break-even decomposition (P2).** Target verification and runtime
   overhead dominate marginal draft savings. Component timings and call/cycle
   counts can show whether adaptive proposal length is worth testing.
3. **Contiguous-prefix objective (P3).** A prefix-survival/calibration loss can
   improve accepted prefixes where CE and early-only loss failed. This remains
   uncertain and is vulnerable to validation overfitting.
4. **Paired state-consistency training (P4).** Matching singleton and
   deployment-shaped target-state distributions, while holding corpus and
   parent fixed, can improve acceptance where v31's alignment-only continuation
   did not. This is expensive and only meaningful after P1.
5. **Fresh sealed promotion (P5).** The present v27 “incumbent” is optimistic
   until a new frozen split and one-time sealed evaluation are used. This is an
   evidence gate, not a new optimization hypothesis.

## Adversarial debate

### P1 — Qwen verifier/state localization

**Strongest case for:** v31 directly observed shape-dependent target states,
and the published runtime combines high approximate acceptance with strict
identity failure. A first-divergence trace with target-only and cache negative
controls can localize the failure without changing the model.

**Strongest case against:** six prompts cannot establish general exactness;
small IQ1_S numerical deltas may be real but non-causal; the historical
published drafter hash/flags may be missing, making reproduction incomplete.

**Evidence that changes the recommendation:** If target-only singleton/block
replay is identical and cache/rollback controls pass, downgrade verifier
fidelity and move P3 ahead. If a stable first-token state or transaction
divergence appears, stop all objective/capacity work until the contract is
repaired.

### P2 — Component timing and break-even

**Strongest case for:** SmolLM acceptance ties but speed falls with depth, and
Qwen Q8_0 changes speed only marginally. A matched decomposition can explain
the ranking and tell us whether adaptive n or runtime work has positive value.

**Strongest case against:** instrumentation can perturb the path, and a batch-1
diagnosis may not transfer to other concurrency or hardware regimes. It cannot
repair strict exactness by itself.

**Evidence that changes the recommendation:** If draft time is the dominant
term, a narrowly pre-registered adaptive-length screen becomes high-value. If
target verification/cache/synchronization dominates, stop capacity and
quantization sweeps and prioritize runtime shape/transaction work.

### P3 — Acceptance-calibrated prefix objective

**Strongest case for:** v27 has length-specific, non-monotonic optima; v29
shows that simply dropping later-position loss is not enough. A loss that
explicitly scores contiguous-prefix survival tests the actual acceptance
mechanism.

**Strongest case against:** the 508-window screen has been repeatedly searched,
and a differentiable prefix surrogate may overfit or optimize a proxy that
still mismatches quantized deployment states. It costs more GPU time than P1/P2.

**Evidence that changes the recommendation:** Advance only if the formula is
pre-registered, a same-step control is available, prompt-level uncertainty is
reported, and a fresh validation split confirms a meaningful relative gain. If
prefix metrics improve but target-content/exactness or speed do not, preserve
as a negative proxy result and stop the objective branch.

### P4 — Paired singleton/block state consistency

**Strongest case for:** v31 shows a genuine interface discrepancy, while its
alignment-only continuation changed corpus size and parent history. Holding
those fixed and training against paired states would isolate the missing
interface variable.

**Strongest case against:** it is costly, feature extraction is storage-heavy,
and consistency can improve hidden-state fit without improving acceptance, as
v31 already warns. It should not precede a runtime localizer.

**Evidence that changes the recommendation:** Advance only if P1 finds a stable
shape/state discrepancy that survives target-only controls. If P1 localizes a
cache or sampler bug instead, cancel P4; if paired-state fit improves but
prefix acceptance does not, reject the hypothesis.

### P5 — Fresh sealed promotion

**Strongest case for:** it is the only way to turn a repeatedly selected
validation candidate into a defensible held-out claim and exposes selection
optimism.

**Strongest case against:** spending the sealed set before verifier/runtime
fidelity and the primary metric are fixed can waste the one-time test and
produce an uninterpretable negative.

**Evidence that changes the recommendation:** Run only after one candidate,
proposal length, evaluator, and correctness/quality contract are frozen and a
matched target-only receipt exists. If those prerequisites cannot be met,
keep the holdout sealed.

## Capacity branch decision

**Recommendation:** Do not execute the existing planner's intermediate-depth
proposal (`PQ-20260821-003`) next. The 2/3/5-layer tie at 7.1566% acceptance,
with a monotonic throughput penalty relative to 1 layer, makes another blind
depth point low information. Reopen it only if P2 identifies a break-even
regime where draft compute is cheap enough, or if a repaired objective changes
the causal question. This is a prioritization decision, not a claim that depth
can never help.

## Approval boundary and handoff

P0 evidence closure is local documentation only. P1–P5 reconcile existing
proposals; they are not new queue entries. Any bounded execution remains
`NEEDS CEO APPROVAL` until the three written lane inputs are complete and the
CEO records the exact scope. It cannot move to `running` or sealed evaluation
outside the delegated boundary. The next handoff is to the planner for one
repaired existing card, then to the critic. The executor is not engaged by this
synthesis.
