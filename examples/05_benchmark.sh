#!/usr/bin/env bash
# ============================================================
# ⏱️ Ejemplo 05 — Benchmark de Rendimiento
# ============================================================
# Mide tokens/segundo con diferentes configuraciones.
# Útil para optimizar parámetros en tu hardware.
#
# Uso: bash examples/05_benchmark.sh
# ============================================================
set -euo pipefail

LLAMA_CLI="${LLAMA_CLI:-$HOME/modelo/llama.cpp/build/bin/llama-cli}"
MODELO="${MODELO:-$HOME/modelo/modelos_grandes/M6/mistral-7b-instruct-v0.1.Q6_K.gguf}"

[[ ! -x "$LLAMA_CLI" ]] && echo "❌ LLAMA_CLI no encontrado" && exit 1
[[ ! -f "$MODELO" ]] && echo "❌ MODELO no encontrado" && exit 1

PROMPT="Count from 1 to 50, one number per line:"
RESULTS_FILE="/tmp/caves_benchmark_$(date +%Y%m%d_%H%M%S).txt"

echo "⏱️ Benchmark de Rendimiento"
echo "═══════════════════════════"
echo "Modelo: $(basename "$MODELO")"
echo "Prompt: $PROMPT"
echo ""

run_bench() {
    local ctx="$1"
    local threads="$2"
    local label="$3"

    echo "─── $label (ctx=$ctx, threads=$threads) ───"
    local start
    start=$(date +%s%N)

    "$LLAMA_CLI" \
        -m "$MODELO" \
        -p "$PROMPT" \
        -n 128 \
        -c "$ctx" \
        -t "$threads" \
        --temp 0.1 \
        --no-display-prompt \
        2>&1 | tail -5

    local end
    end=$(date +%s%N)
    local elapsed=$(( (end - start) / 1000000 ))
    echo "  Tiempo total: ${elapsed}ms"
    echo "  $label: ${elapsed}ms" >> "$RESULTS_FILE"
    echo ""
}

# Diferentes configuraciones
run_bench 512  4 "Contexto pequeño, 4 threads"
run_bench 2048 4 "Contexto medio, 4 threads"
run_bench 512  6 "Contexto pequeño, 6 threads"
run_bench 2048 6 "Contexto medio, 6 threads"

echo "═══════════════════════════════════"
echo "📊 Resultados guardados en: $RESULTS_FILE"
echo ""
echo "💡 Consejos de optimización:"
echo "   • Más threads ≠ siempre más rápido (depende de CPU)"
echo "   • Contexto grande consume más RAM"
echo "   • Cuantización Q4_K_M es ~2x más rápida que Q6_K"
echo "   • GPU layers (--gpu-layers N) acelera drásticamente si tienes GPU"
