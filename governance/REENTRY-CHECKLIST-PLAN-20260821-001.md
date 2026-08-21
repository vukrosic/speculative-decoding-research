# Re-entry checklist — PLAN-20260821-001

Status: `BLOCKED — host receipt present; supplemental metadata/layout missing`  
Owner: CEO/orchestrator  
Purpose: read-only unblock gate; not an execution authorization

## Assigned action

The experiment executor must obtain an authorized RTX 3060 host/session and
write one compact receipt under `receipts/PLAN-20260821-001/` proving every
field below. The coordinator may provide the approved host/session; no other
agent may infer or guess missing identities.

The first host preflight is recorded at
`receipts/PLAN-20260821-001/remote-preflight-20260821.json`. It proves the
slot is free and closes the host/toolchain fields, but does not close the
tokenizer, PLAN evaluator, or Arm B layout fields.

## Mandatory preflight receipt

- GPU availability: `nvidia-smi` output, device identity, utilization, memory,
  and confirmation that no other task owns the slot.
- Host/process state: hostname/session, host architecture, CPU/RAM/OS/kernel,
  active process list, task-owned process baseline, and cleanup baseline.
- Runtime/build: llama.cpp source/PR lineage, exact binary/build hash,
  compiler, CUDA toolkit, driver, backend, thread count, device split, and
  invocation flags.
- Model/data: target GGUF SHA-256
  `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`, IQ1_S
  metadata, tokenizer/hash, six-prompt manifest/hash, seed, evaluator version,
  context length, and deployment block shape/mask/anchor fields.
- Oracle/control: target-only singleton oracle receipt, cache/rollback
  negative-control configuration, and exactness comparison schema.
- Resource/safety: one process, one RTX 3060 slot, maximum one hour,
  existing artifacts only, no held-out data, no downloads/installs, no source
  patches, and compact JSON/text receipts only.

## Stop rules

Stop before any Arm A/B/D comparison if any field is unavailable, guessed,
inconsistent, or unverifiable; if the target-only oracle fails; if the
negative-control contract cannot be represented; if another process owns the
GPU; or if cleanup cannot be guaranteed. Record `blocked-preflight` and the
missing field; do not retry or broaden scope.

## Re-entry decision gate

This checklist does not approve the experiment. After a complete receipt,
literature/planner/critic inputs must be re-linked and the CEO must issue a new
written amendment. Only then may the existing remote executor acknowledge the
same bounded Arm A/B schedule diagnostic plus Arm D control. Arm C,
speculative acceptance measurement, training, runtime patches, downloads,
installs, publication, spending, and held-out access remain out of scope.

## Evidence links

- [CEO decision](CEO-DECISION-2026-08-21-VERIFIER-PROBE.md)
- [CEO action log](CEO-ACTION-LOG-2026-08-21.md)
- [Queue item](../queue/2026-08-21-PLAN-001-verifier-fidelity-probe.md)
- [Post-block critique](../experiments/critique/PLAN-20260821-001-POST-BLOCK-20260821.md)
- [Re-entry critique](../experiments/critique/PLAN-20260821-001-REENTRY-CRITIQUE-20260821.md)
- [Remote preflight critique](../experiments/critique/PLAN-20260821-001-REMOTE-PREFLIGHT-CRITIQUE-20260821.md)
- [Contract manifest](PLAN-20260821-001-CONTRACT-MANIFEST.md)
