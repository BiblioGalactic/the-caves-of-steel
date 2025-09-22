# Guía Completa de llama.cpp - Tu IA Local en Terminal

> Una guía práctica para dominar el ecosistema de modelos de IA locales

---

## 🧠 Conceptos Fundamentales (Para empezar bien)

### ¿Qué es un archivo `.gguf`?
Es como un **archivo ZIP pero para modelos de IA**. Contiene todo lo necesario:
- La arquitectura del modelo (cómo está construido)
- Los pesos neuronales (el "conocimiento" entrenado)  
- El tokenizador (cómo convierte texto en números)
- Metadatos y configuración

**Por eso son portátiles**: copias el archivo y ya tienes la IA completa.

### ¿Qué es la Cuantización?
Imagina una foto en 4K vs la misma foto comprimida en JPEG:
- **F16**: Precisión máxima, consumo de RAM brutal
- **Q8_0**: Casi sin pérdida, 50% menos RAM  
- **Q6_K**: Excelente equilibrio calidad/tamaño
- **Q5_K_M**: Buena calidad, compacto
- **Q4_K_M**: Estándar recomendado para la mayoría
- **Q4_K_S**: Muy compacto, pérdida notable pero funcional

### Tokens: La "Moneda" de la IA
Los modelos no leen palabras, leen **tokens**:
- `"Hola"` = 1 token
- `"artificial"` = 2 tokens (`"art"` + `"ificial"`)
- `"🤖"` = 1 token

**Regla práctica**: 1 token ≈ 0.75 palabras en español.

---

## 🎯 Tipos de Modelos y Sus Especialidades

### Por Idioma y Dominio

| Especialidad | Idioma Principal | Estilo | Casos de Uso Típicos |
|--------------|-----------------|--------|---------------------|
| **Técnico/Alemán** | Alemán | Formal, normativo | Documentos oficiales, traducciones precisas |
| **Programación** | Inglés | Análisis estructurado | Debugging, arquitectura, code review |
| **Japonés** | Japonés | Imperativos, instrucciones | Documentación técnica japonesa |
| **Contexto Largo** | Multilingüe | Conocimiento amplio | Análisis complejos, investigación |
| **General/Balanceado** | Inglés | Generación fluida | Uso diario, tareas variadas |
| **Médico/Clínico** | Inglés | Clínico, biomédico | Textos médicos, farmacéuticos |
| **Conversacional** | Inglés | Diálogo natural | Chat, atención al cliente |
| **Documentación** | Inglés | Explicaciones suaves | Manuales, guías técnicas |
| **Compacto/Rápido** | Inglés | Razonamiento eficiente | Pruebas rápidas, hardware limitado |
| **Multiidioma** | Chino/Inglés | Contexto extenso | Documentos internacionales |
| **Ultra Ligero** | Inglés | Testing rápido | Desarrollo, IoT, experimentos |
| **Python Especializado** | Inglés | Tutoriales detallados | Enseñanza de programación |
| **Académico** | Chino/Inglés | Papers científicos | Investigación, textos técnicos |
| **Jurídico/Formal** | Inglés | Institucional | Contratos, políticas, compliance |
| **Automatización** | Inglés | Decisiones complejas | Workflows, gestión de procesos |
| **Base Sin Filtros** | Inglés | Neutral | Experimentos, respuestas directas |
| **Narrativo** | Inglés | Mitológico, storytelling | Worldbuilding, ficción épica |
| **Creativo Expresivo** | Inglés | Dramático, emotivo | Ficción, roleplay creativo |
| **Filosófico** | Inglés | Diálogo socrático | Debates, pensamiento crítico |
| **Sin Censura** | Inglés | Temas sensibles | Investigación de seguridad |
| **Roleplay Avanzado** | Inglés | Narrativa libre | Roleplay, exploración creativa |

---

## 🛠 Herramientas del Ecosistema

### 1. Núcleo de Ejecución

| Binario | Función Principal | Cuándo Usar |
|---------|-------------------|-------------|
| `llama-cli` | **Motor principal**. Ejecuta modelos desde terminal | Scripts, automatización, pruebas rápidas |
| `llama-run` | Chat interactivo con memoria de conversación | Experimentar, dialogar con modelos |
| `llama-server` | Servidor web con API REST | Integrar con aplicaciones, uso remoto |

### 2. Herramientas de Análisis

| Herramienta | Función | Utilidad Práctica |
|-------------|---------|-------------------|
| `llama-tokenize` | Muestra cómo el modelo interpreta tu texto | Optimizar prompts, entender límites |
| `llama-bench` | Mide rendimiento en tu hardware | Comparar modelos, optimizar configuración |
| `llama-embedding` | Convierte texto en vectores numéricos | Búsqueda semántica, análisis de similitud |

### 3. Herramientas de Optimización

| Herramienta | Propósito | Cuándo es Necesaria |
|-------------|-----------|-------------------|
| `llama-quantize` | Comprime modelos para menos RAM | Tu hardware no soporta el modelo completo |
| `llama-gguf-split` | Divide modelos en fragmentos | Descargas lentas, almacenamiento limitado |
| `llama-gguf-hash` | Verifica integridad de archivos | Asegurar descargas correctas |

---

## ⚙️ Parámetros Esenciales

### Básicos (Imprescindibles)

| Parámetro | Función | Valores Típicos | Ejemplo Práctico |
|-----------|---------|----------------|------------------|
| `-m` | Ruta al modelo | Ruta absoluta | `-m ~/modelos/mistral-7b.gguf` |
| `-p` | Tu prompt/pregunta | Texto libre | `-p "Explica la fotosíntesis"` |
| `-n, --n-predict` | Tokens máximos a generar | 128-2048 | `-n 512` (respuesta media) |
| `-c, --ctx-size` | Tamaño del contexto | 512-16384 | `-c 4096` (documento largo) |

### Control de Contexto y Memoria

| Configuración | Uso de RAM Aprox. | Escenario Ideal |
|---------------|-------------------|-----------------|
| `--ctx-size 1024` | ~1-2MB | Chat básico, preguntas cortas |
| `--ctx-size 2048` | ~2-4MB | Conversaciones normales |
| `--ctx-size 4096` | ~4-8MB | Documentos medianos, análisis |
| `--ctx-size 8192` | ~8-16MB | Textos largos, investigación |
| `--ctx-size 16384` | ~16-32MB | Documentos muy extensos |

### Control de Creatividad

| Temperatura | Comportamiento | Casos de Uso |
|-------------|----------------|--------------|
| `--temp 0.1` | **Robot**: Muy determinista | Código, correcciones, datos precisos |
| `--temp 0.3` | **Técnico**: Preciso pero flexible | Documentación, explicaciones |
| `--temp 0.7` | **Humano**: Equilibrio natural | Conversación general |
| `--temp 0.9` | **Creativo**: Dinámico | Brainstorming, ideas |
| `--temp 1.2` | **Artista**: Muy experimental | Ficción, narrativa libre |

### Control de Calidad de Salida

| Parámetro | Efecto | Valor Conservador | Valor Creativo |
|-----------|--------|------------------|----------------|
| `--top-p` | Variedad de vocabulario | 0.9 | 0.95 |
| `--top-k` | Límite de opciones | 20-40 | 80-100 |
| `--repeat-penalty` | Previene repeticiones | 1.1 | 1.05 |
| `--repeat-last-n` | Ventana anti-repetición | 64 | 128 |

### Optimización de Rendimiento

| Parámetro | Función | Configuración Típica |
|-----------|---------|---------------------|
| `-t, --threads` | Hilos de CPU | Número de cores disponibles |
| `--batch-size` | Procesamiento por lotes | 512-2048 (según RAM) |
| `--gpu-layers` | Capas en GPU | 99 (usar toda la GPU disponible) |

---

## 📋 Recetas por Especialidad

### 🔧 Corrección y Edición de Texto

```bash
# Corrección precisa de documentos
./llama-cli \
    -m ./modelos/mistral-7b-instruct.gguf \
    -p "Corrige errores ortográficos y gramaticales: $(cat documento.txt)" \
    -c 4096 \
    -n 512 \
    --temp 0.2 \
    --top-p 0.9 \
    --repeat-penalty 1.1 \
    --silent
```

### 💻 Análisis y Revisión de Código

```bash
# Revisión de código con análisis detallado
./llama-cli \
    -m ./modelos/deepseek-coder.gguf \
    -p "Analiza este código y sugiere mejoras: $(cat script.py)" \
    -c 8192 \
    -n 1024 \
    --temp 0.1 \
    --repeat-penalty 1.1 \
    --silent
```

### 🎨 Generación Creativa

```bash
# Escritura creativa con alta expresividad
./llama-cli \
    -m ./modelos/chronos-hermes.gguf \
    -p "Escribe una historia épica sobre el despertar de una IA" \
    -c 4096 \
    -n 1500 \
    --temp 0.9 \
    --top-p 0.95 \
    --repeat-penalty 1.05
```

### 🔍 Análisis de Documentos Extensos

```bash
# Procesamiento de contexto muy largo
./llama-cli \
    -m ./modelos/llama-70b.gguf \
    -p "Resume y analiza este documento completo: $(cat documento_largo.txt)" \
    -c 16384 \
    -n 2048 \
    --temp 0.5 \
    --top-p 0.9 \
    --repeat-penalty 1.1 \
    -t 8
```

### 💬 Conversación Natural

```bash
# Chat interactivo con memoria
./llama-run \
    -m ./modelos/openchat.gguf \
    --repeat-penalty 1.1 \
    --temp 0.7 \
    -c 2048 \
    -i
```

---

## 🧪 Estrategias por Tipo de Tarea

### Tareas Técnicas y Factuales
```bash
# Configuración para precisión máxima
--temp 0.1-0.3 --top-p 0.9 --repeat-penalty 1.1
# Modelos recomendados: Coder, Medical, Technical
```

### Conversación y Explicaciones
```bash
# Configuración balanceada y natural
--temp 0.6-0.8 --top-p 0.9 --repeat-penalty 1.1 --repeat-last-n 64
# Modelos recomendados: Chat, General-purpose, Instruction-following
```

### Creatividad y Brainstorming
```bash
# Configuración para máxima expresividad
--temp 0.8-1.2 --top-p 0.95 --repeat-penalty 1.05
# Modelos recomendados: Creative, Storytelling, Roleplay
```

### Investigación y Análisis
```bash
# Configuración para profundidad analítica
--temp 0.3-0.5 --top-p 0.9 -c 8192+ --n-predict 1024+
# Modelos recomendados: Large context, Academic, Research-focused
```

---

## 🚀 Automatización e Integración

### Script de Selección Automática de Modelo

```bash
#!/bin/bash
# Selector inteligente basado en tipo de tarea

select_model_by_task() {
    local task="$1"
    local base_path="./modelos"
    
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

# Uso del selector
TASK_TYPE="$1"
MODELO=$(select_model_by_task "$TASK_TYPE")
PROMPT="$2"

./llama-cli -m "$MODELO" -p "$PROMPT" -c 4096 -n 512 --temp 0.7
```

### Servidor Multi-Modelo

```bash
#!/bin/bash
# Lanzar múltiples modelos como servicios

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
    
    echo "✅ $model_name servidor iniciado en puerto $port"
}

# Iniciar servicios especializados
start_model_server "./modelos/mistral-general.gguf" 8080 "General"
start_model_server "./modelos/deepseek-coder.gguf" 8081 "Código"
start_model_server "./modelos/creative-model.gguf" 8082 "Creativo"

echo "🌐 Servidores disponibles:"
echo "  General: http://localhost:8080"
echo "  Código: http://localhost:8081" 
echo "  Creativo: http://localhost:8082"
```

### Pipeline de Procesamiento de Documentos

```bash
#!/bin/bash
# Pipeline completo: OCR → Corrección → Análisis

process_document() {
    local input_image="$1"
    local output_dir="./processed"
    
    mkdir -p "$output_dir"
    
    # 1. OCR del documento
    tesseract "$input_image" "$output_dir/raw_text"
    
    # 2. Corrección con IA
    ./llama-cli \
        -m ./modelos/correction-model.gguf \
        -p "Corrige errores en este texto: $(cat "$output_dir/raw_text.txt")" \
        -c 4096 -n 1024 --temp 0.2 --silent \
        > "$output_dir/corrected_text.txt"
    
    # 3. Análisis y resumen
    ./llama-cli \
        -m ./modelos/analysis-model.gguf \
        -p "Resume los puntos clave: $(cat "$output_dir/corrected_text.txt")" \
        -c 2048 -n 256 --temp 0.5 --silent \
        > "$output_dir/summary.txt"
    
    echo "✅ Documento procesado en $output_dir"
}

# Usar el pipeline
process_document "documento_escaneado.png"
```

---

## 🛡 Solución de Problemas Comunes

### Modelos Muy Grandes (70B+)
**Síntoma**: Sistema lento o sin memoria suficiente
**Soluciones**:
```bash
# Reducir uso de memoria
-c 2048              # Menos contexto
-t 4                 # Menos hilos
--gpu-layers 50      # Solo parte en GPU
# O usar cuantización más agresiva (Q4_K_S)
```

### Modelos de Código
**Síntoma**: Respuestas incompletas o código cortado
**Soluciones**:
```bash
-n 2048              # Más tokens de salida
--temp 0.1           # Máxima precisión
-c 8192              # Más contexto para código largo
--ignore-eos         # No cortar prematuramente
```

### Modelos Creativos
**Síntoma**: Repetición o pérdida de coherencia
**Soluciones**:
```bash
--repeat-penalty 1.1  # Penalizar repeticiones
--mirostat 2          # Control automático
--temp 0.8            # No exceder temperatura
-c 4096+              # Más contexto para coherencia
```

### Detección de Problemas de Rendimiento
```bash
# Monitorear uso de recursos
watch -n 1 'ps aux | grep llama-cli'

# Benchmark rápido
./llama-bench -m modelo.gguf -p 512 -n 128

# Test de memoria
./llama-cli -m modelo.gguf -c 1024 -n 10 --temp 0.1 -p "Test"
```

---

## 🎯 Configuración Productiva

### Variables de Entorno Útiles

```bash
# Añadir a tu .bashrc o .zshrc
export LLAMA_HOME="./llama.cpp/build/bin"
export MODELS_DIR="./modelos"

# Aliases para uso rápido
alias llama='$LLAMA_HOME/llama-cli -m $MODELS_DIR/general-model.gguf'
alias llama-code='$LLAMA_HOME/llama-cli -m $MODELS_DIR/code-model.gguf'
alias llama-creative='$LLAMA_HOME/llama-cli -m $MODELS_DIR/creative-model.gguf'

# Configuraciones predefinidas
alias quick-fix='llama -n 256 --temp 0.2 --repeat-penalty 1.1 --silent -p'
alias code-review='llama-code -c 8192 -n 1024 --temp 0.1 --silent -p'
alias brainstorm='llama-creative -c 4096 -n 800 --temp 0.9 --top-p 0.95 -p'
```

### Script de Benchmark Completo

```bash
#!/bin/bash
# Evaluar el rendimiento de todos tus modelos

benchmark_all() {
    local models_dir="$1"
    
    echo "📊 BENCHMARK DE MODELOS"
    echo "======================"
    
    for model in "$models_dir"/*.gguf; do
        model_name=$(basename "$model" .gguf)
        echo "🧪 Evaluando: $model_name"
        
        ./llama-bench \
            -m "$model" \
            -p 512 \
            -n 128 \
            -t $(nproc) 2>/dev/null | \
            grep "llama_print_timings" || echo "❌ Error en $model_name"
        echo ""
    done
    
    echo "✅ Benchmark completado"
}

# Ejecutar benchmark
benchmark_all "./modelos"
```

---

## 📚 Referencias Técnicas

### Formatos de Cuantización (Ordenados por Calidad/Tamaño)

| Formato | Calidad | Tamaño | Recomendado Para |
|---------|---------|--------|------------------|
| **Q8_0** | 99% | 50% del original | Máxima calidad, hardware potente |
| **Q6_K** | 98% | 60% del original | Equilibrio excelente |
| **Q5_K_M** | 95% | 70% del original | Uso general recomendado |
| **Q4_K_M** | 90% | 50% del original | Hardware limitado |
| **Q4_K_S** | 85% | 45% del original | Máxima compresión útil |

### Comandos de Diagnóstico

```bash
# Verificar integridad de modelo
./llama-gguf-hash -f modelo.gguf

# Análisis de tokenización
./llama-tokenize -m modelo.gguf -p "Tu texto aquí"

# Test rápido de funcionalidad
./llama-cli -m modelo.gguf -p "2+2=" -n 5 --temp 0.1

# Información del modelo
./llama-cli -m modelo.gguf --help | head -20
```

### Próximos Pasos Recomendados

1. **Experimenta con temperaturas** para diferentes tipos de tareas
2. **Configura aliases** para tus workflows más comunes  
3. **Prueba el modo servidor** para integrar con otras aplicaciones
4. **Optimiza el contexto** según el tipo de documentos que procesas
5. **Automatiza la selección** de modelos según el contenido

---

> **Estructura típica**: `./llama.cpp/build/bin/` (binarios) y `./modelos/` (archivos .gguf)
> 
> **Instalación**: Compilar llama.cpp desde el repositorio oficial de GitHub

¡Tienes todo lo necesario para dominar tu ecosistema de IA local!
