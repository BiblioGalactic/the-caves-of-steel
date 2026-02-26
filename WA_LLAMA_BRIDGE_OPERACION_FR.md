# WhatsApp → llama.cpp Bridge (Playbook d'Exploitation)

Guide d'exploitation quotidienne pour garder le bridge stable et prévisible.

## Phases

### Phase A — Noyau stable
- WhatsApp + LLM principal + mémoire courte
- Vérifier `/help`, `/status`, `/model`, `/reset`
- Restreindre les expéditeurs

### Phase B — Extensions utiles
- `/web`, STT, `/ocr`, `/img`, `/rag`

### Phase C — Spécialisation avancée
- `/aider`, `/salud`, `/clone`, fallback Dolphin

## Design des ports

```text
8080 -> modèle principal
8081 -> DeepSeek pour Aider
8082 -> Dolphin fallback
```

## Validation fonctionnelle

- `/status` et `/model` cohérents
- `/web`, `/ocr`, `/img`, `/rag` fonctionnels
- `/aider` active/désactive correctement
- `/sms` réservé à l'utilisateur autorisé

## Incidents courants

- `conflict/replaced`: session prise par un autre client
- STT en échec: vérifier endpoint ou local
- OCR irrégulier: vérifier modèles/répertoires
- Aider sans fichiers: réessayer avec fichiers Git

## Signature

**Eto Demerzel** (Gustavo Silva Da Costa)  
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
