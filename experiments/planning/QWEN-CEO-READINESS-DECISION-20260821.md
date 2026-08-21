---
id: QWEN-CEO-READINESS-DECISION-20260821
date: 2026-08-21
status: decision-only
scope: existing-qwen-packets
---

# Dated planner decision — smallest CEO-approvable Qwen improvement

**Decision (2026-08-21): select existing `PQ-20260821-002` as the smallest
Qwen GPU-improvement candidate that can become CEO-approvable without adding a
new scientific scope.** This is a planner decision, not approval or execution.
It uses the current CEO vocabulary (`CEO APPROVED (bounded scope)` only after a
complete amendment); legacy approval wording in older queue prose does not
authorize or block this decision.

## Exact candidate

**PQ-20260821-002 — objective-only prefix-survival continuation.** Preserve the
existing frozen one-variable scope: replace v27 position-weighted CE with the
direct FP32 cumulative-log prefix objective from the objective manifest. Keep
the pinned Qwen target, v23f/v27 parent and data manifests, block-17 drafter,
optimizer/seed, runtime, evaluator, prompts, validation n=4/8/16, one epoch,
one RTX 3060 process, and maximum four GPU-hours. No new trajectories,
quantization, runtime patch, evaluator change, held-out access, or second GPU
run is part of the candidate.

This is the only existing Qwen packet whose causal change is already
mathematically specified, whose lineage/data/evaluator controls are largely
hashed, and whose outcome would directly test an improvement hypothesis on
GPU. PLAN-001 is a diagnostic and remains evaluator/layout-blocked; PQ-004
requires a new runtime selector; PQ-005 lacks paired-state manifests and adds
data/objective confounding. The completed v30 quantization rerun is a negative
serving reference, not a new improvement candidate.

## Remaining single blocker

**Implementation identity is absent.** The frozen v23f/v27 trainer tree and
all preserved candidate searches contain no executable implementation of the
complete approved objective tuple. The additive implementation card therefore
still has an unknown wrapper/module path, source/file-set hash, exact command
and dependency identity, and objective-only source diff. This is one
implementation-boundary blocker, not permission to improvise an ephemeral
wrapper.

## Smallest repair action

Complete the existing additive
[`PQ-20260821-002-OBJECTIVE-IMPLEMENTATION-MANIFEST-20260821`](PQ-20260821-002-OBJECTIVE-IMPLEMENTATION-MANIFEST-20260821.md)
with an actually supplied objective-only artifact: absolute path, complete
source/file-set SHA-256, source tree/commit or explicit `UNKNOWN`, exact
command/cwd/environment/device capture, dependency identity, and a
machine-readable diff against the frozen trainer/curve/wrapper hashes proving
only FP32 direct cumulative-log loss behavior changed. Include the required
synthetic finite/nonzero-gradient/EOS-mask smoke-gate receipt. Then obtain
critic and literature re-review and request a CEO amendment naming that exact
artifact and command. Do not write the implementation, run the smoke gate, or
start GPU work in this planning action.

## CEO handoff disposition

Until the repair supplies those identities and the amendment is recorded,
`PQ-20260821-002` remains deferred/blocked before fit. Once supplied, the CEO
can decide on the already-bounded one-epoch GPU continuation; no new hypothesis
or broader approval is needed. If the artifact cannot be supplied with exact
identity, retire PQ-002 as unexecutable and preserve the negative inventory;
do not substitute PQ-004/PQ-005 or relabel PLAN-001 as an improvement run.
