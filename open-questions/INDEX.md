# Open questions

## Highest priority

1. What training-state distribution best matches the verifier’s actual
   quantized block execution without overfitting a tiny validation screen?
2. Why does the Qwen IQ1_S target produce shape-dependent block-versus-singleton
   trajectories, and which exact/approximate contract is appropriate?
3. Which objective most increases first-position and contiguous-prefix
   acceptance rather than teacher-forced average accuracy?
4. What acceptance length is required to break even after proposal, target
   verification, correction, cache, and Python/runtime overhead?
5. Can adaptive proposal length outperform fixed n=4/8/16 under the same
   quality contract?

## Broader program

- How do DFlash2, EAGLE-family, MTP/NEXTN, Medusa, prompt lookup, and block
  diffusion compare under identical targets and evaluators?
- Which findings transfer across coding, math, chat, reasoning, and structured
  extraction?
- How do quantization and GPU architecture affect verifier exactness and
  break-even points?
- What is the minimum receipt/evaluator suite required to call a runtime
  lossless?

