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

