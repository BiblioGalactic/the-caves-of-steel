#!/usr/bin/env bash
# ============================================================
# 🌡️ Ejemplo 02 — Laboratorio de Temperatura
# ============================================================
# Compara cómo diferentes temperaturas afectan la salida.
# Ejecuta el mismo prompt con temp 0.1, 0.5, 0.9 y 1.2.
#
# Uso: bash examples/02_temperature_lab.sh
# ============================================================
set -euo pipefail

LLAMA_CLI="${LLAMA_CLI:-$HOME/modelo/llama.cpp/build/bin/llama-cli}"
MODELO="${MODELO:-$HOME/modelo/modelos_grandes/M6/mistral-7b-instruct-v0.1.Q6_K.gguf}"

[[ ! -x "$LLAMA_CLI" ]] && echo "❌ LLAMA_CLI no encontrado" && exit 1
[[ ! -f "$MODELO" ]] && echo "❌ MODELO no encontrado" && exit 1

PROMPT="Write a one-sentence description of the moon:"
TEMPS=(0.1 0.5 0.9 1.2)

echo "🌡️ Laboratorio de Temperatura"
echo "═══════════════════════════════"
echo "Prompt: $PROMPT"
echo ""

for temp in "${TEMPS[@]}"; do
    echo "─── temp=$temp ───"
    "$LLAMA_CLI" \
        -m "$MODELO" \
        -p "$PROMPT" \
        -n 64 \
        -c 256 \
        --temp "$temp" \
        --top-p 0.9 \
        --no-display-prompt \
        2>/dev/null
    echo ""
    echo ""
done

echo "═══════════════════════════════════"
echo "📊 Observaciones:"
echo "   temp=0.1  → Repetitiva, determinista, predecible"
echo "   temp=0.5  → Balanceada, coherente, ligeramente creativa"
echo "   temp=0.9  → Creativa, variada, puede ser imprecisa"
echo "   temp=1.2  → Experimental, impredecible, riesgo de incoherencia"
