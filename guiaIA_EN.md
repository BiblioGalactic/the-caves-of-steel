# Complete Guide to llama.cpp - Your Local AI in the Terminal

A practical guide to mastering the local AI model ecosystem

## 🧠 Fundamental Concepts (To Get Started Right)

### What is a .gguf file?

It's like a **ZIP file but for AI models**. It contains everything needed:

  * The model's architecture (how it's built)
  * The neural weights (the trained "knowledge")
  * The tokenizer (how it converts text into numbers)
  * Metadata and configuration

That's why they are portable: you copy the file, and you have the complete AI.

### What is Quantization?

Imagine a 4K photo vs. the same photo compressed as a JPEG:

  * **F16**: Maximum precision, brutal RAM consumption
  * **Q8\_0**: Almost lossless, 50% less RAM
  * **Q6\_K**: Excellent quality/size balance
  * **Q5\_K\_M**: Good quality, compact
  * **Q4\_K\_M**: Recommended standard for most uses
  * **Q4\_K\_S**: Very compact, noticeable but functional quality loss

### Tokens: The "Currency" of AI

Models don't read words; they read **tokens**:

  * `"Hello"` = 1 token
  * `"artificial"` = 2 tokens (`"art"` + `"ificial"`)
  * `"🤖"` = 1 token

**Rule of thumb**: 1 token ≈ 0.75 words in English.

## 🎯 Types of Models and Their Specialties

### By Language and Domain

| Specialty | Main Language | Style | Typical Use Cases |
| :--- | :--- | :--- | :--- |
| Technical/German | German | Formal, normative | Official documents, precise translations |
| Programming | English | Structured analysis | Debugging, architecture, code review |
| Japanese | Japanese | Imperative, instructional | Japanese technical documentation |
| Long Context | Multilingual | Broad knowledge | Complex analysis, research |
| General/Balanced | English | Fluent generation | Daily use, varied tasks |
| Medical/Clinical | English | Clinical, biomedical | Medical, pharmaceutical texts |
| Conversational | English | Natural dialogue | Chat, customer support |
| Documentation | English | Gentle explanations | Manuals, technical guides |
| Compact/Fast | English | Efficient reasoning | Quick tests, limited hardware |
| Multilingual | Chinese/English | Extensive context | International documents |
| Ultra-Lightweight | English | Rapid testing | Development, IoT, experiments |
| Specialized Python | English | Detailed tutorials | Programming education |
| Academic | Chinese/English | Scientific papers | Research, technical texts |
| Legal/Formal | English | Institutional | Contracts, policies, compliance |
| Automation | English | Complex decisions | Workflows, process management |
| Unfiltered Base | English | Neutral | Experiments, direct answers |
| Narrative | English | Mythological, storytelling | Worldbuilding, epic fiction |
| Expressive Creative| English | Dramatic, emotional | Fiction, creative roleplay |
| Philosophical | English | Socratic dialogue | Debates, critical thinking |
| Uncensored | English | Sensitive topics | Security research |
| Advanced Roleplay | English | Free-form narrative | Roleplay, creative exploration |

## 🛠 Ecosystem Tools

### 1\. Execution Core

| Binary | Main Function | When to Use |
| :--- | :--- | :--- |
| `llama-cli` | Main engine. Executes models from the terminal | Scripts, automation, quick tests |
| `llama-run` | Interactive chat with conversation memory | Experimenting, dialoguing with models |
| `llama-server`| Web server with a REST API | Integrating with applications, remote use |

### 2\. Analysis Tools

| Tool | Function | Practical Utility |
| :--- | :--- | :--- |
| `llama-tokenize`| Shows how the model interprets your text | Optimizing prompts, understanding limits |
| `llama-bench` | Measures performance on your hardware | Comparing models, optimizing settings |
| `llama-embedding`| Converts text into numerical vectors | Semantic search, similarity analysis |

### 3\. Optimization Tools

| Tool | Purpose | When It's Needed |
| :--- | :--- | :--- |
| `llama-quantize`| Compresses models for less RAM usage | Your hardware can't handle the full model |
| `llama-gguf-split`| Divides models into fragments | Slow downloads, limited storage |
| `llama-gguf-hash`| Verifies file integrity | Ensuring correct downloads |

## ⚙️ Essential Parameters

### Basics (Must-Haves)

| Parameter | Function | Typical Values | Practical Example |
| :--- | :--- | :--- | :--- |
| `-m` | Path to the model | Absolute path | `-m ~/models/mistral-7b.gguf` |
| `-p` | Your prompt/question | Free text | `-p "Explain photosynthesis"` |
| `-n, --n-predict`| Max tokens to generate | 128-2048 | `-n 512` (medium response) |
| `-c, --ctx-size`| Context size | 512-16384 | `-c 4096` (long document) |

### Context and Memory Control

| Setting | Approx. RAM Usage | Ideal Scenario |
| :--- | :--- | :--- |
| `--ctx-size 1024` | \~1-2MB | Basic chat, short questions |
| `--ctx-size 2048` | \~2-4MB | Normal conversations |
| `--ctx-size 4096` | \~4-8MB | Medium documents, analysis |
| `--ctx-size 8192` | \~8-16MB | Long texts, research |
| `--ctx-size 16384` | \~16-32MB | Very extensive documents |

### Creativity Control

| Temperature | Behavior | Use Cases |
| :--- | :--- | :--- |
| `--temp 0.1` | **Robot**: Very deterministic | Code, corrections, precise data |
| `--temp 0.3` | **Technical**: Precise but flexible | Documentation, explanations |
| `--temp 0.7` | **Human**: Natural balance | General conversation |
| `--temp 0.9` | **Creative**: Dynamic | Brainstorming, ideas |
| `--temp 1.2` | **Artist**: Very experimental | Fiction, free-form narrative |

### Output Quality Control

| Parameter | Effect | Conservative Value | Creative Value |
| :--- | :--- | :--- | :--- |
| `--top-p` | Vocabulary variety | 0.9 | 0.95 |
| `--top-k` | Limit token choices | 20-40 | 80-100 |
| `--repeat-penalty`| Prevents repetitions | 1.1 | 1.05 |
| `--repeat-last-n`| Anti-repetition window | 64 | 128 |

### Performance Optimization

| Parameter | Function | Typical Setting |
| :--- | :--- | :--- |
| `-t, --threads`| CPU threads | Number of available cores |
| `--batch-size` | Batch processing | 512-2048 (depending on RAM) |
| `--gpu-layers` | Layers on GPU | 99 (use the entire GPU) |

## 📋 Recipes by Specialty

### 🔧 Text Correction and Editing

```bash
# Precise document correction
./llama-cli \
    -m ./models/mistral-7b-instruct.gguf \
    -p "Correct spelling and grammar mistakes: $(cat document.txt)" \
    -c 4096 \
    -n 512 \
    --temp 0.2 \
    --top-p 0.9 \
    --repeat-penalty 1.1 \
    --silent
```

### 💻 Code Analysis and Review

```bash
# Code review with detailed analysis
./llama-cli \
    -m ./models/deepseek-coder.gguf \
    -p "Analyze this code and suggest improvements: $(cat script.py)" \
    -c 8192 \
    -n 1024 \
    --temp 0.1 \
    --repeat-penalty 1.1 \
    --silent
```

### 🎨 Creative Generation

```bash
# Creative writing with high expressiveness
./llama-cli \
    -m ./models/chronos-hermes.gguf \
    -p "Write an epic story about the awakening of an AI" \
    -c 4096 \
    -n 1500 \
    --temp 0.9 \
    --top-p 0.95 \
    --repeat-penalty 1.05
```

### 🔍 Analysis of Long Documents

```bash
# Very long context processing
./llama-cli \
    -m ./models/llama-70b.gguf \
    -p "Summarize and analyze this entire document: $(cat long_document.txt)" \
    -c 16384 \
    -n 2048 \
    --temp 0.5 \
    --top-p 0.9 \
    --repeat-penalty 1.1 \
    -t 8
```

### 💬 Natural Conversation

```bash
# Interactive chat with memory
./llama-run \
    -m ./models/openchat.gguf \
    --repeat-penalty 1.1 \
    --temp 0.7 \
    -c 2048 \
    -i
```

## 🧪 Strategies by Task Type

### Technical and Factual Tasks

```bash
# Settings for maximum precision
--temp 0.1-0.3 --top-p 0.9 --repeat-penalty 1.1
# Recommended Models: Coder, Medical, Technical
```

### Conversation and Explanations

```bash
# Balanced and natural settings
--temp 0.6-0.8 --top-p 0.9 --repeat-penalty 1.1 --repeat-last-n 64
# Recommended Models: Chat, General-purpose, Instruction-following
```

### Creativity and Brainstorming

```bash
# Settings for maximum expressiveness
--temp 0.8-1.2 --top-p 0.95 --repeat-penalty 1.05
# Recommended Models: Creative, Storytelling, Roleplay
```

### Research and Analysis

```bash
# Settings for analytical depth
--temp 0.3-0.5 --top-p 0.9 -c 8192+ --n-predict 1024+
# Recommended Models: Large context, Academic, Research-focused
```

## 🚀 Automation and Integration

### Automatic Model Selection Script

```bash
#!/bin/bash
# Smart selector based on task type

select_model_by_task() {
    local task="$1"
    local base_path="./models"
    
    case "$task" in
        "code"|"programming")
            echo "$base_path/deepseek-coder.gguf"
            ;;
        "creative"|"story")
            echo "$base_path/chronos-hermes.gguf"
            ;;
        "medical"|"health")
            echo "$base_path/meditron.gguf"
            ;;
        "legal"|"formal")
            echo "$base_path/nous-hermes-legal.gguf"
            ;;
        "research"|"academic")
            echo "$base_path/llama-70b.gguf"
            ;;
        *)
            echo "$base_path/mistral-instruct.gguf"
            ;;
    esac
}

# Using the selector
TASK_TYPE="$1"
MODEL=$(select_model_by_task "$TASK_TYPE")
PROMPT="$2"

./llama-cli -m "$MODEL" -p "$PROMPT" -c 4096 -n 512 --temp 0.7
```

### Multi-Model Server

```bash
#!/bin/bash
# Launch multiple models as services

start_model_server() {
    local model_path="$1"
    local port="$2"
    local model_name="$3"
    
    ./llama-server \
        -m "$model_path" \
        --host 0.0.0.0 \
        --port "$port" \
        -c 4096 \
        --gpu-layers 99 &
    
    echo "✅ $model_name server started on port $port"
}

# Start specialized services
start_model_server "./models/mistral-general.gguf" 8080 "General"
start_model_server "./models/deepseek-coder.gguf" 8081 "Code"
start_model_server "./models/creative-model.gguf" 8082 "Creative"

echo "🌐 Servers available:"
echo "  General: http://localhost:8080"
echo "  Code: http://localhost:8081" 
echo "  Creative: http://localhost:8082"
```

### Document Processing Pipeline

```bash
#!/bin/bash
# Complete pipeline: OCR → Correction → Analysis

process_document() {
    local input_image="$1"
    local output_dir="./processed"
    
    mkdir -p "$output_dir"
    
    # 1. OCR the document
    tesseract "$input_image" "$output_dir/raw_text"
    
    # 2. Correction with AI
    ./llama-cli \
        -m ./models/correction-model.gguf \
        -p "Correct errors in this text: $(cat "$output_dir/raw_text.txt")" \
        -c 4096 -n 1024 --temp 0.2 --silent \
        > "$output_dir/corrected_text.txt"
    
    # 3. Analysis and summary
    ./llama-cli \
        -m ./models/analysis-model.gguf \
        -p "Summarize the key points: $(cat "$output_dir/corrected_text.txt")" \
        -c 2048 -n 256 --temp 0.5 --silent \
        > "$output_dir/summary.txt"
    
    echo "✅ Document processed in $output_dir"
}

# Use the pipeline
process_document "scanned_document.png"
```

## 🛡 Common Troubleshooting

### Very Large Models (70B+)

**Symptom**: System is slow or runs out of memory
**Solutions**:

```bash
# Reduce memory usage
-c 2048              # Less context
-t 4                 # Fewer threads
--gpu-layers 50      # Only partial GPU offload
# Or use a more aggressive quantization (Q4_K_S)
```

### Code Models

**Symptom**: Incomplete responses or truncated code
**Solutions**:

```bash
-n 2048              # More output tokens
--temp 0.1           # Maximum precision
-c 8192              # More context for long code
--ignore-eos         # Don't stop prematurely
```

### Creative Models

**Symptom**: Repetition or loss of coherence
**Solutions**:

```bash
--repeat-penalty 1.1  # Penalize repetitions
--mirostat 2          # Automatic control
--temp 0.8            # Don't set temperature too high
-c 4096+              # More context for coherence
```

### Performance Issue Detection

```bash
# Monitor resource usage
watch -n 1 'ps aux | grep llama-cli'

# Quick benchmark
./llama-bench -m model.gguf -p 512 -n 128

# Memory test
./llama-cli -m model.gguf -c 1024 -n 10 --temp 0.1 -p "Test"
```

## 🎯 Productive Setup

### Useful Environment Variables

```bash
# Add to your .bashrc or .zshrc
export LLAMA_HOME="./llama.cpp/build/bin"
export MODELS_DIR="./models"

# Aliases for quick use
alias llama='$LLAMA_HOME/llama-cli -m $MODELS_DIR/general-model.gguf'
alias llama-code='$LLAMA_HOME/llama-cli -m $MODELS_DIR/code-model.gguf'
alias llama-creative='$LLAMA_HOME/llama-cli -m $MODELS_DIR/creative-model.gguf'

# Predefined configurations
alias quick-fix='llama -n 256 --temp 0.2 --repeat-penalty 1.1 --silent -p'
alias code-review='llama-code -c 8192 -n 1024 --temp 0.1 --silent -p'
alias brainstorm='llama-creative -c 4096 -n 800 --temp 0.9 --top-p 0.95 -p'
```

### Complete Benchmark Script

```bash
#!/bin/bash
# Evaluate the performance of all your models

benchmark_all() {
    local models_dir="$1"
    
    echo "📊 MODEL BENCHMARK"
    echo "======================"
    
    for model in "$models_dir"/*.gguf; do
        model_name=$(basename "$model" .gguf)
        echo "🧪 Evaluating: $model_name"
        
        ./llama-bench \
            -m "$model" \
            -p 512 \
            -n 128 \
            -t $(nproc) 2>/dev/null | \
            grep "llama_print_timings" || echo "❌ Error in $model_name"
        echo ""
    done
    
    echo "✅ Benchmark complete"
}

# Run benchmark
benchmark_all "./models"
```

## 📚 Technical References

### Quantization Formats (Ordered by Quality/Size)

| Format | Quality | Size | Recommended For |
| :--- | :--- | :--- | :--- |
| **Q8\_0** | 99% | 50% of original | Maximum quality, powerful hardware |
| **Q6\_K** | 98% | 60% of original | Excellent balance |
| **Q5\_K\_M**| 95% | 70% of original | Recommended general use |
| **Q4\_K\_M**| 90% | 50% of original | Limited hardware |
| **Q4\_K\_S**| 85% | 45% of original | Maximum useful compression |

### Diagnostic Commands

```bash
# Verify model integrity
./llama-gguf-hash -f model.gguf

# Tokenization analysis
./llama-tokenize -m model.gguf -p "Your text here"

# Quick functionality test
./llama-cli -m model.gguf -p "2+2=" -n 5 --temp 0.1

# Model information
./llama-cli -m model.gguf --help | head -20
```

### Recommended Next Steps

  * Experiment with temperatures for different types of tasks
  * Set up aliases for your most common workflows
  * Try server mode to integrate with other applications
  * Optimize context size based on the documents you process
  * Automate model selection based on content

**Typical structure**: `./llama.cpp/build/bin/` (binaries) and `./models/` (.gguf files)
**Installation**: Compile llama.cpp from the official GitHub repository

You have everything you need to master your local AI ecosystem\!

**Eto Demerzel** (Gustavo Silva Da Costa)
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
