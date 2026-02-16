#!/usr/bin/env bash
# ============================================================
# 💻 Ejemplo 03 — Generación de Código
# ============================================================
# Usa el modelo para generar funciones de código.
# Demuestra cómo ajustar temp baja para código preciso.
#
# Uso: bash examples/03_code_generation.sh
# ============================================================
set -euo pipefail

LLAMA_CLI="${LLAMA_CLI:-$HOME/modelo/llama.cpp/build/bin/llama-cli}"
MODELO="${MODELO:-$HOME/modelo/modelos_grandes/M6/mistral-7b-instruct-v0.1.Q6_K.gguf}"

[[ ! -x "$LLAMA_CLI" ]] && echo "❌ LLAMA_CLI no encontrado" && exit 1
[[ ! -f "$MODELO" ]] && echo "❌ MODELO no encontrado" && exit 1

OUTPUT_FILE="${1:-/tmp/caves_code_output.py}"

PROMPT="Write a Python function called 'fibonacci' that returns the first n Fibonacci numbers as a list. Include a docstring and type hints:

\`\`\`python"

echo "💻 Generación de Código"
echo "═══════════════════════"
echo "Prompt: Generar función fibonacci en Python"
echo "Destino: $OUTPUT_FILE"
echo ""

"$LLAMA_CLI" \
    -m "$MODELO" \
    -p "$PROMPT" \
    -n 256 \
    -c 1024 \
    --temp 0.2 \
    --top-p 0.95 \
    --top-k 40 \
    --no-display-prompt \
    2>/dev/null | tee "$OUTPUT_FILE"

echo ""
echo "═══════════════════════════════════"
echo "📝 Notas técnicas:"
echo "   --temp 0.2   → Baja creatividad = código más preciso"
echo "   --top-k 40   → Limita vocabulario a las 40 mejores opciones"
echo "   -n 256       → Suficiente para una función completa"
echo "   -c 1024      → Contexto amplio para código"
echo ""
echo "   Código guardado en: $OUTPUT_FILE"
