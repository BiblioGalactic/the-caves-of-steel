# WhatsApp → llama.cpp Bridge (Operazio Playbook-a)

Eguneroko operazio gida bridge-a egonkor eta aurreikusgarri mantentzeko.

## Faseak

### A Fasea — Nukleo egonkorra
- WhatsApp + LLM nagusia + memoria laburra
- Balioztatu `/help`, `/status`, `/model`, `/reset`
- Bidaltzaile baimenduak murriztu

### B Fasea — Hedapen erabilgarriak
- `/web`, STT, `/ocr`, `/img`, `/rag`

### C Fasea — Espezializazio aurreratua
- `/aider`, `/salud`, `/clone`, Dolphin fallback

## Portu diseinua

```text
8080 -> elkarrizketa eredua
8081 -> DeepSeek Aider-erako
8082 -> Dolphin fallback
```

## Balidazio funtzionala

- `/status` eta `/model` zuzen
- `/web`, `/ocr`, `/img`, `/rag` martxan
- `/aider` ondo aktibatu/desaktibatu
- `/sms` erabiltzaile baimenduari soilik

## Ohiko gorabeherak

- `conflict/replaced`: beste bezero batek saioa hartu du
- STT huts: endpoint edo lokal konfigurazioa berrikusi
- OCR irregularra: eredu/ruta lokalak berrikusi
- Aider fitxategirik gabe: Git fitxategiekin berrsaiatu

## Sinadura

**Eto Demerzel** (Gustavo Silva Da Costa)  
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
