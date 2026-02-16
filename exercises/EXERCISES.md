# Exercises — The Caves of Steel

Exercises organized by difficulty. Each one teaches a key concept from the guide.

## Level 1: Fundamentals

### Exercise 1.1: Model Identity
Run `llama-cli` with the flag `--verbose-prompt` and answer:
- How many tokens does your prompt contain?
- What quantization is your model? (check the filename: Q4_K_M, Q6_K, etc.)
- How many parameters does the model have?

### Exercise 1.2: Token Economics
Using `llama-cli`, test these prompts and count the output tokens:
1. "Say hello" (expected: ~5 tokens)
2. "Write a haiku about the ocean" (expected: ~20 tokens)
3. "Explain quantum computing in detail" with `-n 50` vs `-n 500`

**Question:** What happens when you set `-n` lower than the model needs?

### Exercise 1.3: Context Window
Run the same prompt with `-c 128`, `-c 512`, and `-c 4096`:
- "List 10 programming languages and explain each one briefly"

**Question:** At what context size does the model start forgetting the earlier items?

## Level 2: Parameters

### Exercise 2.1: Temperature Spectrum
Using `examples/02_temperature_lab.sh` as reference, run:
- temp=0.0 (greedy/deterministic)
- temp=0.7 (balanced)
- temp=1.5 (experimental)

**Task:** Record the outputs and identify at which temperature coherence breaks.

### Exercise 2.2: Top-P vs Top-K
Test these three configurations with the same prompt:
1. `--top-p 0.5 --top-k 10` (very restrictive)
2. `--top-p 0.9 --top-k 40` (balanced)
3. `--top-p 1.0 --top-k 0`  (unrestricted)

**Question:** Which produces the most repetitive output? Which the most diverse?

### Exercise 2.3: Repeat Penalty
Generate a 200-token story with:
1. `--repeat-penalty 1.0` (no penalty)
2. `--repeat-penalty 1.1` (mild)
3. `--repeat-penalty 1.5` (strong)

**Task:** Count how many times the most common word appears in each output.

## Level 3: Practical Applications

### Exercise 3.1: Code Reviewer
Create a file with intentional Python bugs:
```python
def add(a, b)
    return a + c

x = [1, 2, 3
print(x[5])
```
Feed it to the model and ask: "Find and fix all bugs in this code."

### Exercise 3.2: Translation Pipeline
Build a bash script that:
1. Takes a text file in Spanish
2. Feeds it to the model with a translation prompt
3. Saves the English translation to a new file
4. Compares the word count of both files

### Exercise 3.3: Document Summarizer
Using `examples/04_document_analysis.sh` as base, create a pipeline that:
1. Reads all `.md` files in a directory
2. Generates a 2-sentence summary of each
3. Outputs a combined "digest" file

## Level 4: Advanced

### Exercise 4.1: Parameter Grid Search
Write a script that tests all combinations of:
- temp: [0.1, 0.5, 0.9]
- top-p: [0.5, 0.9, 1.0]
- top-k: [10, 40, 0]

For each combination, generate output and measure:
- Time (ms)
- Output length (tokens)
- Subjective quality (1-5 manual rating)

### Exercise 4.2: Multi-Model Comparison
If you have multiple GGUF models, write a script that:
1. Runs the same prompt on each model
2. Records time, output length, and quality
3. Generates a comparison table

### Exercise 4.3: RAG Pipeline
Build a basic Retrieval-Augmented Generation system:
1. Index a folder of text files (store first 500 chars each)
2. Accept a question from the user
3. Find the most relevant file (simple keyword matching)
4. Feed the file content + question to the model
5. Output the answer with source citation

## Solutions

Solutions are intentionally not provided. The best way to learn is to experiment.
If you get stuck, review the relevant section of `guiaIA.md` and try again.

**Eto Demerzel** (Gustavo Silva Da Costa)
https://github.com/BiblioGalactic
