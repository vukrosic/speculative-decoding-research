---
date: 2026-08-22
kind: literature gate amendment
scope: canonical EXP020 remote-source-semantics probe
packet_sha256: d79b9ca9ae2ec00f69c58d7d44a65260a46675fa1810b494b79e7d6dc7301e1f
supersedes: literature/AMENDMENT-20260822-EXP020-REMOTE-SOURCE-SEMANTICS-PROBE-GATE.md
status: conditional snippet-only PASS; not executed
---

# Final canonical packet gate

This addendum binds the literature review to the repaired canonical packet at
the SHA above. The packet remains a design-only, remote-only marker inspection;
the literature lane performed no SSH or remote action.

## Observed packet repairs

The final packet closes the earlier receipt-integrity concerns by specifying:

- bounded `.part` stdout/stderr capture, promotion only after both 65,536-byte
  caps and an empty-stderr gate, plus an interrupt trap that preserves partial
  files and writes a non-overwritten terminal note;
- `LC_ALL=C`, `umask 077`, one pinned SSH endpoint/session, strict `rg` path,
  executable and version capture, and no fallback connection;
- pre/post GPU-utilisation, empty compute-app, and no-active-process checks;
- machine-checked source path, byte count, full SHA-256, and pre/post equality
  for each frozen file;
- per-file/per-marker `present`, `count`, and `context_complete=UNKNOWN`
  records, with `rg` exit 0/1 handling and explicit zero-hit records; and
- explicit payload fields stating no source-file bytes, full source, model,
  binary, data, log, build, install, GPU, or remote mutation transfer/action.

These are packet controls, not observed execution results. The final packet
status is `planner-packet-no-transfer-not-executed`.

## Literature decision

**PASS for the final packet as a bounded snippet-only provenance observation;
not an execution or experiment approval.** Under the literal no-download
boundary, it does not copy source files, binaries, models, datasets, logs, or
build outputs. It does request source-derived marker lines and bounded context
as remote command output. If policy treats even that limited egress as a
download, the probe is blocked and requires separate user authorization.

If executed exactly as written and all gates pass, the receipt could support
only the marker families, line hits, counts, and nearby numbered context that
were actually returned from the two hash-checked remote files. It cannot
establish complete local source provenance, full control flow, caller/callee or
macro/data-flow semantics, a causal marker-to-phase mapping, or any
acceptance, exactness, verifier/state, losslessness, latency, throughput, or
training claim. `context_complete=UNKNOWN` must remain unknown unless the
returned window proves otherwise; a marker absent from one file is an explicit
observation, not evidence that the phase is absent globally.

## Hard stops and required receipts

Terminalize and preserve `.part` files on endpoint, path, size, SHA/stat,
`rg`, timeout, fallback, cap, non-empty-stderr, partial-context, marker,
process, GPU, compute-app, cleanup, or pre/post mutation failure. Also stop on
any source write, file/artifact transfer, download, install, build, model or
server launch, timing/generation, GPU/holdout action, or second host/session.
Required outputs are the bounded stdout/stderr channels, any partial-terminal
note, terminal disposition, per-file/per-marker index, pre/post metadata, and
text-only SHA-256 manifest. A PASS receipt must not claim locally reproduced
full-source hashes or causal provenance.

Any subsequent source map, patch, rebuild, or runtime experiment still needs
its own planner/critic/literature review, exactness and state controls, and a
separate CEO decision. No speculative-decoding speed or quality conclusion is
licensed by this packet.

