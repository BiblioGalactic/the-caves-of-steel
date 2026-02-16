#!/usr/bin/env bash
# ============================================================
# 🦙 Ejemplo 01 — Hello Llama
# ============================================================
# Tu primer prompt con llama.cpp. Genera una respuesta simple.
# Requisito: llama-cli compilado, modelo GGUF descargado.
#
# Uso: bash examples/01_hello_llama.sh
# ============================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# ── Configuración (ajustar según tu sistema) ──
LLAMA_CLI="${LLAMA_CLI:-$HOME/modelo/llama.cpp/build/bin/llama-cli}"
MODELO="${MODELO:-$HOME/modelo/modelos_grandes/M6/mistral-7b-instruct-v0.1.Q6_K.gguf}"

# ── Validaciones ──
if [[ ! -x "$LLAMA_CLI" ]]; then
    echo "❌ No encontrado: $LLAMA_CLI"
    echo "   Ajusta LLAMA_CLI=<ruta> o compila llama.cpp primero."
    echo "   Ver: $REPO_ROOT/guiaIA.md sección 'Herramientas de ejecución'"
    exit 1
fi

if [[ ! -f "$MODELO" ]]; then
    echo "❌ Modelo no encontrado: $MODELO"
    echo "   Ajusta MODELO=<ruta.gguf> o descarga un modelo primero."
    exit 1
fi

# ── Ejecución ──
echo "🦙 Hello Llama — Tu primer prompt"
echo "═══════════════════════════════════"
echo ""

PROMPT="Explain what a .gguf file is in one paragraph:"

echo "📝 Prompt: $PROMPT"
echo ""

"$LLAMA_CLI" \
    -m "$MODELO" \
    -p "$PROMPT" \
    -n 128 \
    -c 512 \
    --temp 0.7 \
    --top-p 0.9 \
    --no-display-prompt \
    2>/dev/null

echo ""
echo "═══════════════════════════════════"
echo "✅ Parámetros usados:"
echo "   -n 128      → máximo 128 tokens generados"
echo "   -c 512      → ventana de contexto 512 tokens"
echo "   --temp 0.7  → creatividad moderada"
echo "   --top-p 0.9 → calidad alta"
