# The Caves of Steel

I wrote this repo because too much local-AI documentation stops at "install `llama.cpp`" and then jumps straight to benchmarks or vague advice. What I wanted instead was terminal-first material that explains the flags, the failures and the trade-offs you actually hit when running local models day after day.

## What is here

- 7 full guides (`guiaIA*.md`)
- 5 runnable examples in `examples/`
- 14 WhatsApp bridge documents (`WA_LLAMA_BRIDGE_*`)
- one exercise pack for practice

## Why it is terminal-first

The terminal is where local inference becomes concrete: paths, context windows, threads, quantization, latency, broken quoting, oversized prompts. Hiding that behind screenshots would make the docs prettier and less useful.

## What I optimized for

- commands I actually use,
- explanations with operational consequences,
- multilingual coverage without pretending every translation is equally perfect.

## Honest limits

- examples assume you already have a working `llama.cpp` build and a GGUF model,
- several commands reflect my own path conventions and need adjustment on another machine,
- this repo teaches practice better than it teaches theory.

If you want a glossy overview of local AI, this is the wrong place. If you want to understand why one flag breaks a workflow and another one saves it, this is the right repo.
