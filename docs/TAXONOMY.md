# Research taxonomy

## Methods

- Autoregressive speculative decoding
- DFlash and DFlash2
- EAGLE-family drafters
- Medusa-style multi-head prediction
- Native multi-token prediction / NEXTN
- Block diffusion and semi-autoregressive decoding
- Prompt lookup, n-gram, and retrieval drafters
- Tree, beam, and multi-candidate verification
- Self-speculation and layer skipping

## Research axes

- Draft architecture and capacity
- Target-state interface and selected layers
- Training data, anchors, context windows, and distribution matching
- Hard-label CE, distillation, position weighting, curricula, and objectives
- Proposal length and adaptive scheduling
- Acceptance and correction policy
- Cache, mask, position, and verifier correctness
- Numerical shape dependence and quantization
- Runtime integration, kernels, batching, and launch overhead
- Hardware memory, bandwidth, energy, and economics
- Exact versus approximate contracts
- Domain and workload transfer

## Status vocabulary

- `planned`: card exists; no mutating work started
- `running`: authorized work is active
- `completed-positive`: gate passed and candidate promoted
- `completed-negative`: valid result; candidate rejected
- `blocked`: exact external decision or resource is required
- `aborted`: stopped before a valid terminal measurement
- `invalid`: protocol or integrity defect makes the result unusable

