# Methods

This directory is for reusable speculative-decoding ideas and small
implementations. Keep method code easy to copy and modify; model/runtime
adapters can remain beside the method until a stable common utility emerges.

Useful method categories include:

- drafter architectures and proposal policies;
- target verification and correction;
- cache/state commit and rollback;
- acceptance-aligned training objectives;
- quantization and numerical-path studies; and
- phase-level serving instrumentation.

Each method note should say what it changes, what it assumes, and how it was
tested. A method is not a performance claim until it has a matched baseline.
