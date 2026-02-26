# WhatsApp → llama.cpp Bridge (Gida Hedatua)

> Gida praktikoa WhatsApp zure IA lokalaren bezero gisa erabiltzeko `llama-server` bidez.

## Zer eraiki duzu

Bridge hau bi noranzkoko geruza da:
- Sarrera WhatsApp-etik (Baileys, lotutako kontu pertsonala)
- Txat bakoitzeko routing eta memoria laburra
- `llama-server` OpenAI-bateragarrira deialdiak
- Erantzuna txat berean (testua eta, aukeran, ahots klonatua)

## Gomendatutako arkitektura

```text
WhatsApp <-> Baileys <-> bridge.js
                       |-> LLM nagusia
                       |-> fallback LLM
                       |-> STT (urrunekoa/lokala)
                       |-> OCR lokala
                       |-> VLM + YOLO
                       |-> TTS klonazioa
                       |-> RAG lokala
                       |-> Aider modua
                       |-> testuinguru medikoa
                       |-> macOS SMS irteera
```

## Inplementazio sekuentzia

1. Oinarri egonkorra (Node.js 20+, `.env`, `node bridge.js`)
2. Parekatze-kode bidezko login-a (QR baino hobea)
3. Portuen banaketa (8080 nagusia, 8081 Aider, 8082 Dolphin)
4. Gogortzea (`WA_STRICT_SINGLE_INSTANCE`, `ALLOW_FROM`, `/sms` murrizketa)

## Gaitasunen mapa

- `/web`: scraping + testuingurua
- STT urrunekoa edo Whisper lokala
- `/clone`: ahots lagina + Coqui XTTS
- `/ocr`: OCR lokala
- Irudien auto-analisia: OCR + VLM + YOLO
- `/img`: SDXL/Diffusers lokala
- `/rag` eta `/autorag`: berreskuratze lokala
- `/aider` eta `/stopaider`: kode laguntza txatetik
- `/salud`: osasun testuinguru lokala
- `/sms`: Messages bidezko SMS irteera
- Zentsura-fallback aukerakoa Dolphin-ekin

## Sinadura

**Eto Demerzel** (Gustavo Silva Da Costa)  
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
