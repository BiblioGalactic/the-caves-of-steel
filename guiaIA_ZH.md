# llama.cpp 完全指南 - 在终端中运行本地AI

> 掌握本地AI模型生态系统的实用指南

---

## 🧠 基本概念（为了正确开始）

### 什么是 `.gguf` 文件？

类似于AI模型的**ZIP文件**。包含了所有必要元素：
- 模型架构（构建方式）
- 神经权重（训练获得的“知识”）
- 分词器（将文本转换为数字的方法）
- 元数据和配置

**便携的原因**：只需复制文件，即可获得完整的AI。

### 什么是量化？

想象一下将4K照片压缩成JPEG：
- **F16**：最高精度，消耗大量RAM
- **Q8_0**：几乎无损，减少50% RAM占用
- **Q6_K**：质量与大小的绝佳平衡
- **Q5_K_M**：良好质量，紧凑
- **Q4_K_M**：大多数用途推荐的标准
- **Q4_K_S**：非常紧凑，质量下降明显但仍实用

### 令牌：AI的“货币”

模型读取的是**令牌**而非单词：
- `"こんにちは"` = 3个令牌
- `"人工"` = 2个令牌
- `"🤖"` = 1个令牌

**经验法则**：1个令牌 ≈ 日语中约0.5个字符。

---

## 🎯 模型类型与专业领域

### 按语言和领域划分

| 专业领域 | 主要语言 | 风格 | 典型用例 |
|---------|---------|---------|-------------|
| **技术/德语** | 德语 | 正式、规范 | 官方文件、精确翻译 |
| **编程** | 英语 | 结构化分析 | 调试、架构、代码审查 |
| **日语** | 日语 | 指令性、指示性 | 日语技术文档 |
| **长文本上下文** | 多语言 | 广泛知识 | 复杂分析、研究 |
| **通用/平衡** | 英语 | 流畅生成 | 日常使用、各种任务 |
| **医疗/临床** | 英语 | 临床、生物医学 | 医疗、药学文本 |
| **对话** | 英语 | 自然对话 | 聊天、客户支持 |
| **文档编写** | 英语 | 温和说明 | 手册、技术指南 |
| **紧凑/高速** | 英语 | 高效推理 | 快速测试、有限硬件 |
| **多语言** | 中文/英语 | 广泛上下文 | 国际文档 |
| **超轻量** | 英语 | 快速测试 | 开发、IoT、实验 |
| **Python专精** | 英语 | 详细教程 | 编程教育 |
| **学术** | 中文/英语 | 科学论文 | 研究、技术文本 |
| **法律/正式** | 英语 | 制度性 | 合同、政策、合规 |
| **自动化** | 英语 | 复杂判断 | 工作流、流程管理 |
| **无过滤基础** | 英语 | 中立 | 实验、直接回答 |
| **故事** | 英语 | 神话、叙事 | 世界构建、叙事小说 |
| **富有表现力的创作** | 英语 | 戏剧性、情感丰富 | 小说、创造性角色扮演 |
| **哲学** | 英语 | 苏格拉底式对话 | 辩论、批判性思维 |
| **无审查** | 英语 | 敏感话题 | 安全研究 |
| **高级角色扮演** | 英语 | 自由形式故事 | 角色扮演、创造性探索 |

---

## 🛠 生态系统工具

### 1. 运行核心

| 二进制文件 | 主要功能 | 使用时机 |
|---------|----------|---------|
| `llama-cli` | **主引擎**。从终端运行模型 | 脚本、自动化、快速测试 |
| `llama-run` | 带对话记忆的交互式聊天 | 实验、与模型交互 |
| `llama-server` | 带REST API的Web服务器 | 应用程序集成、远程使用 |

### 2. 分析工具

| 工具 | 功能 | 实用价值 |
|-------|------|---------------|
| `llama-tokenize` | 显示模型如何解释文本 | 提示优化、理解限制 |
| `llama-bench` | 测量硬件性能 | 模型比较、设置优化 |
| `llama-embedding` | 将文本转换为数值向量 | 语义搜索、相似性分析 |

### 3. 优化工具

| 工具 | 目的 | 何时需要 |
|-------|------|----------|
| `llama-quantize` | 压缩模型以减少RAM使用 | 硬件无法运行完整模型 |
| `llama-gguf-split` | 将模型分割成片段 | 下载慢、存储限制 |
| `llama-gguf-hash` | 验证文件完整性 | 确保下载正确 |

---

## ⚙️ 重要参数

### 基础（必需）

| 参数 | 功能 | 典型值 | 实例 |
|-----------|------|-----------|-------|
| `-m` | 模型路径 | 绝对路径 | `-m ~/models/mistral-7b.gguf` |
| `-p` | 提示/问题 | 自由文本 | `-p "解释一下光合作用"` |
| `-n, --n-predict` | 生成的最大令牌数 | 128-2048 | `-n 512` (中等长度响应) |
| `-c, --ctx-size` | 上下文大小 | 512-16384 | `-c 4096` (长文档) |

### 上下文与内存控制

| 设置 | 估算RAM使用量 | 理想场景 |
|------|-------------|----------------|
| `--ctx-size 1024` | ~1-2MB | 基本聊天、短问题 |
| `--ctx-size 2048` | ~2-4MB | 常规对话 |
| `--ctx-size 4096` | ~4-8MB | 中等文档、分析 |
| `--ctx-size 8192` | ~8-16MB | 长文本、研究 |
| `--ctx-size 16384` | ~16-32MB | 非常广泛的文档 |

### 创造力控制

| 温度 | 行为 | 用例 |
|------|------|-------|
| `--temp 0.1` | **机器人**：非常确定性 | 代码、修正、精确数据 |
| `--temp 0.3` | **技术性**：精确但灵活 | 文档化、解释 |
| `--temp 0.7` | **人性化**：自然平衡 | 一般对话 |
| `--temp 0.9` | **创造性**：动态 | 头脑风暴、创意 |
| `--temp 1.2` | **艺术家**：非常实验性 | 小说、自由形式故事 |

### 输出质量控制

| 参数 | 效果 | 保守值 | 创造值 |
|-----------|------|-----------|-----------|
| `--top-p` | 词汇多样性 | 0.9 | 0.95 |
| `--top-k` | 令牌选择限制 | 20-40 | 80-100 |
| `--repeat-penalty` | 防止重复 | 1.1 | 1.05 |
| `--repeat-last-n` | 防重复窗口 | 64 | 128 |

### 性能优化

| 参数 | 功能 | 典型设置 |
|-----------|------|-------------|
| `-t, --threads` | CPU线程数 | 可用核心数 |
| `--batch-size` | 批处理 | 512-2048（取决于RAM） |
| `--gpu-layers` | GPU上的层数 | 99（使用全部GPU） |

---

## 📋 按专业领域划分的配方

### 🔧 文本修正与编辑

```bash
# 精密文档修正
./llama-cli \
    -m ./models/mistral-7b-instruct.gguf \
    -p "请修正以下文本的错别字和语法错误：$(cat document.txt)" \
    -c 4096 \
    -n 512 \
    --temp 0.2 \
    --top-p 0.9 \
    --repeat-penalty 1.1 \
    --silent
```

### 💻 代码分析与审查

```bash
# 带详细分析的代码审查
./llama-cli \
    -m ./models/deepseek-coder.gguf \
    -p "请分析此代码并提供改进建议：$(cat script.py)" \
    -c 8192 \
    -n 1024 \
    --temp 0.1 \
    --repeat-penalty 1.1 \
    --silent
```

### 🎨 创造性生成

```bash
# 高表现力的创造性写作
./llama-cli \
    -m ./models/chronos-hermes.gguf \
    -p "写一个关于AI觉醒的宏大故事" \
    -c 4096 \
    -n 1500 \
    --temp 0.9 \
    --top-p 0.95 \
    --repeat-penalty 1.05
```

### 🔍 长文本文档分析

```bash
# 处理非常长的上下文
./llama-cli \
    -m ./models/llama-70b.gguf \
    -p "请总结并分析整个文档：$(cat long_document.txt)" \
    -c 16384 \
    -n 2048 \
    --temp 0.5 \
    --top-p 0.9 \
    --repeat-penalty 1.1 \
    -t 8
```

### 💬 自然对话

```bash
# 带记忆的交互式聊天
./llama-run \
    -m ./models/openchat.gguf \
    --repeat-penalty 1.1 \
    --temp 0.7 \
    -c 2048 \
    -i
```

---

## 🧪 任务类型策略

### 技术性・事实性任务
```bash
# 追求最大精度的设置
--temp 0.1-0.3 --top-p 0.9 --repeat-penalty 1.1
# 推荐模型：Coder、Medical、Technical
```

### 对话与解释
```bash
# 平衡自然的设置
--temp 0.6-0.8 --top-p 0.9 --repeat-penalty 1.1 --repeat-last-n 64
# 推荐模型：Chat、General-purpose、Instruction-following
```

### 创造性与头脑风暴
```bash
# 追求最大表现力的设置
--temp 0.8-1.2 --top-p 0.95 --repeat-penalty 1.05
# 推荐模型：Creative、Storytelling、Roleplay
```

### 研究与分析
```bash
# 追求分析深度的设置
--temp 0.3-0.5 --top-p 0.9 -c 8192+ --n-predict 1024+
# 推荐模型：Large context、Academic、Research-focused
```

---

## 🚀 自动化与集成

### 自动模型选择脚本

```bash
#!/bin/bash
# 基于任务类型的智能选择器

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

# 使用选择器
TASK_TYPE="$1"
MODEL=$(select_model_by_task "$TASK_TYPE")
PROMPT="$2"

./llama-cli -m "$MODEL" -p "$PROMPT" -c 4096 -n 512 --temp 0.7
```

### 多模型服务器

```bash
#!/bin/bash
# 将多个模型作为服务启动

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
    
    echo "✅ $model_name 服务器已在端口 $port 启动"
}

# 启动专业服务
start_model_server "./models/mistral-general.gguf" 8080 "通用"
start_model_server "./models/deepseek-coder.gguf" 8081 "代码"
start_model_server "./models/creative-model.gguf" 8082 "创造性"

echo "🌐 可用服务器："
echo "  通用： http://localhost:8080"
echo "  代码： http://localhost:8081"
echo "  创造性： http://localhost:8082"
```

### 文档处理管道

```bash
#!/bin/bash
# 完整管道：OCR → 修正 → 分析

process_document() {
    local input_image="$1"
    local output_dir="./processed"
    
    mkdir -p "$output_dir"
    
    # 1. 文档OCR
    tesseract "$input_image" "$output_dir/raw_text"
    
    # 2. AI修正
    ./llama-cli \
        -m ./models/correction-model.gguf \
        -p "请修正此文本中的错误：$(cat "$output_dir/raw_text.txt")" \
        -c 4096 -n 1024 --temp 0.2 --silent \
        > "$output_dir/corrected_text.txt"
    
    # 3. 分析与摘要
    ./llama-cli \
        -m ./models/analysis-model.gguf \
        -p "请总结关键点：$(cat "$output_dir/corrected_text.txt")" \
        -c 2048 -n 256 --temp 0.5 --silent \
        > "$output_dir/summary.txt"
    
    echo "✅ 文档已在 $output_dir 处理完毕"
}

# 使用管道
process_document "scanned_document.png"
```

---

## 🛡 常见故障排除

### 非常大的模型（70B+）
**症状**：系统缓慢、内存不足
**解决方案**：
```bash
# 减少内存使用
-c 2048              # 更少的上下文
-t 4                 # 更少的线程
--gpu-layers 50      # 仅部分GPU卸载
# 或者，使用更激进的量化（Q4_K_S）
```

### 代码模型
**症状**：响应不完整、代码被截断
**解决方案**：
```bash
-n 2048              # 更多的输出令牌
--temp 0.1           # 最大精度
-c 8192              # 为长代码提供更多上下文
--ignore-eos         # 不提前停止
```

### 创造性模型
**症状**：重复、缺乏一致性
**解决方案**：
```bash
--repeat-penalty 1.1  # 对重复施加惩罚
--mirostat 2          # 自动控制
--temp 0.8            # 温度不要设置过高
-c 4096+              # 为一致性提供更多上下文
```

### 检测性能问题
```bash
# 监控资源使用情况
watch -n 1 'ps aux | grep llama-cli'

# 快速基准测试
./llama-bench -m model.gguf -p 512 -n 128

# 内存测试
./llama-cli -m model.gguf -c 1024 -n 10 --temp 0.1 -p "测试"
```

---

## 🎯 高效生产设置

### 有用的环境变量

```bash
# 添加到 .bashrc 或 .zshrc
export LLAMA_HOME="./llama.cpp/build/bin"
export MODELS_DIR="./models"

# 用于快速使用的别名
alias llama='$LLAMA_HOME/llama-cli -m $MODELS_DIR/general-model.gguf'
alias llama-code='$LLAMA_HOME/llama-cli -m $MODELS_DIR/code-model.gguf'
alias llama-creative='$LLAMA_HOME/llama-cli -m $MODELS_DIR/creative-model.gguf'

# 预定义设置
alias quick-fix='llama -n 256 --temp 0.2 --repeat-penalty 1.1 --silent -p'
alias code-review='llama-code -c 8192 -n 1024 --temp 0.1 --silent -p'
alias brainstorm='llama-creative -c 4096 -n 800 --temp 0.9 --top-p 0.95 -p'
```

### 完整基准测试脚本

```bash
#!/bin/bash
# 评估所有模型的性能

benchmark_all() {
    local models_dir="$1"
    
    echo "📊 模型基准测试"
    echo "======================"
    
    for model in "$models_dir"/*.gguf; do
        model_name=$(basename "$model" .gguf)
        echo "🧪 正在评估： $model_name"
        
        ./llama-bench \
            -m "$model" \
            -p 512 \
            -n 128 \
            -t $(nproc) 2>/dev/null | \
            grep "llama_print_timings" || echo "❌ $model_name 出错"
        echo ""
    done
    
    echo "✅ 基准测试完成"
}

# 运行基准测试
benchmark_all "./models"
```

---

## 📚 技术参考

### 量化格式（按质量/大小排序）

| 格式 | 质量 | 大小 | 推荐用途 |
|------|------|--------|---------|
| **Q8_0** | 99% | 原始的50% | 最高质量、强大硬件 |
| **Q6_K** | 98% | 原始的60% | 优异平衡 |
| **Q5_K_M** | 95% | 原始的70% | 推荐通用用途 |
| **Q4_K_M** | 90% | 原始的50% | 有限硬件 |
| **Q4_K_S** | 85% | 原始的45% | 最大实用压缩 |

### 诊断命令

```bash
# 验证模型完整性
./llama-gguf-hash -f model.gguf

# 分词分析
./llama-tokenize -m model.gguf -p "在此输入您的文本"

# 快速功能测试
./llama-cli -m model.gguf -p "2+2=" -n 5 --temp 0.1

# 模型信息
./llama-cli -m model.gguf --help | head -20
```

### 推荐后续步骤

1.  在不同任务类型上试验温度
2.  为最常见的工作流设置别名
3.  尝试服务器模式以与其他应用程序集成
4.  根据处理的文档优化上下文大小
5.  基于内容实现自动模型选择

---

> **典型结构**：`./llama.cpp/build/bin/`（二进制文件）和 `./models/`（.gguf文件）
>
> **安装**：从官方GitHub仓库编译llama.cpp

掌握本地AI生态系统所需的一切都已具备！
