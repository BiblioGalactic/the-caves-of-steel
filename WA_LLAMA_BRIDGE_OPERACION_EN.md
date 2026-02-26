# WhatsApp → llama.cpp Bridge (Operations Playbook)

Daily operations guide to keep the bridge stable and predictable.

## Rollout phases

### Phase A — Stable core
- WhatsApp + main LLM + short memory only
- Validate `/help`, `/status`, `/model`, `/reset`
- Restrict allowed senders

### Phase B — Useful extensions
- `/web`
- STT
- `/ocr`
- `/img`
- `/rag` + AutoRAG

### Phase C — Advanced specialization
- `/aider`
- `/salud`
- `/clone`
- Dolphin anti-censorship fallback

## Port design

```text
8080 -> main conversational model
8081 -> DeepSeek for Aider
8082 -> Dolphin fallback
```

## Functional validation matrix

- `/status`: connectivity and active configuration
- `/model`: expected model ID
- `/web`: URL-based contextual synthesis
- `/ocr`: readable extracted text from image
- `/img`: image generation without errors
- `/rag`: retrieved context reflected in answer
- `/aider`: enters coding mode and responds accordingly
- `/salud`: uses medical context when enabled
- `/sms`: outbound only for allowed user

## Common incidents

- `conflict/replaced`: another client is using the session
- audio not transcribed: STT endpoint/local configuration issue
- OCR inconsistency: local model paths or quality issue
- Aider missing files: enable file-retry and verify git-tracked files

## Signature

**Eto Demerzel** (Gustavo Silva Da Costa)  
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
