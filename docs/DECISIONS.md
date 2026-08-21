# Decision log

## 2026-08-21 — compact Git repository

Observed: existing work includes large GGUFs, checkpoints, feature tensors,
corpora, build trees, and logs that would make a research repository difficult
to clone and maintain.

Decision: Git stores knowledge, configs, small receipts, hashes, and manifests;
large artifacts remain external and are referenced immutably. Git LFS is not
enabled by default.

## 2026-08-21 — failure-preserving experiment cards

Observed: multiple important findings were negative, including capacity and
objective ablations whose teacher-forced metrics looked better than serving
acceptance.

Decision: every valid negative result receives a permanent card and failure
index entry. Cards are append-oriented and never overwritten by a later result.

## 2026-08-21 — metric separation

Decision: loss, token accuracy, acceptance, quality, exactness, and end-to-end
speed are separate evidence classes. No metric is promoted as a proxy for
another without a dedicated validated relationship.

## 2026-08-21 — orchestration and approval boundary

Observed: the repository had strong experiment, evidence, and safety rules but
no shared queue or explicit handoff contract for literature review, experiment
planning, criticism, and execution.

Decision: `docs/ORCHESTRATION.md` is the operating contract and `queue/INDEX.md`
is the canonical work queue. The lifecycle stops at `ready-needs-approval`
until the user explicitly approves the named scope. Queue position, a planned
card, a prior authorization, or an agent's confidence never grants execution
authority.

## 2026-08-21 — verifier-fidelity priority

Observed: Qwen acceptance, exactness, and speed have not moved together;
block-shaped target states were measurably different, while alignment alone did
not improve acceptance. SmolLM capacity results likewise show that better
teacher-forced metrics do not establish serving gains.

Decision: prioritize a read-only primary-source/runtime literature review and a
critic-reviewed verifier-fidelity probe design before another capacity or
average-CE sweep. The queued probe is a recommendation only and requires a
current CEO decision before execution; it is not authorized by queue position.

## 2026-08-21 — planner queue reconciliation

Observed: a planner-owned detailed queue exists at
`experiments/planning/EXPERIMENT-QUEUE.md` with five candidate plans, while the
new orchestration queue tracks role handoffs and lifecycle state.

Decision: preserve both layers rather than duplicate or delete proposals.
`queue/INDEX.md` is authoritative for status and approval; the planner queue is
authoritative for detailed protocol drafts. The literature gate must reconcile
the candidates before one is advanced to critique.

## 2026-08-21 — critique gate and evidence closure

Observed: `experiments/critique/CRITIQUE-20260821.md` finds incomplete receipt
closure, exposed SmolLM test evidence, repeatedly optimized Qwen validation
screens, and several confounded comparisons.

Decision: these are control-plane blockers for promotion, not reasons to erase
the bounded observations. The next immediate action is documentation-only
evidence closure: preserve unknowns, classify exposed evidence as non-final, and
freeze development-screen boundaries before any new execution proposal is
considered.

## 2026-08-21 — literature handoff remains incomplete

Observed: a literature comparison, source list, synthesis, and linked
per-paper/runtime notes now exist under `literature/`, but `papers/` has no
canonical notes.

Decision: treat the reviewed notes as source material, not as a completed
repository literature handoff or method-reproduction claim. Populate the
canonical `papers/` layer or explicitly link it to the reviewed notes before
advancing the verifier-fidelity plan to critique.

## 2026-08-21 — planned card cannot self-authorize execution

Observed: `EXP-20260821-007` appeared as a planned intermediate-depth card with
an incorrect authorization statement.

Decision: preserve the proposal, correct the statement, and record that it is
documentation-only until critic review and explicit current user approval.
Planned cards and queue entries never grant remote, GPU, training, evaluation,
download, install, or held-out-data authority.
