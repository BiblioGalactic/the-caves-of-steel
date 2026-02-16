# The Caves of Steel 📚🦙

An open educational resource for mastering local AI models and llama.cpp from the terminal. No cloud, no API keys, no subscriptions — just your hardware and your curiosity.

---

## Quick Start

```bash
# 1. Clone this repo
git clone https://github.com/BiblioGalactic/the-caves-of-steel.git
cd the-caves-of-steel

# 2. Set your environment (adjust paths to your system)
export LLAMA_CLI="$HOME/modelo/llama.cpp/build/bin/llama-cli"
export MODELO="$HOME/modelo/modelos_grandes/M6/mistral-7b-instruct-v0.1.Q6_K.gguf"

# 3. Run your first example
bash examples/01_hello_llama.sh
```

If you don't have llama.cpp yet, see the **Prerequisites** section below.

---

## What You'll Learn

The comprehensive guide (available in 7 languages) covers everything from zero to production:

**Fundamentals** — What are .gguf files, quantization levels (Q4_K_M through F16), token economics (1 token ≈ 0.75 words), and how local models differ from cloud APIs.

**Execution** — `llama-cli` for scripting, `llama-run` for interactive chat, `llama-server` for REST APIs. Every flag explained with practical examples.

**Parameters** — Temperature, top-p, top-k, repeat penalty, context size. When to use each and how they interact.

**Practical Recipes** — Code generation, document analysis, translation, text correction, academic writing, terminal automation.

**Optimization** — Benchmarking, thread tuning, GPU acceleration, quantization trade-offs.

---

## Repository Structure

```text
the-caves-of-steel/
├── guiaIA.md                # Complete guide (Spanish)
├── guiaIA_EN.md             # Complete guide (English)
├── guiaIA_CAT.md            # Complete guide (Catalan)
├── guiaIA_EUS.md            # Complete guide (Basque)
├── guiaIA_JP.md             # Complete guide (Japanese)
├── guiaIA_ZH.md             # Complete guide (Chinese)
├── guiaIA_FR.md             # Complete guide (French)
├── examples/                # Runnable example scripts
│   ├── 01_hello_llama.sh    # Your first prompt
│   ├── 02_temperature_lab.sh # Compare temperature effects
│   ├── 03_code_generation.sh # Generate code with low temp
│   ├── 04_document_analysis.sh # Analyze text files
│   └── 05_benchmark.sh      # Measure performance
├── exercises/               # Hands-on exercises (4 levels)
│   └── EXERCISES.md         # From fundamentals to RAG pipelines
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── SECURITY.md
├── LICENSE
└── README.md                # This file
```

---

## Prerequisites

You need two things: a compiled llama.cpp and a GGUF model.

**llama.cpp** (the inference engine):
```bash
git clone https://github.com/ggerganov/llama.cpp.git
cd llama.cpp
cmake -B build
cmake --build build --config Release -j$(nproc)
# Binary at: build/bin/llama-cli
```

**A GGUF model** (start with Mistral 7B Q6_K for good quality/speed balance):
Download from Hugging Face: `TheBloke/Mistral-7B-Instruct-v0.1-GGUF`

---

## Examples

Each example is a self-contained bash script you can run immediately:

| Example | What it teaches |
|---------|----------------|
| `01_hello_llama.sh` | First prompt, basic flags (-m, -p, -n, -c) |
| `02_temperature_lab.sh` | How temperature affects creativity vs precision |
| `03_code_generation.sh` | Low-temp code generation, --top-k tuning |
| `04_document_analysis.sh` | Feeding files to the model, large context |
| `05_benchmark.sh` | Measuring tokens/second, thread optimization |

---

## Exercises

Progressive exercises in `exercises/EXERCISES.md` covering 4 levels:

- **Level 1: Fundamentals** — Token counting, context windows, model identity
- **Level 2: Parameters** — Temperature spectrum, top-p vs top-k, repeat penalty
- **Level 3: Practical** — Code review pipeline, translation, document summarizer
- **Level 4: Advanced** — Parameter grid search, multi-model comparison, RAG pipeline

---

## Guides by Language

| Language | File | Lines |
|----------|------|-------|
| Castellano | `guiaIA.md` | 510 |
| English | `guiaIA_EN.md` | 504 |
| Catala | `guiaIA_CAT.md` | 509 |
| Euskara | `guiaIA_EUS.md` | 509 |
| Francais | `guiaIA_FR.md` | 484 |
| Japanese | `guiaIA_JP.md` | 513 |
| Chinese | `guiaIA_ZH.md` | 513 |

---

## Part of the BiblioGalactic Ecosystem

The Caves of Steel works standalone, but it's also part of a larger AI toolkit:

- **Robotsdelamanecer** — Conversational AI agents (HAL-10, CC-33PPOO, Da1ta1, VENDER)
- **volumen_bucle** — Autonomous loop agents in 7 languages
- **volumen_linguistic_composition** — Functional Neopolylingual prompt engineering
- **light-sculpture** — Audiovisual processing toolkit (GLADIA)
- **volumen_memoria** — Persistent memory systems for AI agents

---

## License

CC BY-NC-SA 4.0 — Free to use, share, and adapt for non-commercial purposes.

**Eto Demerzel** (Gustavo Silva Da Costa)
https://etodemerzel.gumroad.com
https://github.com/BiblioGalactic
