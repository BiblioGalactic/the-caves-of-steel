Guide complet de llama.cpp — Votre IA locale dans le terminal

Un guide pratique pour maîtriser l’écosystème des modèles d’IA locaux

⸻

🧠 Concepts fondamentaux (pour bien commencer)

Qu’est-ce qu’un fichier .gguf ?

C’est comme un fichier ZIP mais pour les modèles d’IA. Il contient tout le nécessaire :
	•	L’architecture du modèle (comment il est construit)
	•	Les poids neuronaux (la « connaissance » entraînée)
	•	Le tokenizer (comment il transforme le texte en nombres)
	•	Les métadonnées et la configuration

C’est pourquoi ils sont portables : on copie le fichier et on a l’IA complète.

Qu’est-ce que la quantification ?

Imaginez une photo en 4K vs la même photo compressée en JPEG :
	•	F16 : Précision maximale, consommation de RAM élevée
	•	Q8_0 : Presque sans perte, ~50 % de RAM en moins
	•	Q6_K : Excellent équilibre qualité/taille
	•	Q5_K_M : Bonne qualité, compact
	•	Q4_K_M : Standard recommandé pour la plupart des usages
	•	Q4_K_S : Très compact, perte notable mais utilisable

Tokens : la « monnaie » de l’IA

Les modèles ne lisent pas des mots, ils lisent des tokens :
	•	"Hola" = 1 token
	•	"artificial" = 2 tokens ("art" + "ificial")
	•	"🤖" = 1 token

Règle pratique : 1 token ≈ 0,75 mot en espagnol/français.

⸻

🎯 Types de modèles et leurs spécialités

Par langue et domaine

Spécialité	Langue principale	Style	Cas d’usage typiques
Technique / Allemand	Allemand	Formel, normatif	Documents officiels, traductions précises
Programmation	Anglais	Analyse structurée	Debugging, architecture, revue de code
Japonais	Japonais	Impératifs, instructions	Documentation technique japonaise
Contexte long	Multilingue	Connaissance large	Analyses complexes, recherche
Général / Équilibré	Anglais	Génération fluide	Usage quotidien, tâches variées
Médical / Clinique	Anglais	Clinique, biomédical	Textes médicaux, pharmaceutiques
Conversationnel	Anglais	Dialogue naturel	Chat, support client
Documentation	Anglais	Explications structurées	Manuels, guides techniques
Compact / Rapide	Anglais	Raisonnement efficace	Tests rapides, hardware limité
Multi-langue	Chinois / Anglais	Contexte étendu	Documents internationaux
Ultra léger	Anglais	Tests rapides	Développement, IoT, expériences
Python spécialisé	Anglais	Tutoriels détaillés	Enseignement de la programmation
Académique	Chinois / Anglais	Articles scientifiques	Recherche, textes techniques
Juridique / Formel	Anglais	Institutionnel	Contrats, politiques, conformité
Automatisation	Anglais	Décisions complexes	Workflows, gestion de processus
Base sans filtres	Anglais	Neutre	Expériences, réponses directes
Narratif	Anglais	Mythologique, storytelling	Worldbuilding, fiction épique
Créatif expressif	Anglais	Dramatique, émotionnel	Fiction, roleplay créatif
Philosophique	Anglais	Dialogue socratique	Débats, pensée critique
Sans censure	Anglais	Sujets sensibles	Recherche sécurité
Roleplay avancé	Anglais	Narration libre	Roleplay, exploration créative


⸻

🛠 Outils de l’écosystème

1. Noyau d’exécution

Binaire	Fonction principale	Quand l’utiliser
llama-cli	Moteur principal. Exécute les modèles depuis le terminal	Scripts, automatisation, tests rapides
llama-run	Chat interactif avec mémoire de conversation	Expérimenter, dialoguer avec des modèles
llama-server	Serveur web avec API REST	Intégration applicative, usage à distance

2. Outils d’analyse

Outil	Fonction	Utilité pratique
llama-tokenize	Montre comment le modèle interprète votre texte	Optimiser les prompts, comprendre les limites
llama-bench	Mesure les performances sur votre hardware	Comparer modèles, optimiser config
llama-embedding	Transforme du texte en vecteurs numériques	Recherche sémantique, similarité

3. Outils d’optimisation

Outil	But	Quand l’utiliser
llama-quantize	Compresse les modèles pour réduire la RAM	Si votre hardware ne supporte pas le modèle complet
llama-gguf-split	Divise les modèles en fragments	Téléchargements lents, stockage limité
llama-gguf-hash	Vérifie l’intégrité des fichiers	S’assurer de téléchargements corrects


⸻

⚙️ Paramètres essentiels

Basique (indispensable)

Paramètre	Fonction	Valeurs typiques	Exemple pratique
-m	Chemin vers le modèle	Chemin absolu	-m ~/modelos/mistral-7b.gguf
-p	Votre prompt / question	Texte libre	-p "Explique la photosynthèse"
-n, --n-predict	Tokens max à générer	128–2048	-n 512 (réponse moyenne)
-c, --ctx-size	Taille du contexte	512–16384	-c 4096 (document long)

Contrôle du contexte et mémoire

Configuration	RAM approximative	Scénario idéal
--ctx-size 1024	~1–2 MB	Chat basique, questions courtes
--ctx-size 2048	~2–4 MB	Conversations normales
--ctx-size 4096	~4–8 MB	Documents moyens, analyses
--ctx-size 8192	~8–16 MB	Textes longs, recherche
--ctx-size 16384	~16–32 MB	Documents très volumineux

Contrôle de la créativité

Température	Comportement	Cas d’usage
--temp 0.1	Robot : très déterministe	Code, corrections, données précises
--temp 0.3	Technique : précis mais flexible	Documentation, explications
--temp 0.7	Humain : équilibre naturel	Conversation générale
--temp 0.9	Créatif : dynamique	Brainstorming, idées
--temp 1.2	Artiste : très expérimental	Fiction, narration libre

Contrôle de la qualité de sortie

Paramètre	Effet	Valeur conservatrice	Valeur créative
--top-p	Variété lexicale	0.9	0.95
--top-k	Limite d’options	20–40	80–100
--repeat-penalty	Empêche les répétitions	1.1	1.05
--repeat-last-n	Fenêtre anti-répétition	64	128

Optimisation des performances

Paramètre	Fonction	Configuration typique
-t, --threads	Threads CPU	Nombre de cœurs disponibles
--batch-size	Traitement par lots	512–2048 (selon RAM)
--gpu-layers	Couches sur GPU	99 (utiliser toute la GPU disponible)


⸻

📋 Recettes par spécialité

🔧 Correction et édition de texte

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

Remarque : les blocs de code sont laissés tels quels (commandes inchangées) pour rester immédiatement utilisables.

💻 Analyse et revue de code

# Revisión de código con análisis detallado
./llama-cli \
    -m ./modelos/deepseek-coder.gguf \
    -p "Analiza este código y sugiere mejoras: $(cat script.py)" \
    -c 8192 \
    -n 1024 \
    --temp 0.1 \
    --repeat-penalty 1.1 \
    --silent

🎨 Génération créative

# Escritura creativa con alta expresividad
./llama-cli \
    -m ./modelos/chronos-hermes.gguf \
    -p "Escribe una historia épica sobre el despertar de una IA" \
    -c 4096 \
    -n 1500 \
    --temp 0.9 \
    --top-p 0.95 \
    --repeat-penalty 1.05

🔍 Analyse de documents volumineux

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

💬 Conversation naturelle

# Chat interactivo con memoria
./llama-run \
    -m ./modelos/openchat.gguf \
    --repeat-penalty 1.1 \
    --temp 0.7 \
    -c 2048 \
    -i


⸻

🧪 Stratégies selon le type de tâche

Tâches techniques et factuelles

# Configuración para precisión máxima
--temp 0.1-0.3 --top-p 0.9 --repeat-penalty 1.1
# Modelos recomendados: Coder, Medical, Technical

Conversation et explications

# Configuración balanceada y natural
--temp 0.6-0.8 --top-p 0.9 --repeat-penalty 1.1 --repeat-last-n 64
# Modelos recomendados: Chat, General-purpose, Instruction-following

Créativité et brainstorming

# Configuración para máxima expresividad
--temp 0.8-1.2 --top-p 0.95 --repeat-penalty 1.05
# Modelos recomendados: Creative, Storytelling, Roleplay

Recherche et analyse

# Configuración para profundidad analítica
--temp 0.3-0.5 --top-p 0.9 -c 8192+ --n-predict 1024+
# Modelos recomendados: Large context, Academic, Research-focused


⸻

🚀 Automatisation et intégration

Script de sélection automatique de modèle

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

Serveur multi-modèles

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

Pipeline de traitement de documents

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


⸻

🛡 Résolution des problèmes courants

Modèles très grands (70B+)

Symptôme : système lent ou manque de mémoire
Solutions :

# Réduire l’usage mémoire
-c 2048              # Moins de contexte
-t 4                 # Moins de threads
--gpu-layers 50      # Seulement une partie sur GPU
# Ou utiliser une quantification plus agressive (Q4_K_S)

Modèles orientés code

Symptôme : réponses incomplètes ou code coupé
Solutions :

-n 2048              # Plus de tokens de sortie
--temp 0.1           # Précision maximale
-c 8192              # Plus de contexte pour code long
--ignore-eos         # Ne pas couper prématurément

Modèles créatifs

Symptôme : répétitions ou perte de cohérence
Solutions :

--repeat-penalty 1.1  # Pénaliser les répétitions
--mirostat 2          # Contrôle automatique
--temp 0.8            # Ne pas dépasser la température
-c 4096+              # Plus de contexte pour la cohérence

Détection des problèmes de performance

# Surveiller l’utilisation des ressources
watch -n 1 'ps aux | grep llama-cli'

# Benchmark rapide
./llama-bench -m modelo.gguf -p 512 -n 128

# Test mémoire
./llama-cli -m modelo.gguf -c 1024 -n 10 --temp 0.1 -p "Test"


⸻

🎯 Configuration productive

Variables d’environnement utiles

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

Script de benchmark complet

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


⸻

📚 Références techniques

Formats de quantification (triés par qualité/taille)

Format	Qualité	Taille	Recommandé pour
Q8_0	99%	50% de l’original	Qualité maximale, hardware puissant
Q6_K	98%	60% de l’original	Excellent équilibre
Q5_K_M	95%	70% de l’original	Usage général recommandé
Q4_K_M	90%	50% de l’original	Hardware limité
Q4_K_S	85%	45% de l’original	Compression maximale utile

Commandes de diagnostic

# Verificar integridad de modelo
./llama-gguf-hash -f modelo.gguf

# Análisis de tokenización
./llama-tokenize -m modelo.gguf -p "Tu texto aquí"

# Test rápido de funcionalidad
./llama-cli -m modelo.gguf -p "2+2=" -n 5 --temp 0.1

# Información del modelo
./llama-cli -m modelo.gguf --help | head -20

Prochaines étapes recommandées
	1.	Expérimentez avec les températures pour différents types de tâches
	2.	Configurez des alias pour vos workflows les plus courants
	3.	Testez le mode serveur pour intégrer à d’autres applications
	4.	Optimisez le contexte selon le type de documents traités
	5.	Automatisez la sélection des modèles selon le contenu

⸻

Structure typique : ./llama.cpp/build/bin/ (binaires) et ./modelos/ (fichiers .gguf)

Installation : Compiler llama.cpp depuis le dépôt officiel GitHub

Vous avez tout ce qu’il faut pour maîtriser votre écosystème d’IA local !

Eto Demerzel (Gustavo Silva Da Costa)
https://etodemerzel.gumroad.com
https://github.com/BiblioGalactic