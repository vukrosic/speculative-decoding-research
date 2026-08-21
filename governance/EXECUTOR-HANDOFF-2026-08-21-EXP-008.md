# Executor handoff — EXP-20260821-008 capacity branch

Date: 2026-08-21  
Status: `terminal`; no work running  
Source: completed remote DFlash2 capacity experiment handoff  
Research commit: `4b5d399`

This is a reconciliation record for already-completed work. It does not start
a new run, authorize a follow-up, or alter the verifier/state-localization
probe decision.

## Remote state

- Remote project: `/workspace/smollm-eagle3-prototype`
- Remote access route recorded for provenance only:
  `ssh -p 35738 root@125.240.239.50 -L 8080:localhost:8080`
- Final state: RTX 3060 idle, 0% utilization, 1 MiB used; no task is running.
- Shared research repository: `/Users/vukrosic/my-life/open-discovery-workspace/llm-inference-optimization/speculative-decoding-research`

## Observed matched results

Exact-output contract: fixed matched runs; all candidates passed `180/180`
exact target-equivalent outputs.

| Drafter | Parameters | Acceptance | End-to-end speed | Change vs 1-layer |
|---|---:|---:|---:|---:|
| 1 layer | 6.52M | 6.00% | 14.18 tok/s | baseline |
| 2 layers | 10.13M | 7.16% | 13.84 tok/s | -2.39% |
| 3 layers | 13.74M | 7.16% | 13.54 tok/s | -6.32% |
| 5 layers | 20.96M | 7.16% | 12.48 tok/s | -13.51% |

Training selected identity-initialized epoch 0; later epochs overfit validation
loss. Larger drafters slightly improved acceptance but lost complete
end-to-end throughput under the matched contract.

## CEO reconciliation

**Observed:** This closes the current capacity branch as a bounded
acceptance-positive/throughput-negative result. It does not establish a global
capacity law, production ranking, or cross-hardware claim.

**Decision:** Stop blind depth scaling. The next sensible research directions
remain acceptance-calibrated training or verifier/runtime optimization, subject
to their own planner packet, critic review, CEO decision, and single-GPU slot.

**Boundary:** This handoff does not approve a new experiment, does not reopen
sealed data, and does not change the currently blocked-preflight status of
PLAN-20260821-001.

## Evidence links

- [EXP-20260821-008 card](../experiments/cards/EXP-20260821-008-smollm-2layer-vs-1layer-timing.md)
- [EXP-20260821-008 receipt](../receipts/EXP-20260821-008-smollm-2layer-vs-1layer-timing/README.md)
- [Current research state](../CURRENT-STATE.md)

No new command, artifact, remote process, or cleanup action was initiated by
this handoff.
