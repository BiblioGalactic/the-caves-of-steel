# llama.cpp完全ガイド - ターミナルでローカルAI

> ローカルAIモデルエコシステムをマスターするための実践ガイド

---

## 🧠 基本概念（正しく始めるために）

### `.gguf`ファイルとは何か？

AIモデル用の**ZIPファイル**のようなものです。必要な要素がすべて含まれています：
- モデルのアーキテクチャ（構築方法）
- ニューラル重み（訓練された「知識」）
- トークナイザー（テキストを数値に変換する方法）
- メタデータと設定

**ポータブルな理由**：ファイルをコピーするだけで、完全なAIを入手できます。

### 量子化とは何か？

4K写真と同じ写真をJPEGに圧縮した場合を想像してください：
- **F16**：最大精度、RAMの消費量が膨大
- **Q8_0**：ほぼ無損失、RAMを50%削減
- **Q6_K**：品質とサイズの優れたバランス
- **Q5_K_M**：良好な品質、コンパクト
- **Q4_K_M**：ほとんどの用途で推奨される標準
- **Q4_K_S**：非常にコンパクト、品質低下は目立つが実用的

### トークン：AIの「通貨」

モデルは単語ではなく**トークン**を読みます：
- `"こんにちは"` = 3トークン
- `"人工"` = 2トークン
- `"🤖"` = 1トークン

**経験則**：1トークン ≈ 日本語では0.5文字程度。

---

## 🎯 モデルの種類と特化分野

### 言語と領域別

| 特化分野 | 主要言語 | スタイル | 典型的な使用例 |
|---------|---------|---------|-------------|
| **技術/ドイツ語** | ドイツ語 | 正式、規範的 | 公式文書、正確な翻訳 |
| **プログラミング** | 英語 | 構造化分析 | デバッグ、アーキテクチャ、コードレビュー |
| **日本語** | 日本語 | 命令的、指示的 | 日本語技術文書 |
| **長文コンテキスト** | 多言語 | 幅広い知識 | 複雑な分析、研究 |
| **汎用/バランス** | 英語 | 流暢な生成 | 日常使用、様々なタスク |
| **医療/臨床** | 英語 | 臨床的、生物医学的 | 医療、薬学テキスト |
| **会話** | 英語 | 自然な対話 | チャット、カスタマーサポート |
| **文書作成** | 英語 | 穏やかな説明 | マニュアル、技術ガイド |
| **コンパクト/高速** | 英語 | 効率的な推論 | 高速テスト、限定ハードウェア |
| **多言語** | 中国語/英語 | 広範囲コンテキスト | 国際文書 |
| **超軽量** | 英語 | 高速テスト | 開発、IoT、実験 |
| **Python特化** | 英語 | 詳細なチュートリアル | プログラミング教育 |
| **学術** | 中国語/英語 | 科学論文 | 研究、技術テキスト |
| **法的/正式** | 英語 | 制度的 | 契約、ポリシー、コンプライアンス |
| **自動化** | 英語 | 複雑な判断 | ワークフロー、プロセス管理 |
| **フィルターなしベース** | 英語 | 中立 | 実験、直接的回答 |
| **物語** | 英語 | 神話的、ストーリーテリング | 世界構築、叙事的フィクション |
| **表現豊かな創作** | 英語 | ドラマチック、感情的 | フィクション、創造的ロールプレイ |
| **哲学的** | 英語 | ソクラテス式対話 | 議論、批判的思考 |
| **無検閲** | 英語 | センシティブなトピック | セキュリティ研究 |
| **高度なロールプレイ** | 英語 | 自由形式の物語 | ロールプレイ、創造的探索 |

---

## 🛠 エコシステムツール

### 1. 実行コア

| バイナリ | 主要機能 | 使用時期 |
|---------|----------|---------|
| `llama-cli` | **メインエンジン**。ターミナルからモデルを実行 | スクリプト、自動化、高速テスト |
| `llama-run` | 会話メモリ付きインタラクティブチャット | 実験、モデルとの対話 |
| `llama-server` | REST APIを持つWebサーバー | アプリケーション統合、リモート使用 |

### 2. 分析ツール

| ツール | 機能 | 実用的な有用性 |
|-------|------|---------------|
| `llama-tokenize` | モデルがテキストをどう解釈するかを表示 | プロンプト最適化、制限理解 |
| `llama-bench` | ハードウェアでのパフォーマンス測定 | モデル比較、設定最適化 |
| `llama-embedding` | テキストを数値ベクトルに変換 | セマンティック検索、類似性分析 |

### 3. 最適化ツール

| ツール | 目的 | 必要な時 |
|-------|------|----------|
| `llama-quantize` | RAM使用量削減のためモデル圧縮 | ハードウェアが完全モデルに対応できない |
| `llama-gguf-split` | モデルを断片に分割 | ダウンロードが遅い、ストレージ制限 |
| `llama-gguf-hash` | ファイル整合性検証 | 正しいダウンロードの保証 |

---

## ⚙️ 重要なパラメータ

### 基本（必須）

| パラメータ | 機能 | 典型的な値 | 実用例 |
|-----------|------|-----------|-------|
| `-m` | モデルへのパス | 絶対パス | `-m ~/models/mistral-7b.gguf` |
| `-p` | プロンプト/質問 | 自由テキスト | `-p "光合成を説明して"` |
| `-n, --n-predict` | 生成する最大トークン数 | 128-2048 | `-n 512` (中程度の応答) |
| `-c, --ctx-size` | コンテキストサイズ | 512-16384 | `-c 4096` (長い文書) |

### コンテキストとメモリ制御

| 設定 | 概算RAM使用量 | 理想的なシナリオ |
|------|-------------|----------------|
| `--ctx-size 1024` | ~1-2MB | 基本チャット、短い質問 |
| `--ctx-size 2048` | ~2-4MB | 通常の会話 |
| `--ctx-size 4096` | ~4-8MB | 中程度の文書、分析 |
| `--ctx-size 8192` | ~8-16MB | 長いテキスト、研究 |
| `--ctx-size 16384` | ~16-32MB | 非常に広範囲な文書 |

### 創造性制御

| 温度 | 動作 | 使用例 |
|------|------|-------|
| `--temp 0.1` | **ロボット**：非常に決定論的 | コード、修正、正確なデータ |
| `--temp 0.3` | **技術的**：正確だが柔軟 | 文書化、説明 |
| `--temp 0.7` | **人間的**：自然なバランス | 一般的な会話 |
| `--temp 0.9` | **創造的**：ダイナミック | ブレインストーミング、アイデア |
| `--temp 1.2` | **芸術家**：非常に実験的 | フィクション、自由形式の物語 |

### 出力品質制御

| パラメータ | 効果 | 保守的な値 | 創造的な値 |
|-----------|------|-----------|-----------|
| `--top-p` | 語彙の多様性 | 0.9 | 0.95 |
| `--top-k` | トークン選択の制限 | 20-40 | 80-100 |
| `--repeat-penalty` | 繰り返し防止 | 1.1 | 1.05 |
| `--repeat-last-n` | 反復防止ウィンドウ | 64 | 128 |

### パフォーマンス最適化

| パラメータ | 機能 | 典型的な設定 |
|-----------|------|-------------|
| `-t, --threads` | CPUスレッド | 利用可能なコア数 |
| `--batch-size` | バッチ処理 | 512-2048（RAMに依存） |
| `--gpu-layers` | GPU上のレイヤー | 99（GPU全体を使用） |

---

## 📋 特化別レシピ

### 🔧 テキスト修正と編集

```bash
# 精密な文書修正
./llama-cli \
    -m ./models/mistral-7b-instruct.gguf \
    -p "次のテキストの誤字脱字と文法ミスを修正してください：$(cat document.txt)" \
    -c 4096 \
    -n 512 \
    --temp 0.2 \
    --top-p 0.9 \
    --repeat-penalty 1.1 \
    --silent
```

### 💻 コード分析とレビュー

```bash
# 詳細分析付きコードレビュー
./llama-cli \
    -m ./models/deepseek-coder.gguf \
    -p "このコードを分析し、改善提案をしてください：$(cat script.py)" \
    -c 8192 \
    -n 1024 \
    --temp 0.1 \
    --repeat-penalty 1.1 \
    --silent
```

### 🎨 創造的生成

```bash
# 高い表現力での創造的執筆
./llama-cli \
    -m ./models/chronos-hermes.gguf \
    -p "AIの覚醒について壮大な物語を書いてください" \
    -c 4096 \
    -n 1500 \
    --temp 0.9 \
    --top-p 0.95 \
    --repeat-penalty 1.05
```

### 🔍 長文文書の分析

```bash
# 非常に長いコンテキストの処理
./llama-cli \
    -m ./models/llama-70b.gguf \
    -p "この文書全体を要約し分析してください：$(cat long_document.txt)" \
    -c 16384 \
    -n 2048 \
    --temp 0.5 \
    --top-p 0.9 \
    --repeat-penalty 1.1 \
    -t 8
```

### 💬 自然な会話

```bash
# メモリ付きインタラクティブチャット
./llama-run \
    -m ./models/openchat.gguf \
    --repeat-penalty 1.1 \
    --temp 0.7 \
    -c 2048 \
    -i
```

---

## 🧪 タスク種別戦略

### 技術的・事実的タスク
```bash
# 最大精度のための設定
--temp 0.1-0.3 --top-p 0.9 --repeat-penalty 1.1
# 推奨モデル：Coder、Medical、Technical
```

### 会話と説明
```bash
# バランスの取れた自然な設定
--temp 0.6-0.8 --top-p 0.9 --repeat-penalty 1.1 --repeat-last-n 64
# 推奨モデル：Chat、General-purpose、Instruction-following
```

### 創造性とブレインストーミング
```bash
# 最大表現力のための設定
--temp 0.8-1.2 --top-p 0.95 --repeat-penalty 1.05
# 推奨モデル：Creative、Storytelling、Roleplay
```

### 研究と分析
```bash
# 分析の深さのための設定
--temp 0.3-0.5 --top-p 0.9 -c 8192+ --n-predict 1024+
# 推奨モデル：Large context、Academic、Research-focused
```

---

## 🚀 自動化と統合

### 自動モデル選択スクリプト

```bash
#!/bin/bash
# タスクタイプに基づくスマートセレクター

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

# セレクターの使用
TASK_TYPE="$1"
MODEL=$(select_model_by_task "$TASK_TYPE")
PROMPT="$2"

./llama-cli -m "$MODEL" -p "$PROMPT" -c 4096 -n 512 --temp 0.7
```

### マルチモデルサーバー

```bash
#!/bin/bash
# 複数モデルをサービスとして起動

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
    
    echo "✅ $model_name サーバーがポート $port で開始されました"
}

# 特化サービスを開始
start_model_server "./models/mistral-general.gguf" 8080 "汎用"
start_model_server "./models/deepseek-coder.gguf" 8081 "コード"
start_model_server "./models/creative-model.gguf" 8082 "創造的"

echo "🌐 利用可能なサーバー："
echo "  汎用： http://localhost:8080"
echo "  コード： http://localhost:8081" 
echo "  創造的： http://localhost:8082"
```

### 文書処理パイプライン

```bash
#!/bin/bash
# 完全パイプライン：OCR → 修正 → 分析

process_document() {
    local input_image="$1"
    local output_dir="./processed"
    
    mkdir -p "$output_dir"
    
    # 1. 文書のOCR
    tesseract "$input_image" "$output_dir/raw_text"
    
    # 2. AIによる修正
    ./llama-cli \
        -m ./models/correction-model.gguf \
        -p "このテキストの間違いを修正してください：$(cat "$output_dir/raw_text.txt")" \
        -c 4096 -n 1024 --temp 0.2 --silent \
        > "$output_dir/corrected_text.txt"
    
    # 3. 分析と要約
    ./llama-cli \
        -m ./models/analysis-model.gguf \
        -p "重要なポイントを要約してください：$(cat "$output_dir/corrected_text.txt")" \
        -c 2048 -n 256 --temp 0.5 --silent \
        > "$output_dir/summary.txt"
    
    echo "✅ 文書が $output_dir で処理されました"
}

# パイプラインの使用
process_document "scanned_document.png"
```

---

## 🛡 一般的なトラブルシューティング

### 非常に大きなモデル（70B+）
**症状**：システムが遅い、メモリ不足
**解決策**：
```bash
# メモリ使用量削減
-c 2048              # より少ないコンテキスト
-t 4                 # より少ないスレッド
--gpu-layers 50      # 部分的なGPUオフロードのみ
# または、より積極的な量子化を使用（Q4_K_S）
```

### コードモデル
**症状**：不完全な応答、切り詰められたコード
**解決策**：
```bash
-n 2048              # より多くの出力トークン
--temp 0.1           # 最大精度
-c 8192              # 長いコードのためのより多くのコンテキスト
--ignore-eos         # 早期停止しない
```

### 創造的モデル
**症状**：繰り返し、一貫性の欠如
**解決策**：
```bash
--repeat-penalty 1.1  # 繰り返しにペナルティ
--mirostat 2          # 自動制御
--temp 0.8            # 温度を高く設定しすぎない
-c 4096+              # 一貫性のためのより多くのコンテキスト
```

### パフォーマンス問題の検出
```bash
# リソース使用量の監視
watch -n 1 'ps aux | grep llama-cli'

# 高速ベンチマーク
./llama-bench -m model.gguf -p 512 -n 128

# メモリテスト
./llama-cli -m model.gguf -c 1024 -n 10 --temp 0.1 -p "テスト"
```

---

## 🎯 生産的なセットアップ

### 便利な環境変数

```bash
# .bashrcまたは.zshrcに追加
export LLAMA_HOME="./llama.cpp/build/bin"
export MODELS_DIR="./models"

# 高速使用のためのエイリアス
alias llama='$LLAMA_HOME/llama-cli -m $MODELS_DIR/general-model.gguf'
alias llama-code='$LLAMA_HOME/llama-cli -m $MODELS_DIR/code-model.gguf'
alias llama-creative='$LLAMA_HOME/llama-cli -m $MODELS_DIR/creative-model.gguf'

# 事前定義された設定
alias quick-fix='llama -n 256 --temp 0.2 --repeat-penalty 1.1 --silent -p'
alias code-review='llama-code -c 8192 -n 1024 --temp 0.1 --silent -p'
alias brainstorm='llama-creative -c 4096 -n 800 --temp 0.9 --top-p 0.95 -p'
```

### 完全ベンチマークスクリプト

```bash
#!/bin/bash
# すべてのモデルのパフォーマンスを評価

benchmark_all() {
    local models_dir="$1"
    
    echo "📊 モデルベンチマーク"
    echo "======================"
    
    for model in "$models_dir"/*.gguf; do
        model_name=$(basename "$model" .gguf)
        echo "🧪 評価中： $model_name"
        
        ./llama-bench \
            -m "$model" \
            -p 512 \
            -n 128 \
            -t $(nproc) 2>/dev/null | \
            grep "llama_print_timings" || echo "❌ $model_name でエラー"
        echo ""
    done
    
    echo "✅ ベンチマーク完了"
}

# ベンチマーク実行
benchmark_all "./models"
```

---

## 📚 技術リファレンス

### 量子化形式（品質/サイズ順）

| 形式 | 品質 | サイズ | 推奨用途 |
|------|------|--------|---------|
| **Q8_0** | 99% | 元の50% | 最高品質、強力なハードウェア |
| **Q6_K** | 98% | 元の60% | 優れたバランス |
| **Q5_K_M** | 95% | 元の70% | 推奨一般用途 |
| **Q4_K_M** | 90% | 元の50% | 限られたハードウェア |
| **Q4_K_S** | 85% | 元の45% | 最大有用圧縮 |

### 診断コマンド

```bash
# モデル整合性検証
./llama-gguf-hash -f model.gguf

# トークン化分析
./llama-tokenize -m model.gguf -p "ここにあなたのテキスト"

# 高速機能テスト
./llama-cli -m model.gguf -p "2+2=" -n 5 --temp 0.1

# モデル情報
./llama-cli -m model.gguf --help | head -20
```

### 推奨次のステップ

1. 異なるタスクタイプでの温度実験
2. 最も一般的なワークフローのためのエイリアス設定
3. 他のアプリケーションと統合するためのサーバーモード試用
4. 処理する文書に基づくコンテキストサイズ最適化
5. コンテンツに基づく自動モデル選択

---

> **典型的な構造**：`./llama.cpp/build/bin/`（バイナリ）と `./models/`（.ggufファイル）
> 
> **インストール**：公式GitHubリポジトリからllama.cppをコンパイル

ローカルAIエコシステムをマスターするために必要なすべてが揃いました！

**Eto Demerzel** (Gustavo Silva Da Costa)
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
