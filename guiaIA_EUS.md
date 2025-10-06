# llama.cpp-ren Gida Osoa - Zure IA Lokala Terminalean

> IA modelo lokalen ekosistema menderatzeko gida praktikoa

---

## 🧠 Oinarrizko Kontzeptuak (Ondo hasteko)

### Zer da `.gguf` fitxategi bat?
**ZIP fitxategi bat bezalakoa da baina IA modeloentzat**. Beharrezkoa den guztia dauka:
- Modeloaren arkitektura (nola eraikita dagoen)
- Pisu neuronalak (entrenatutako "ezagutza")
- Tokenizatzailea (testua zenbakietara nola bihurtzen duen)
- Metadatuak eta konfigurazioa

**Horregatik dira eramangarriak**: fitxategia kopiatu eta IA osoa duzu.

### Zer da Kuantizazioa?
Imajinatu 4K-ko argazki bat vs argazki bera JPEG-ean konprimatua:
- **F16**: Prezisio maximoa, RAM kontsumoa izugarria
- **Q8_0**: Ia galera gabe, %50 RAM gutxiago
- **Q6_K**: Oreka bikaina kalitate/tamaina
- **Q5_K_M**: Kalitate ona, trinkoa
- **Q4_K_M**: Gehienentzat gomendatutako estandarra
- **Q4_K_S**: Oso trinkoa, galera nabarmen baina funtzionala

### Tokenak: IAren "Moneta"
Modeloek ez dituzte hitzak irakurtzen, **tokenak** irakurtzen dituzte:
- `"Kaixo"` = 1 token
- `"artificial"` = 2 token (`"art"` + `"ificial"`)
- `"🤖"` = 1 token

**Arau praktikoa**: 1 token ≈ 0.75 hitz euskaraz.

---

## 🎯 Modelo Motak eta Haien Espezialitateek

### Hizkuntza eta Domeinuaren arabera

| Espezialitatea | Hizkuntza Nagusia | Estiloa | Erabilera Kasu Tipikoak |
|--------------|-----------------|--------|---------------------|
| **Teknikoa/Alemaniarra** | Alemana | Formala, arauemailea | Dokumentu ofizialak, itzulpen zehatzak |
| **Programazioa** | Ingelesa | Analisi egituratua | Debugging, arkitektura, code review |
| **Japoniera** | Japoniera | Inperatiboak, instrukzioak | Dokumentazio teknikoa japoniarra |
| **Testuinguru Luzea** | Eleanitza | Ezagutza zabala | Analisi konplexuak, ikerketa |
| **Orokorra/Orekatua** | Ingelesa | Sorkuntza jarioa | Egunero erabilera, zeregin anitzak |
| **Medikua/Klinikoa** | Ingelesa | Klinikoa, biomedikoa | Testu medikuak, farmazeutikoak |
| **Elkarrizketakoa** | Ingelesa | Elkarrizketa naturala | Txata, bezeroaren arreta |
| **Dokumentazioa** | Ingelesa | Azalpen leunak | Eskuliburuak, gida teknikoak |
| **Trinkoa/Bizkorra** | Ingelesa | Arrazonamendu eraginkorra | Proba azkarrak, hardware mugatua |
| **Hizkuntz Anitza** | Txinera/Ingelesa | Testuinguru zabala | Nazioarteko dokumentuak |
| **Ultra Arina** | Ingelesa | Testing azkarra | Garapena, IoT, esperimentuak |
| **Python Espezializatua** | Ingelesa | Tutorial xehatuak | Programazioaren irakaskuntza |
| **Akademikoa** | Txinera/Ingelesa | Paper zientifikoak | Ikerketa, testu teknikoak |
| **Juridikoa/Formala** | Ingelesa | Instituzionala | Kontratuak, politikak, compliance |
| **Automatizazioa** | Ingelesa | Erabaki konplexuak | Workflow-ak, prozesuen kudeaketa |
| **Oinarri Iragazkirik Gabe** | Ingelesa | Neutrala | Esperimentuak, erantzun zuzenak |
| **Narratiboa** | Ingelesa | Mitologikoa, storytelling | Worldbuilding, fikzio epikoa |
| **Sortzaile Adierazgarria** | Ingelesa | Dramatikoa, emotiboa | Fikzioa, roleplay sortzailea |
| **Filosofikoa** | Ingelesa | Elkarrizketa sokratikoa | Eztabaidak, pentsamendu kritikoa |
| **Zentsurarik Gabe** | Ingelesa | Gai sentikorrak | Segurtasunaren ikerketa |
| **Roleplay Aurreratua** | Ingelesa | Narratiba librea | Roleplay, esplorazio sortzailea |

---

## 🛠 Ekosistemako Tresnak

### 1. Exekuzio Nukleoa

| Binarioa | Funtzio Nagusia | Noiz Erabili |
|---------|-------------------|-------------|
| `llama-cli` | **Motor nagusia**. Modeloak terminaletik exekutatzen ditu | Script-ak, automatizazioa, proba azkarrak |
| `llama-run` | Txat interaktiboa elkarrizketaren memoriarekin | Esperimentatu, modeloekin hitz egin |
| `llama-server` | Web zerbitzaria REST API-arekin | Aplikazioekin integratu, urruneko erabilera |

### 2. Analisi Tresnak

| Tresna | Funtzioa | Erabilgarritasun Praktikoa |
|-------------|---------|-------------------|
| `llama-tokenize` | Modeloak zure testua nola interpretatzen duen erakusten du | Prompt-ak optimizatu, mugak ulertu |
| `llama-bench` | Zure hardware-an errendimendua neurtzen du | Modeloak konparatu, konfigurazioa optimizatu |
| `llama-embedding` | Testua bektore numerikoetara bihurtzen du | Bilaketa semantikoa, antzekotasun analisia |

### 3. Optimizazio Tresnak

| Tresna | Helburua | Noiz Beharrezkoa da |
|-------------|-----------|-------------------|
| `llama-quantize` | Modeloak konprimitzen ditu RAM gutxiagorako | Zure hardware-ak ez du modelo osoa onartzen |
| `llama-gguf-split` | Modeloak zatitan banatzen ditu | Deskarga geldoak, biltegiratze mugatua |
| `llama-gguf-hash` | Fitxategien osotasuna egiaztatzen du | Deskarga zuzenak ziurtatu |

---

## ⚙️ Ezinbesteko Parametroak

### Oinarrizkoak (Ezinbestekoak)

| Parametroa | Funtzioa | Balio Tipikoak | Adibide Praktikoa |
|-----------|---------|----------------|------------------|
| `-m` | Modeloaren bidea | Bide absolutua | `-m ~/modeloak/mistral-7b.gguf` |
| `-p` | Zure prompt-a/galdera | Testu librea | `-p "Azaldu fotosintesia"` |
| `-n, --n-predict` | Sortzeko token maximoak | 128-2048 | `-n 512` (erantzun ertaina) |
| `-c, --ctx-size` | Testuinguruaren tamaina | 512-16384 | `-c 4096` (dokumentu luzea) |

### Testuinguru eta Memoriaren Kontrola

| Konfigurazioa | RAM Erabilera Gutxi Gorabehera | Eszenatoki Ideala |
|---------------|-------------------|-----------------|
| `--ctx-size 1024` | ~1-2MB | Txat basikoa, galdera laburrak |
| `--ctx-size 2048` | ~2-4MB | Elkarrizketa normalak |
| `--ctx-size 4096` | ~4-8MB | Dokumentu ertainak, analisia |
| `--ctx-size 8192` | ~8-16MB | Testu luzeak, ikerketa |
| `--ctx-size 16384` | ~16-32MB | Dokumentu oso luzeak |

### Sormenen Kontrola

| Tenperatura | Portaera | Erabilera Kasuak |
|-------------|----------------|--------------|
| `--temp 0.1` | **Robota**: Oso deterministikoa | Kodea, zuzenketak, datu zehatzak |
| `--temp 0.3` | **Teknikoa**: Zehatza baina malgua | Dokumentazioa, azalpenak |
| `--temp 0.7` | **Gizakiarra**: Oreka naturala | Elkarrizketa orokorra |
| `--temp 0.9` | **Sortzailea**: Dinamikoa | Brainstorming, ideiak |
| `--temp 1.2` | **Artista**: Oso esperimentala | Fikzioa, narratiba librea |

### Irteeraren Kalitatearen Kontrola

| Parametroa | Efektua | Balio Kontserbadorea | Balio Sortzailea |
|-----------|--------|------------------|----------------|
| `--top-p` | Hiztegiaren aniztasuna | 0.9 | 0.95 |
| `--top-k` | Aukeren muga | 20-40 | 80-100 |
| `--repeat-penalty` | Errepikapenak saihesten ditu | 1.1 | 1.05 |
| `--repeat-last-n` | Leiho anti-errepikapen | 64 | 128 |

### Errendimenduaren Optimizazioa

| Parametroa | Funtzioa | Konfigurazio Tipikoa |
|-----------|---------|---------------------|
| `-t, --threads` | CPUren hariak | Eskuragarri dauden core kopurua |
| `--batch-size` | Lotez loteko prozesatzea | 512-2048 (RAMaren arabera) |
| `--gpu-layers` | GPUko geruzak | 99 (GPU guztia erabili) |

---

## 📋 Espezialitatearen araberako Errezetak

### 🔧 Zuzentzea eta Testuaren Edizioa

```bash
# Dokumentuen zuzenketa zehatza
./llama-cli \
    -m ./modeloak/mistral-7b-instruct.gguf \
    -p "Zuzendu akats ortografikoak eta gramatikalak: $(cat dokumentua.txt)" \
    -c 4096 \
    -n 512 \
    --temp 0.2 \
    --top-p 0.9 \
    --repeat-penalty 1.1 \
    --silent
```

### 💻 Kodearen Analisia eta Berrikuspena

```bash
# Kodearen berrikuspena analisi xehatuarekin
./llama-cli \
    -m ./modeloak/deepseek-coder.gguf \
    -p "Aztertu kode hau eta hobekuntzak proposatu: $(cat script.py)" \
    -c 8192 \
    -n 1024 \
    --temp 0.1 \
    --repeat-penalty 1.1 \
    --silent
```

### 🎨 Sorkuntza Sortzailea

```bash
# Idazketa sortzailea adierazgarritasun altua
./llama-cli \
    -m ./modeloak/chronos-hermes.gguf \
    -p "Idatzi historia epiko bat IAren esnatzeari buruz" \
    -c 4096 \
    -n 1500 \
    --temp 0.9 \
    --top-p 0.95 \
    --repeat-penalty 1.05
```

### 🔍 Dokumentu Zabalen Analisia

```bash
# Testuinguru oso luzearen prozesatzea
./llama-cli \
    -m ./modeloak/llama-70b.gguf \
    -p "Laburtu eta aztertu dokumentu oso hau: $(cat dokumentu_luzea.txt)" \
    -c 16384 \
    -n 2048 \
    --temp 0.5 \
    --top-p 0.9 \
    --repeat-penalty 1.1 \
    -t 8
```

### 💬 Elkarrizketa Naturala

```bash
# Txat interaktiboa memoriarekin
./llama-run \
    -m ./modeloak/openchat.gguf \
    --repeat-penalty 1.1 \
    --temp 0.7 \
    -c 2048 \
    -i
```

---

## 🧪 Zeregin Motaren araberako Estrategiak

### Zeregin Teknikoak eta Faktuak
```bash
# Prezisio maximorako konfigurazioa
--temp 0.1-0.3 --top-p 0.9 --repeat-penalty 1.1
# Gomendatutako modeloak: Coder, Medical, Technical
```

### Elkarrizketa eta Azalpenak
```bash
# Konfigurazio orekatua eta naturala
--temp 0.6-0.8 --top-p 0.9 --repeat-penalty 1.1 --repeat-last-n 64
# Gomendatutako modeloak: Chat, General-purpose, Instruction-following
```

### Sormena eta Brainstorming
```bash
# Adierazgarritasun maximorako konfigurazioa
--temp 0.8-1.2 --top-p 0.95 --repeat-penalty 1.05
# Gomendatutako modeloak: Creative, Storytelling, Roleplay
```

### Ikerketa eta Analisia
```bash
# Sakonera analitikorako konfigurazioa
--temp 0.3-0.5 --top-p 0.9 -c 8192+ --n-predict 1024+
# Gomendatutako modeloak: Large context, Academic, Research-focused
```

---

## 🚀 Automatizazioa eta Integrazioa

### Modeloaren Hautaketa Automatikoaren Script-a

```bash
#!/bin/bash
# Hautatzaile adimentsua zeregin motaren arabera

select_model_by_task() {
    local task="$1"
    local base_path="./modeloak"
    
    case "$task" in
        "code"|"programming")
            echo "$base_path/deepseek-coder.gguf"
            ;;
        "creative"|"story")
            echo "$base_path/chronos-hermes.gguf"
            ;;
        "medical"|"health")
            echo "$base_path/meditron.gguf"
            ;;
        "legal"|"formal")
            echo "$base_path/nous-hermes-legal.gguf"
            ;;
        "research"|"academic")
            echo "$base_path/llama-70b.gguf"
            ;;
        *)
            echo "$base_path/mistral-instruct.gguf"
            ;;
    esac
}

# Hautatzailearen erabilera
TASK_TYPE="$1"
MODELOA=$(select_model_by_task "$TASK_TYPE")
PROMPT="$2"

./llama-cli -m "$MODELOA" -p "$PROMPT" -c 4096 -n 512 --temp 0.7
```

### Modelo Anitzeko Zerbitzaria

```bash
#!/bin/bash
# Modelo anitzak zerbitzu gisa abiarazi

start_model_server() {
    local model_path="$1"
    local port="$2"
    local model_name="$3"
    
    ./llama-server \
        -m "$model_path" \
        --host 0.0.0.0 \
        --port "$port" \
        -c 4096 \
        --gpu-layers 99 &
    
    echo "✅ $model_name zerbitzaria $port portuan abiarazita"
}

# Zerbitzu espezializatuak abiarazi
start_model_server "./modeloak/mistral-general.gguf" 8080 "Orokorra"
start_model_server "./modeloak/deepseek-coder.gguf" 8081 "Kodea"
start_model_server "./modeloak/creative-model.gguf" 8082 "Sortzailea"

echo "🌐 Zerbitzari eskuragarriak:"
echo "  Orokorra: http://localhost:8080"
echo "  Kodea: http://localhost:8081"
echo "  Sortzailea: http://localhost:8082"
```

### Dokumentuen Prozesatzeko Pipeline-a

```bash
#!/bin/bash
# Pipeline osoa: OCR → Zuzenketa → Analisia

process_document() {
    local input_image="$1"
    local output_dir="./prozesatua"
    
    mkdir -p "$output_dir"
    
    # 1. Dokumentuaren OCR
    tesseract "$input_image" "$output_dir/testu_gordina"
    
    # 2. IArekin zuzenketa
    ./llama-cli \
        -m ./modeloak/correction-model.gguf \
        -p "Zuzendu akatsak testu honetan: $(cat "$output_dir/testu_gordina.txt")" \
        -c 4096 -n 1024 --temp 0.2 --silent \
        > "$output_dir/testu_zuzendua.txt"
    
    # 3. Analisia eta laburpena
    ./llama-cli \
        -m ./modeloak/analysis-model.gguf \
        -p "Laburtu puntu nagusiak: $(cat "$output_dir/testu_zuzendua.txt")" \
        -c 2048 -n 256 --temp 0.5 --silent \
        > "$output_dir/laburpena.txt"
    
    echo "✅ Dokumentua prozesatua $output_dir-n"
}

# Pipeline-a erabili
process_document "dokumentu_eskaneratua.png"
```

---

## 🛡 Arazo Ohikoen Konponketa

### Modelo Oso Handiak (70B+)
**Sintoma**: Sistema motela edo memoria nahikorik gabe
**Konponbideak**:
```bash
# Memoriaren erabilera murriztu
-c 2048              # Testuinguru gutxiago
-t 4                 # Hari gutxiago
--gpu-layers 50      # GPU-n zatia bakarrik
# Edo kuantizazio bortitagoa erabili (Q4_K_S)
```

### Kode Modeloak
**Sintoma**: Erantzun osatugabeak edo kode moztua
**Konponbideak**:
```bash
-n 2048              # Irteerako token gehiago
--temp 0.1           # Prezisio maximoa
-c 8192              # Testuinguru gehiago kode luzearentzat
--ignore-eos         # Ez moztu goizegi
```

### Modelo Sortzaileak
**Sintoma**: Errepikapenak edo koherentziaren galera
**Konponbideak**:
```bash
--repeat-penalty 1.1  # Errepikapenak penalizatu
--mirostat 2          # Kontrol automatikoa
--temp 0.8            # Ez gaindu tenperatura
-c 4096+              # Testuinguru gehiago koherentziarako
```

### Errendimendu Arazoen Detekzioa
```bash
# Baliabideen erabilera monitorizatu
watch -n 1 'ps aux | grep llama-cli'

# Benchmark azkarra
./llama-bench -m modeloa.gguf -p 512 -n 128

# Memoriaren proba
./llama-cli -m modeloa.gguf -c 1024 -n 10 --temp 0.1 -p "Proba"
```

---

## 🎯 Konfigurazio Produktiboa

### Ingurune Aldagai Erabilgarriak

```bash
# Gehitu zure .bashrc edo .zshrc-ra
export LLAMA_HOME="./llama.cpp/build/bin"
export MODELS_DIR="./modeloak"

# Erabilera azkarerako aliasak
alias llama='$LLAMA_HOME/llama-cli -m $MODELS_DIR/general-model.gguf'
alias llama-code='$LLAMA_HOME/llama-cli -m $MODELS_DIR/code-model.gguf'
alias llama-creative='$LLAMA_HOME/llama-cli -m $MODELS_DIR/creative-model.gguf'

# Aurredefinitutako konfigurazioak
alias quick-fix='llama -n 256 --temp 0.2 --repeat-penalty 1.1 --silent -p'
alias code-review='llama-code -c 8192 -n 1024 --temp 0.1 --silent -p'
alias brainstorm='llama-creative -c 4096 -n 800 --temp 0.9 --top-p 0.95 -p'
```

### Benchmark Osoaren Script-a

```bash
#!/bin/bash
# Zure modelo guztien errendimendua ebaluatu

benchmark_all() {
    local models_dir="$1"
    
    echo "📊 MODELOEN BENCHMARK"
    echo "======================"
    
    for model in "$models_dir"/*.gguf; do
        model_name=$(basename "$model" .gguf)
        echo "🧪 Ebaluatzen: $model_name"
        
        ./llama-bench \
            -m "$model" \
            -p 512 \
            -n 128 \
            -t $(nproc) 2>/dev/null | \
            grep "llama_print_timings" || echo "❌ Errorea $model_name-n"
        echo ""
    done
    
    echo "✅ Benchmark osatua"
}

# Benchmark-a exekutatu
benchmark_all "./modeloak"
```

---

## 📚 Erreferentzia Teknikoak

### Kuantizazio Formatuak (Kalitate/Tamainaren arabera ordenatuta)

| Formatua | Kalitatea | Tamaina | Gomendatua Honentzat |
|---------|---------|--------|------------------|
| **Q8_0** | 99% | Jatorrizkoaren %50 | Kalitate maximoa, hardware indartsu |
| **Q6_K** | 98% | Jatorrizkoaren %60 | Oreka bikaina |
| **Q5_K_M** | 95% | Jatorrizkoaren %70 | Erabilera orokorra gomendatua |
| **Q4_K_M** | 90% | Jatorrizkoaren %50 | Hardware mugatua |
| **Q4_K_S** | 85% | Jatorrizkoaren %45 | Konpresio maximo erabilgarria |

### Diagnostiko Komandoak

```bash
# Modeloaren osotasuna egiaztatu
./llama-gguf-hash -f modeloa.gguf

# Tokenizazioaren analisia
./llama-tokenize -m modeloa.gguf -p "Zure testua hemen"

# Funtzionalitatearen proba azkarra
./llama-cli -m modeloa.gguf -p "2+2=" -n 5 --temp 0.1

# Modeloaren informazioa
./llama-cli -m modeloa.gguf --help | head -20
```

### Gomendatutako Hurrengo Pausoak

1. **Esperimentatu tenperaturekin** zeregin mota desberdinetarako
2. **Konfiguratu aliasak** zure workflow ohikoenetarako
3. **Probatu zerbitzari modua** beste aplikazioekin integratzeko
4. **Optimizatu testuingurua** prozesatzen dituzun dokumentu motaren arabera
5. **Automatizatu modeloen hautaketa** edukiaren arabera

---

> **Egitura tipikoa**: `./llama.cpp/build/bin/` (binarioak) eta `./modeloak/` (.gguf fitxategiak)
> 
> **Instalazioa**: GitHub-eko biltegi ofizialetik llama.cpp konpilatu

Zure IA lokalaren ekosistema menderatzeko behar duzun guztia duzu!

**Eto Demerzel** (Gustavo Silva Da Costa)
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic