#!/usr/bin/env bash
# ============================================================
# 📄 Ejemplo 04 — Análisis de Documentos
# ============================================================
# Alimenta un archivo de texto al modelo y pide un resumen.
# Demuestra cómo usar contexto grande (-c) para documentos.
#
# Uso: bash examples/04_document_analysis.sh <archivo.txt>
# ============================================================
set -euo pipefail

LLAMA_CLI="${LLAMA_CLI:-$HOME/modelo/llama.cpp/build/bin/llama-cli}"
MODELO="${MODELO:-$HOME/modelo/modelos_grandes/M6/mistral-7b-instruct-v0.1.Q6_K.gguf}"

[[ ! -x "$LLAMA_CLI" ]] && echo "❌ LLAMA_CLI no encontrado" && exit 1
[[ ! -f "$MODELO" ]] && echo "❌ MODELO no encontrado" && exit 1

INPUT_FILE="${1:-}"
if [[ -z "$INPUT_FILE" || ! -f "$INPUT_FILE" ]]; then
    echo "Uso: bash examples/04_document_analysis.sh <archivo.txt>"
    echo ""
    echo "Si no tienes un archivo, crea uno de prueba:"
    echo '  echo "Bash is a Unix shell and command language. It was' \
         'written by Brian Fox for the GNU Project as a replacement' \
         'for the Bourne shell." > /tmp/test_doc.txt'
    exit 1
fi

# Truncar a ~2000 caracteres para no exceder contexto
DOC_CONTENT=$(head -c 2000 "$INPUT_FILE")
TOKEN_EST=$(( ${#DOC_CONTENT} / 4 ))

PROMPT="Analyze the following document and provide:
1. A brief summary (2-3 sentences)
2. Key topics mentioned
3. The tone of the text (formal, informal, technical)

Document:
---
${DOC_CONTENT}
---

Analysis:"

echo "📄 Análisis de Documentos"
echo "═══════════════════════════"
echo "Archivo: $INPUT_FILE"
echo "Tokens estimados del documento: ~$TOKEN_EST"
echo ""

"$LLAMA_CLI" \
    -m "$MODELO" \
    -p "$PROMPT" \
    -n 256 \
    -c 4096 \
    --temp 0.3 \
    --top-p 0.9 \
    --no-display-prompt \
    2>/dev/null

echo ""
echo "═══════════════════════════════════"
echo "📝 Parámetros clave:"
echo "   -c 4096     → Contexto grande para documentos"
echo "   --temp 0.3  → Baja creatividad = análisis preciso"
echo "   Tokens doc  → ~$TOKEN_EST (regla: 1 token ≈ 4 chars EN)"
