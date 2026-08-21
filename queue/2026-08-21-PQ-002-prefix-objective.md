# PQ-20260821-002 — Qwen prefix-survival objective continuation

Status: `blocked-preflight` — implementation identity missing; CEO amendment required  
Readiness: [planner packet](../experiments/planning/PQ-20260821-002-READINESS-20260821.md)  
Objective manifest: [frozen proposed policy](../experiments/planning/PQ-20260821-002-OBJECTIVE-MANIFEST-20260821.md)  
Critique: [final verdict](../experiments/critique/PQ-20260821-002-OBJECTIVE-FINAL-VERDICT-20260821.md)  
Implementation preflight: [planner verdict — BLOCK, CEO amendment required](../experiments/planning/PQ-20260821-002-IMPLEMENTATION-PREFLIGHT-VERDICT-20260821.md)  
Implementation card: [objective-only implementation manifest — NEEDS CEO AMENDMENT](../experiments/planning/PQ-20260821-002-OBJECTIVE-IMPLEMENTATION-MANIFEST-20260821.md)  
Literature: [final verdict](../literature/VERDICT-20260821-PQ002-OBJECTIVE-FINAL.md)  
CEO decision: [approval suspended before fitting](../governance/CEO-DECISION-2026-08-21-PQ002.md)

This is an existing planner proposal with an in-principle bounded CEO
approval, now suspended before fitting. It changes only the training objective
from v27 position-weighted CE to the explicitly specified prefix-survival
objective. Target, selector-free block-17 drafter, features, labels, parent,
optimizer, seed, precision, runtime, evaluator, validation contract, and
held-out boundary are frozen. The executor completed read-only preflight and
hard-stopped because the pinned trainer has no executable implementation of
the new objective. A new additive implementation manifest/card, critic review,
and CEO amendment are required; no fitting or validation is authorized.

## Frozen scope

- Target GGUF SHA-256 `3895b6eaa91e705c06ad1938d16c22e86f073c6a67df86260a1da79be3d1f887`, layer 62.
- Parent v27 step-4000 SHA-256 `d3caaa631eb7b3ab6bb10c63f7e1efe2de461a7f651ed0235fdaf5ca3c3faad0`; F16 export `8e3edd04ecacd949da675dcdbe0263689fa820ee729e4376137ed816a4b0be31`.
- v23b manifest `3004d4fae84bb2df0de5c47089c2d86345a2b7c66ca4cf66f7ee3aee9439c97d`; v23f labels `bedc0561f5aca18d38b9839cf87bb36892de18f70c6d4e6a50a92f2b158b0d7b`.
- Existing trainer/wrapper/config hashes and exact flags from the provenance inventory; objective manifest hash must be captured in preflight.
- One epoch, checkpoints at optimizer steps 800/1600/2400/3200/4000, deterministic selection by n=4 accepted/cycle with registered tie-breaks.
- One remote RTX 3060, one process, maximum 4 GPU-hours, existing artifacts only. No downloads, installs, patches, new trajectories, publication, spending, or held-out access.

## Metrics and hard stops

Keep fit loss components, teacher-forced metrics, prefix survival, acceptance,
target-content, output tokens, approximate timing/VRAM, and diagnostic
exactness separate. Stop on any identity/split/objective mismatch, non-finite
forward/backward, zero gradients, optimizer failure, held-out access,
resource/process risk, evaluator mismatch, or cleanup failure. If no checkpoint
beats the v27 n=4 acceptance baseline, record a negative result and do not run
a serving-timing promotion screen.

## Receipt path

`receipts/PQ-20260821-002-prefix-objective-20260821/` must contain complete
`objective-manifest.json`, `environment.json`, `data-manifest.json`, `fit.json`,
`validation.json`, `summary.json`, `cleanup.json`, and `terminal.json` receipts
before terminal disposition. No receipt exists until a fresh CEO approval and
executor preflight pass.

Any scope change requires a new planner packet, critic review, and CEO decision;
anything outside the delegated bounded policy remains
`SEPARATE USER APPROVAL REQUIRED`.

## Preflight receipts and exact blocker

Read-only receipts are preserved under
`receipts/PQ-20260821-002-prefix-objective-20260821/`:

- `objective-manifest.json` (approval manifest hash
  `e2a8597438b9b1a327b418ebdd24f6ba31e6a9fbef4d2d3e3f2e87309d777adf`;
  receipt hash `9e21e541…`);
- `environment.json` (`6308794b…`) and `data-manifest.json` (`6ce6ddbc…`);
- blocked/not-run `fit.json`, `validation.json`, `summary.json`,
  `cleanup.json`, and `terminal.json` (terminal `8d3c511f…`).

The exact blocker is that the remote frozen v23f/v27 trainer/wrapper contains
no `L_prefix`, `log_epsilon`, or direct cumulative-log implementation. An
ephemeral wrapper or patch is not covered by the current no-other-code/flag
boundary. The smallest recovery is an additive implementation manifest/card
that pins the wrapper/module artifact and proves objective-only behavior,
followed by fresh critic/literature review and a CEO amendment.

The follow-up read-only inventory
[`objective-implementation-inventory-20260821.json`](../receipts/PQ-20260821-002-prefix-objective-20260821/objective-implementation-inventory-20260821.json)
(SHA-256 `c063fd2dd2738647748de1c74dd0c2c42773812e99ee0e39a23ea0cbeb715a38`)
searched the approved remote project and found no existing implementation of
the complete objective tuple. Generic log-softmax/perplexity/KD helpers are
preserved as unrelated evidence. The queue remains blocked until a new
implementation proposal is separately reviewed and amended; no fitting or
validation is authorized.
