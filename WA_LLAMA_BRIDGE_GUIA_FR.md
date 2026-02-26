# WhatsApp → llama.cpp Bridge (Guide Étendu)

> Manuel pratique pour utiliser WhatsApp comme client de votre IA locale via `llama-server`.

## Ce que vous avez construit

Ce bridge est une couche bidirectionnelle :
- Entrée WhatsApp (Baileys, compte personnel lié)
- Routage + mémoire courte par chat
- Appels vers `llama-server` compatible OpenAI
- Réponse dans le même chat (texte, et voix clonée en option)

## Architecture recommandée

```text
WhatsApp <-> Baileys <-> bridge.js
                       |-> LLM principal
                       |-> LLM fallback
                       |-> STT (distant/local)
                       |-> OCR local
                       |-> VLM + YOLO
                       |-> TTS clone
                       |-> RAG local
                       |-> Mode Aider
                       |-> Couche médicale
                       |-> SMS sortant macOS
```

## Séquence d'implémentation

1. Base stable (Node.js 20+, `.env`, `node bridge.js`)
2. Connexion par code d'appairage (recommandée)
3. Séparation des rôles par ports (8080/8081/8082)
4. Durcissement (`WA_STRICT_SINGLE_INSTANCE`, `ALLOW_FROM`, restriction `/sms`)

## Capacités

- `/web`: scraping + contexte
- STT distant ou local
- `/clone`: échantillon vocal + Coqui XTTS
- `/ocr`: OCR local
- Analyse image auto: OCR + VLM + YOLO
- `/img`: génération locale SDXL/Diffusers
- `/rag` + `/autorag`: récupération locale
- `/aider` + `/stopaider`: copilotage code par chat
- `/salud`: contexte médical local
- `/sms`: SMS sortants via Messages
- Fallback anti-censure Dolphin (optionnel)

## Signature

**Eto Demerzel** (Gustavo Silva Da Costa)  
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
