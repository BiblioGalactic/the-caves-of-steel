# WhatsApp → llama.cpp Bridge (Guia Estesa)

> Manual pràctic per fer servir WhatsApp com a client de la teva IA local amb `llama-server`.

## Què has creat

Aquest bridge és una capa bidireccional:
- Entrada des de WhatsApp (Baileys, compte personal enllaçat)
- Enrutament i memòria curta per xat
- Crides a `llama-server` compatible OpenAI
- Resposta al mateix xat (text i, opcionalment, àudio clonat)

## Arquitectura recomanada

```text
WhatsApp <-> Baileys <-> bridge.js
                       |-> LLM principal
                       |-> LLM fallback
                       |-> STT (remot/local)
                       |-> OCR local
                       |-> VLM + YOLO
                       |-> TTS clonat
                       |-> RAG local
                       |-> Mode Aider
                       |-> Capa mèdica
                       |-> SMS sortint macOS
```

## Seqüència d'implantació

1. Base estable (Node.js 20+, `.env`, `node bridge.js`)
2. Login per codi d'aparellament (millor que QR)
3. Separació per ports (8080 principal, 8081 Aider, 8082 Dolphin)
4. Enduriment (`WA_STRICT_SINGLE_INSTANCE`, `ALLOW_FROM`, restricció `/sms`)

## Mapa de capacitats

- `/web`: scraping i context
- STT remot o local
- `/clone`: mostra de veu + Coqui XTTS
- `/ocr`: OCR local
- Autoanàlisi d'imatge: OCR + VLM + YOLO
- `/img`: SDXL/Diffusers local
- `/rag` i `/autorag`: recuperació local
- `/aider` i `/stopaider`: assistent de codi per xat
- `/salud`: context mèdic local
- `/sms`: SMS sortint via Messages
- Fallback anticensura amb Dolphin

## Signatura

**Eto Demerzel** (Gustavo Silva Da Costa)  
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
