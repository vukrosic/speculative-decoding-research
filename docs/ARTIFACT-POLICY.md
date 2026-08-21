# Artifact policy

The Git repository remains small and cloneable.

## Store in Git

- Markdown experiment cards and notes
- Small JSON/YAML receipts
- Hash manifests
- Small configuration files
- Reproduction commands
- Compact tables and plots when genuinely useful
- Tiny deterministic fixtures only when needed for tests

## Keep outside Git

- Checkpoints and model weights
- GGUF, safetensors, ONNX, and optimizer state
- Raw/processed datasets and generated corpora
- Hidden-state, KV-cache, and feature tensors
- Build trees and virtual environments
- Profiler traces and large logs
- Large benchmark outputs

Each external artifact reference should include its immutable identity, SHA-256,
byte size, producer experiment, storage location, and retention state.

