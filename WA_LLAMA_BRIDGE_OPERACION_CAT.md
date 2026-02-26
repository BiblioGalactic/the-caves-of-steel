# WhatsApp → llama.cpp Bridge (Playbook d'Operació)

Guia d'operació diària per mantenir el bridge estable i previsible.

## Fases

### Fase A — Nucli estable
- WhatsApp + LLM principal + memòria curta
- Validar `/help`, `/status`, `/model`, `/reset`
- Restringir remitents

### Fase B — Extensions útils
- `/web`, STT, `/ocr`, `/img`, `/rag`

### Fase C — Especialització
- `/aider`, `/salud`, `/clone`, fallback Dolphin

## Disseny de ports

```text
8080 -> model principal
8081 -> DeepSeek per Aider
8082 -> Dolphin fallback
```

## Validació funcional

- `/status` i `/model` correctes
- `/web`, `/ocr`, `/img`, `/rag` operatius
- `/aider` entra/surt correctament
- `/sms` limitat a usuari autoritzat

## Incidències comunes

- `conflict/replaced`: sessió ocupada per un altre client
- STT falla: revisar endpoint o local
- OCR inconsistent: revisar models/rutes
- Aider sense fitxers: reintent amb fitxers Git

## Signatura

**Eto Demerzel** (Gustavo Silva Da Costa)  
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
