# WhatsApp → llama.cpp Bridge (Playbook de Operación)

Guía de operación diaria para mantener tu bridge estable, predecible y fácil de evolucionar.

---

## 1) Perfilado por etapas

## Etapa A — Núcleo estable

Objetivo: chat confiable 24/7.

- Activar solo: WhatsApp + LLM principal + memoria corta.
- Validar comandos: `/help`, `/status`, `/model`, `/reset`.
- Aislar remitentes: `SELF_CHAT_ONLY=true` o `ALLOW_FROM`.

## Etapa B — Extensiones útiles

Añadir gradualmente:

1. `/web`
2. STT (audio)
3. `/ocr`
4. `/img`
5. `/rag` y AutoRAG

## Etapa C — Especialización avanzada

- `/aider` para tareas de código.
- `/salud` con contexto clínico local.
- `/clone` para salida en voz.
- Fallback anti-censura con Dolphin.

Regla de oro: **activar una sola capacidad nueva por ciclo de prueba**.

---

## 2) Diseño de puertos recomendado

```text
8080 -> LLM principal (conversación diaria)
8081 -> DeepSeek (Aider)
8082 -> Dolphin (censorship fallback)
```

Si dos roles comparten puerto/modelo, perderás control semántico del sistema.

---

## 3) Política de memoria por chat

- Subir `HISTORY_TURNS` mejora continuidad, pero aumenta coste/contexto.
- Mantener un valor moderado reduce “arrastre” de errores.
- Usar `/reset` entre tareas de dominios distintos.

---

## 4) Comandos de rutina (operador)

## Arranque

```bash
node bridge.js
```

## Con watchdog

```bash
bash watchdog.sh
```

## Salud del stack multi-LLM

```bash
./scripts/llm_aux.sh start-all
./scripts/llm_aux.sh status
./scripts/llm_aux.sh logs-deep
./scripts/llm_aux.sh logs-dolphin
```

---

## 5) Matriz de validación funcional

| Función | Comando | Criterio de éxito |
|---|---|---|
| Estado general | `/status` | Muestra conectividad y configuración activa |
| Modelo actual | `/model` | Coincide con `LLM_MODEL` del endpoint principal |
| Scraping | `/web <url>` | Devuelve síntesis con contenido de la URL |
| OCR | `/ocr` sobre imagen | Extrae texto legible |
| Imagen | `/img <prompt>` | Entrega imagen sin error |
| RAG | `/rag <pregunta>` | Usa contexto indexado en la respuesta |
| Aider | `/aider [ruta]` | Entra en modo edición y responde como copiloto |
| Salud | `/salud <pregunta>` | Integra datos clínicos cuando está habilitado |
| SMS | `/sms ...` | Envía solo para remitente permitido |

---

## 6) Incidencias típicas y respuesta

- **Conflicto de sesión WhatsApp**
  - Síntoma: `stream:error conflict/replaced`.
  - Acción: cerrar cliente duplicado, mantener una sola instancia.

- **Audio no transcribe**
  - Síntoma: notas de voz sin texto.
  - Acción: revisar `AUDIO_TRANSCRIBE_*` o `LOCAL_STT_*`.

- **OCR inconsistente**
  - Síntoma: texto sucio o vacío.
  - Acción: fijar modelos OCR explícitos y revisar rutas locales.

- **Aider sin contexto de repo**
  - Síntoma: “faltan archivos”.
  - Acción: activar reintento con archivos y validar `git ls-files`.

---

## 7) Criterios de calidad operativa

Considera tu bridge “en producción local” cuando cumpla:

- Disponibilidad estable por varias horas sin reinicio manual.
- Sin conflictos de sesión en WhatsApp.
- Comandos críticos (`/status`, `/model`, `/reset`) siempre responden.
- Al menos una ruta multimodal estable (ej. `/ocr` o STT).
- Controles de seguridad activados (`ALLOW_FROM` o equivalente).

---

## Firma

**Eto Demerzel** (Gustavo Silva Da Costa)  
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
