# WhatsApp → llama.cpp Bridge (Guía Extendida)

> Manual práctico para convertir WhatsApp en el cliente de tu IA local con `llama-server`.

---

## 🎯 Qué has construido exactamente

Tu bridge hace de **pasarela bidireccional**:

1. **Entrada**: recibe mensajes de WhatsApp Web mediante Baileys (cuenta personal enlazada).
2. **Orquestación**: aplica comandos, memoria corta por chat, y reglas de enrutado.
3. **Inferencia**: llama al endpoint OpenAI-compatible de `llama-server` (`/v1/chat/completions`).
4. **Salida**: devuelve texto (o audio en modo clonación) al mismo chat.

Con esto eliminas dependencias de agente externo y operas un flujo **100% local/autogestionado**, con extensiones multimodales (audio, OCR, imagen, RAG, salud, Aider).

---

## 🧩 Arquitectura funcional (mental model)

```text
WhatsApp <-> Baileys session <-> bridge.js
                                |-> LLM principal (Mistral)
                                |-> fallback LLM (opcional)
                                |-> STT (endpoint o local Whisper)
                                |-> OCR local (PaddleOCR)
                                |-> VLM local (Qwen2.5-VL, etc.)
                                |-> YOLO local (detección objetos)
                                |-> TTS local (Coqui XTTS)
                                |-> RAG local (wikirag)
                                |-> Aider (modo edición por chat)
                                |-> Capa médica (XML/ECG/GPX/labs)
                                |-> SMS saliente (Messages.app)
```

### Principio clave

El bridge es una **capa de control**: decide *qué subsistema invocar* por comando/contexto y unifica la experiencia en un único chat.

---

## 🚀 Implementación recomendada paso a paso

## 1) Base mínima estable

- Node.js 20+
- `llama-server` corriendo (ejemplo: `http://127.0.0.1:8080/v1`)
- Dependencias del bridge instaladas

```bash
cd /Users/gustavosilvadacosta/externo/wa-llama-bridge
npm install
cp .env.example .env
node bridge.js
```

## 2) Login robusto sin QR (preferido)

```env
WA_USE_PAIRING_CODE=true
WA_PAIRING_PHONE=34622557628
WA_SHOW_QR=false
```

Luego, en WhatsApp: Dispositivos vinculados → Vincular con número → introducir código.

## 3) Aislar modelos por puertos (producción local)

- `8080`: modelo principal conversacional
- `8081`: DeepSeek para Aider
- `8082`: Dolphin para fallback anti-censura

Ventaja: evitas colisiones de propósito al compartir un único servidor/modelo.

## 4) Endurecimiento operativo

- `WA_STRICT_SINGLE_INSTANCE=true` para impedir doble `bridge.js`.
- `WA_RECONNECT_ON_CONFLICT=false` para evitar bucles en conflicto de sesión.
- `ALLOW_FROM` o `SELF_CHAT_ONLY=true` para limitar superficie de uso.
- `SMS_COMMAND_ALLOWED_FROM` para blindar `/sms`.

---

## 🛠️ Cómo lograr cada capacidad que describes

## Mensajería base IA

Configura:

- `LLM_BASE_URL`
- `LLM_MODEL`
- `HISTORY_TURNS`

Esto activa chat básico + memoria corta por hilo.

## Fallback de modelo

Añade:

- `LLM_FALLBACK_BASE_URL`
- `LLM_FALLBACK_MODEL`

Útil cuando el principal está saturado o devuelve error puntual.

## Scraping contextual (`/web`)

Ajusta `WEB_SCRAPE_*` para controlar extracción y tamaño de contexto inyectado en prompt.

## Audio a texto

Dos rutas:

- **Remota compatible OpenAI**: `AUDIO_TRANSCRIBE_*`
- **Local** (recomendado privacidad): `LOCAL_STT_ENABLED=true` + `LOCAL_STT_*`

## Clonado de voz (`/clone`)

Requiere entorno TTS operativo:

- `CLONE_TTS_PYTHON`
- paquete `TTS` instalado
- muestra de voz por chat

## OCR local (`/ocr`)

Configura `LOCAL_OCR_*` y preferiblemente fija modelos det/rec por nombre y directorio para reproducibilidad.

## Auto-análisis de imágenes

Habilita flags `AUTO_IMAGE_ANALYZE_*` y combina:

- OCR (texto)
- VLM (descripción visual)
- YOLO (detección de objetos)

## Generación de imagen (`/img`)

Activa `LOCAL_IMAGE_*` para SDXL/Diffusers local.

## RAG local

- Manual: `/rag <pregunta>` con `LOCAL_RAG_*`
- Automático por chat: `/autorag on|off` con `AUTO_RAG_*`

## Modo Aider por chat

- `/aider [ruta]` para entrar en modo edición
- `/stopaider` para salir
- refuerzos: `AIDER_AUTO_GIT_INIT`, `AIDER_RETRY_WITH_FILES`, `AIDER_SEED_FILES`

## Capa médica local (`/salud`)

Activa `MEDICAL_CONTEXT_ENABLED=true` y rutas de datos clínicos; opcionalmente servidor médico dedicado (`MEDICAL_LLM_*`).

## SMS saliente macOS

Define `SMS_*` + Messages app con SMS Relay funcional.

## Fallback anti-censura

`CENSORSHIP_FALLBACK_*` + modelo Dolphin activo en endpoint separado.

---

## ✅ Checklist de despliegue real

- [ ] Bridge inicia sin errores y mantiene sesión.
- [ ] `/status` reporta modelo principal correcto.
- [ ] `/model` devuelve el modelo esperado del endpoint principal.
- [ ] `/web` responde con contexto de URL.
- [ ] Nota de voz transcribe con STT remoto o local.
- [ ] `/ocr` funciona con imagen de prueba.
- [ ] `/img` genera artefacto visual.
- [ ] `/rag` devuelve contexto relevante.
- [ ] `/aider` entra/sale de modo correctamente.
- [ ] `/salud` incorpora contexto clínico si está activo.
- [ ] `/sms` restringido al remitente autorizado.
- [ ] Fallback Dolphin aparece solo cuando toca (si habilitado).

---

## 🧯 Troubleshooting rápido

- **`code 440` + `conflict/replaced`**: hay otro cliente ocupando la sesión. Deja solo una instancia y reinicia.
- **Deslogueo constante**: limpiar `data/auth/` y volver a vincular.
- **Aider no edita archivos**: comprobar repo Git + habilitar `AIDER_RETRY_WITH_FILES`.
- **Dolphin “no aparece”**: revisa que puerto/modelo de fallback no apunten por error al principal.
- **/clone no responde en audio**: validar entorno Python de Coqui y muestra cargada.

---

## 🔐 Buenas prácticas de seguridad

- Mantener el bridge en chat privado o lista permitida (`ALLOW_FROM`).
- Restringir `/sms` siempre por remitente.
- Separar modelos por rol para evitar respuestas ambiguas.
- Guardar `.env` fuera de sincronización pública.
- Versionar solo `.env.example`, nunca credenciales reales.

---

## Firma

**Eto Demerzel** (Gustavo Silva Da Costa)  
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
