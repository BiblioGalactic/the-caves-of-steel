# WhatsApp → llama.cpp Bridge (Extended Guide)

> Practical manual to use WhatsApp as the client for your local AI via `llama-server`.

## What you built

This bridge is a bidirectional layer:
- Input from WhatsApp (Baileys, linked personal account)
- Routing and short-term memory per chat
- Calls to OpenAI-compatible `llama-server` endpoints
- Replies in the same chat (text, and optional voice clone mode)

## Recommended architecture

```text
WhatsApp <-> Baileys <-> bridge.js
                       |-> Main LLM
                       |-> Fallback LLM
                       |-> STT (remote/local)
                       |-> OCR (local)
                       |-> VLM + YOLO (optional)
                       |-> TTS clone mode
                       |-> Local RAG
                       |-> Aider mode
                       |-> Medical context layer
                       |-> macOS SMS outbound
```

## Implementation sequence

1. Base stable setup (Node.js 20+, `.env`, `node bridge.js`)
2. Pairing-code login (recommended over QR)
3. Multi-port model split (8080 main, 8081 Aider, 8082 Dolphin)
4. Hardening (`WA_STRICT_SINGLE_INSTANCE`, `ALLOW_FROM`, `/sms` restriction)

## Capability mapping

- `/web`: controlled scraping + context injection
- Audio transcription: OpenAI-compatible endpoint or local Whisper fallback
- `/clone`: per-chat voice sample + local Coqui XTTS
- `/ocr`: local OCR pipelines
- Auto image analysis: OCR + VLM + YOLO
- `/img`: local SDXL/Diffusers generation
- `/rag` and `/autorag`: local retrieval and auto-context per chat
- `/aider` and `/stopaider`: coding assistant routing per chat
- `/salud`: local medical context and optional dedicated medical LLM
- `/sms`: outbound SMS via macOS Messages
- Censorship fallback: optional Dolphin second answer when refusal patterns are detected

## Deployment checklist

- `/status` and `/model` report expected backend
- `/web`, `/ocr`, `/img`, `/rag` run successfully
- `/aider` mode starts/stops correctly
- `/sms` is restricted to authorized sender
- conflict/replaced loops are prevented

## Signature

**Eto Demerzel** (Gustavo Silva Da Costa)  
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
