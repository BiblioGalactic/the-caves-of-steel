# Guia Completa de llama.cpp - La Teva IA Local en Terminal

> Una guia pràctica per dominar l'ecosistema de models d'IA locals

---

## 🧠 Conceptes Fonamentals (Per començar bé)

### Què és un arxiu `.gguf`?
És com un **arxiu ZIP però per a models d'IA**. Conté tot el necessari:
- L'arquitectura del model (com està construït)
- Els pesos neuronals (el "coneixement" entrenat)
- El tokenitzador (com converteix text en números)
- Metadades i configuració

**Per això són portàtils**: copies l'arxiu i ja tens la IA completa.

### Què és la Quantització?
Imagina una foto en 4K vs la mateixa foto comprimida en JPEG:
- **F16**: Precisió màxima, consum de RAM brutal
- **Q8_0**: Gairebé sense pèrdua, 50% menys RAM
- **Q6_K**: Excel·lent equilibri qualitat/mida
- **Q5_K_M**: Bona qualitat, compacte
- **Q4_K_M**: Estàndard recomanat per a la majoria
- **Q4_K_S**: Molt compacte, pèrdua notable però funcional

### Tokens: La "Moneda" de la IA
Els models no llegeixen paraules, llegeixen **tokens**:
- `"Hola"` = 1 token
- `"artificial"` = 2 tokens (`"art"` + `"ificial"`)
- `"🤖"` = 1 token

**Regla pràctica**: 1 token ≈ 0.75 paraules en català.

---

## 🎯 Tipus de Models i les Seves Especialitats

### Per Idioma i Domini

| Especialitat | Idioma Principal | Estil | Casos d'Ús Típics |
|--------------|-----------------|-------|-------------------|
| **Tècnic/Alemany** | Alemany | Formal, normatiu | Documents oficials, traduccions precises |
| **Programació** | Anglès | Anàlisi estructurada | Debugging, arquitectura, code review |
| **Japonès** | Japonès | Imperatius, instruccions | Documentació tècnica japonesa |
| **Context Llarg** | Multilingüe | Coneixement ampli | Anàlisis complexes, recerca |
| **General/Balancejat** | Anglès | Generació fluida | Ús diari, tasques variades |
| **Mèdic/Clínic** | Anglès | Clínic, biomèdic | Textos mèdics, farmacèutics |
| **Conversacional** | Anglès | Diàleg natural | Xat, atenció al client |
| **Documentació** | Anglès | Explicacions suaus | Manuals, guies tècniques |
| **Compacte/Ràpid** | Anglès | Raonament eficient | Proves ràpides, maquinari limitat |
| **Multiidioma** | Xinès/Anglès | Context extens | Documents internacionals |
| **Ultra Lleuger** | Anglès | Testing ràpid | Desenvolupament, IoT, experiments |
| **Python Especialitzat** | Anglès | Tutorials detallats | Ensenyament de programació |
| **Acadèmic** | Xinès/Anglès | Papers científics | Recerca, textos tècnics |
| **Jurídic/Formal** | Anglès | Institucional | Contractes, polítiques, compliance |
| **Automatització** | Anglès | Decisions complexes | Workflows, gestió de processos |
| **Base Sense Filtres** | Anglès | Neutral | Experiments, respostes directes |
| **Narratiu** | Anglès | Mitològic, storytelling | Worldbuilding, ficció èpica |
| **Creatiu Expressiu** | Anglès | Dramàtic, emotiu | Ficció, roleplay creatiu |
| **Filosòfic** | Anglès | Diàleg socràtic | Debats, pensament crític |
| **Sense Censura** | Anglès | Temes sensibles | Recerca de seguretat |
| **Roleplay Avançat** | Anglès | Narrativa lliure | Roleplay, exploració creativa |

---

## 🛠 Eines de l'Ecosistema

### 1. Nucli d'Execució

| Binari | Funció Principal | Quan Usar |
|---------|-------------------|-------------|
| `llama-cli` | **Motor principal**. Executa models des de terminal | Scripts, automatització, proves ràpides |
| `llama-run` | Xat interactiu amb memòria de conversa | Experimentar, dialogar amb models |
| `llama-server` | Servidor web amb API REST | Integrar amb aplicacions, ús remot |

### 2. Eines d'Anàlisi

| Eina | Funció | Utilitat Pràctica |
|-------------|---------|-------------------|
| `llama-tokenize` | Mostra com el model interpreta el teu text | Optimitzar prompts, entendre límits |
| `llama-bench` | Mesura rendiment al teu maquinari | Comparar models, optimitzar configuració |
| `llama-embedding` | Converteix text en vectors numèrics | Cerca semàntica, anàlisi de similitud |

### 3. Eines d'Optimització

| Eina | Propòsit | Quan és Necessària |
|-------------|-----------|-------------------|
| `llama-quantize` | Comprimeix models per menys RAM | El teu maquinari no suporta el model complet |
| `llama-gguf-split` | Divideix models en fragments | Descàrregues lentes, emmagatzematge limitat |
| `llama-gguf-hash` | Verifica integritat d'arxius | Assegurar descàrregues correctes |

---

## ⚙️ Paràmetres Essencials

### Bàsics (Imprescindibles)

| Paràmetre | Funció | Valors Típics | Exemple Pràctic |
|-----------|---------|----------------|------------------|
| `-m` | Ruta al model | Ruta absoluta | `-m ~/models/mistral-7b.gguf` |
| `-p` | El teu prompt/pregunta | Text lliure | `-p "Explica la fotosíntesi"` |
| `-n, --n-predict` | Tokens màxims a generar | 128-2048 | `-n 512` (resposta mitjana) |
| `-c, --ctx-size` | Mida del context | 512-16384 | `-c 4096` (document llarg) |

### Control de Context i Memòria

| Configuració | Ús de RAM Aprox. | Escenari Ideal |
|---------------|-------------------|-----------------|
| `--ctx-size 1024` | ~1-2MB | Xat bàsic, preguntes curtes |
| `--ctx-size 2048` | ~2-4MB | Converses normals |
| `--ctx-size 4096` | ~4-8MB | Documents mitjans, anàlisi |
| `--ctx-size 8192` | ~8-16MB | Textos llargs, recerca |
| `--ctx-size 16384` | ~16-32MB | Documents molt extensos |

### Control de Creativitat

| Temperatura | Comportament | Casos d'Ús |
|-------------|----------------|--------------|
| `--temp 0.1` | **Robot**: Molt determinista | Codi, correccions, dades precises |
| `--temp 0.3` | **Tècnic**: Precís però flexible | Documentació, explicacions |
| `--temp 0.7` | **Humà**: Equilibri natural | Conversa general |
| `--temp 0.9` | **Creatiu**: Dinàmic | Brainstorming, idees |
| `--temp 1.2` | **Artista**: Molt experimental | Ficció, narrativa lliure |

### Control de Qualitat de Sortida

| Paràmetre | Efecte | Valor Conservador | Valor Creatiu |
|-----------|--------|------------------|----------------|
| `--top-p` | Varietat de vocabulari | 0.9 | 0.95 |
| `--top-k` | Límit d'opcions | 20-40 | 80-100 |
| `--repeat-penalty` | Prevé repeticions | 1.1 | 1.05 |
| `--repeat-last-n` | Finestra anti-repetició | 64 | 128 |

### Optimització de Rendiment

| Paràmetre | Funció | Configuració Típica |
|-----------|---------|---------------------|
| `-t, --threads` | Fils de CPU | Nombre de nuclis disponibles |
| `--batch-size` | Processament per lots | 512-2048 (segons RAM) |
| `--gpu-layers` | Capes a GPU | 99 (usar tota la GPU disponible) |

---

## 📋 Receptes per Especialitat

### 🔧 Correcció i Edició de Text

```bash
# Correcció precisa de documents
./llama-cli \
    -m ./models/mistral-7b-instruct.gguf \
    -p "Corregeix errors ortogràfics i gramaticals: $(cat document.txt)" \
    -c 4096 \
    -n 512 \
    --temp 0.2 \
    --top-p 0.9 \
    --repeat-penalty 1.1 \
    --silent
```

### 💻 Anàlisi i Revisió de Codi

```bash
# Revisió de codi amb anàlisi detallada
./llama-cli \
    -m ./models/deepseek-coder.gguf \
    -p "Analitza aquest codi i suggereix millores: $(cat script.py)" \
    -c 8192 \
    -n 1024 \
    --temp 0.1 \
    --repeat-penalty 1.1 \
    --silent
```

### 🎨 Generació Creativa

```bash
# Escriptura creativa amb alta expressivitat
./llama-cli \
    -m ./models/chronos-hermes.gguf \
    -p "Escriu una història èpica sobre el despertar d'una IA" \
    -c 4096 \
    -n 1500 \
    --temp 0.9 \
    --top-p 0.95 \
    --repeat-penalty 1.05
```

### 🔍 Anàlisi de Documents Extensos

```bash
# Processament de context molt llarg
./llama-cli \
    -m ./models/llama-70b.gguf \
    -p "Resumeix i analitza aquest document complet: $(cat document_llarg.txt)" \
    -c 16384 \
    -n 2048 \
    --temp 0.5 \
    --top-p 0.9 \
    --repeat-penalty 1.1 \
    -t 8
```

### 💬 Conversa Natural

```bash
# Xat interactiu amb memòria
./llama-run \
    -m ./models/openchat.gguf \
    --repeat-penalty 1.1 \
    --temp 0.7 \
    -c 2048 \
    -i
```

---

## 🧪 Estratègies per Tipus de Tasca

### Tasques Tècniques i Factuals
```bash
# Configuració per a precisió màxima
--temp 0.1-0.3 --top-p 0.9 --repeat-penalty 1.1
# Models recomanats: Coder, Medical, Technical
```

### Conversa i Explicacions
```bash
# Configuració balancejada i natural
--temp 0.6-0.8 --top-p 0.9 --repeat-penalty 1.1 --repeat-last-n 64
# Models recomanats: Chat, General-purpose, Instruction-following
```

### Creativitat i Brainstorming
```bash
# Configuració per a màxima expressivitat
--temp 0.8-1.2 --top-p 0.95 --repeat-penalty 1.05
# Models recomanats: Creative, Storytelling, Roleplay
```

### Recerca i Anàlisi
```bash
# Configuració per a profunditat analítica
--temp 0.3-0.5 --top-p 0.9 -c 8192+ --n-predict 1024+
# Models recomanats: Large context, Academic, Research-focused
```

---

## 🚀 Automatització i Integració

### Script de Selecció Automàtica de Model

```bash
#!/bin/bash
# Selector intel·ligent basat en tipus de tasca

select_model_by_task() {
    local task="$1"
    local base_path="./models"
    
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

# Ús del selector
TASK_TYPE="$1"
MODEL=$(select_model_by_task "$TASK_TYPE")
PROMPT="$2"

./llama-cli -m "$MODEL" -p "$PROMPT" -c 4096 -n 512 --temp 0.7
```

### Servidor Multi-Model

```bash
#!/bin/bash
# Llançar múltiples models com a serveis

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
    
    echo "✅ $model_name servidor iniciat al port $port"
}

# Iniciar serveis especialitzats
start_model_server "./models/mistral-general.gguf" 8080 "General"
start_model_server "./models/deepseek-coder.gguf" 8081 "Codi"
start_model_server "./models/creative-model.gguf" 8082 "Creatiu"

echo "🌐 Servidors disponibles:"
echo "  General: http://localhost:8080"
echo "  Codi: http://localhost:8081"
echo "  Creatiu: http://localhost:8082"
```

### Pipeline de Processament de Documents

```bash
#!/bin/bash
# Pipeline complet: OCR → Correcció → Anàlisi

process_document() {
    local input_image="$1"
    local output_dir="./processed"
    
    mkdir -p "$output_dir"
    
    # 1. OCR del document
    tesseract "$input_image" "$output_dir/raw_text"
    
    # 2. Correcció amb IA
    ./llama-cli \
        -m ./models/correction-model.gguf \
        -p "Corregeix errors en aquest text: $(cat "$output_dir/raw_text.txt")" \
        -c 4096 -n 1024 --temp 0.2 --silent \
        > "$output_dir/corrected_text.txt"
    
    # 3. Anàlisi i resum
    ./llama-cli \
        -m ./models/analysis-model.gguf \
        -p "Resumeix els punts clau: $(cat "$output_dir/corrected_text.txt")" \
        -c 2048 -n 256 --temp 0.5 --silent \
        > "$output_dir/summary.txt"
    
    echo "✅ Document processat a $output_dir"
}

# Usar el pipeline
process_document "document_escanejat.png"
```

---

## 🛡 Solució de Problemes Comuns

### Models Molt Grans (70B+)
**Símptoma**: Sistema lent o sense memòria suficient
**Solucions**:
```bash
# Reduir ús de memòria
-c 2048              # Menys context
-t 4                 # Menys fils
--gpu-layers 50      # Només part a GPU
# O usar quantització més agressiva (Q4_K_S)
```

### Models de Codi
**Símptoma**: Respostes incompletes o codi tallat
**Solucions**:
```bash
-n 2048              # Més tokens de sortida
--temp 0.1           # Màxima precisió
-c 8192              # Més context per a codi llarg
--ignore-eos         # No tallar prematurament
```

### Models Creatius
**Símptoma**: Repetició o pèrdua de coherència
**Solucions**:
```bash
--repeat-penalty 1.1  # Penalitzar repeticions
--mirostat 2          # Control automàtic
--temp 0.8            # No excedir temperatura
-c 4096+              # Més context per a coherència
```

### Detecció de Problemes de Rendiment
```bash
# Monitoritzar ús de recursos
watch -n 1 'ps aux | grep llama-cli'

# Benchmark ràpid
./llama-bench -m model.gguf -p 512 -n 128

# Test de memòria
./llama-cli -m model.gguf -c 1024 -n 10 --temp 0.1 -p "Test"
```

---

## 🎯 Configuració Productiva

### Variables d'Entorn Útils

```bash
# Afegir al teu .bashrc o .zshrc
export LLAMA_HOME="./llama.cpp/build/bin"
export MODELS_DIR="./models"

# Àlies per a ús ràpid
alias llama='$LLAMA_HOME/llama-cli -m $MODELS_DIR/general-model.gguf'
alias llama-code='$LLAMA_HOME/llama-cli -m $MODELS_DIR/code-model.gguf'
alias llama-creative='$LLAMA_HOME/llama-cli -m $MODELS_DIR/creative-model.gguf'

# Configuracions predefinides
alias quick-fix='llama -n 256 --temp 0.2 --repeat-penalty 1.1 --silent -p'
alias code-review='llama-code -c 8192 -n 1024 --temp 0.1 --silent -p'
alias brainstorm='llama-creative -c 4096 -n 800 --temp 0.9 --top-p 0.95 -p'
```

### Script de Benchmark Complet

```bash
#!/bin/bash
# Avaluar el rendiment de tots els teus models

benchmark_all() {
    local models_dir="$1"
    
    echo "📊 BENCHMARK DE MODELS"
    echo "======================"
    
    for model in "$models_dir"/*.gguf; do
        model_name=$(basename "$model" .gguf)
        echo "🧪 Avaluant: $model_name"
        
        ./llama-bench \
            -m "$model" \
            -p 512 \
            -n 128 \
            -t $(nproc) 2>/dev/null | \
            grep "llama_print_timings" || echo "❌ Error en $model_name"
        echo ""
    done
    
    echo "✅ Benchmark completat"
}

# Executar benchmark
benchmark_all "./models"
```

---

## 📚 Referències Tècniques

### Formats de Quantització (Ordenats per Qualitat/Mida)

| Format | Qualitat | Mida | Recomanat Per |
|---------|---------|--------|------------------|
| **Q8_0** | 99% | 50% de l'original | Màxima qualitat, maquinari potent |
| **Q6_K** | 98% | 60% de l'original | Equilibri excel·lent |
| **Q5_K_M** | 95% | 70% de l'original | Ús general recomanat |
| **Q4_K_M** | 90% | 50% de l'original | Maquinari limitat |
| **Q4_K_S** | 85% | 45% de l'original | Màxima compressió útil |

### Comandaments de Diagnòstic

```bash
# Verificar integritat del model
./llama-gguf-hash -f model.gguf

# Anàlisi de tokenització
./llama-tokenize -m model.gguf -p "El teu text aquí"

# Test ràpid de funcionalitat
./llama-cli -m model.gguf -p "2+2=" -n 5 --temp 0.1

# Informació del model
./llama-cli -m model.gguf --help | head -20
```

### Propers Passos Recomanats

1. **Experimenta amb temperatures** per a diferents tipus de tasques
2. **Configura àlies** per als teus workflows més comuns
3. **Prova el mode servidor** per integrar amb altres aplicacions
4. **Optimitza el context** segons el tipus de documents que processis
5. **Automatitza la selecció** de models segons el contingut

---

> **Estructura típica**: `./llama.cpp/build/bin/` (binaris) i `./models/` (arxius .gguf)
> 
> **Instal·lació**: Compilar llama.cpp des del repositori oficial de GitHub

Tens tot el necessari per dominar el teu ecosistema d'IA local!

**Eto Demerzel** (Gustavo Silva Da Costa)
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic