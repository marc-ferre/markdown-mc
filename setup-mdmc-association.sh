#!/bin/bash

# Script d'association simple avec duti
# Plus fiable que les UTI personnalisées sur macOS moderne

echo "🔧 Association des fichiers .mdmc avec duti"
echo "=========================================="

# Vérifier que duti est installé
if ! command -v duti &> /dev/null; then
    echo "❌ duti n'est pas installé"
    echo "   Installez avec: brew install duti"
    exit 1
fi

# Identifier les applications qui peuvent ouvrir les fichiers Markdown
echo "🔍 Recherche d'applications compatibles Markdown..."

# Essayer de trouver des applications qui gèrent le Markdown
MARKDOWN_APPS=()

# VS Code
if [ -d "/Applications/Visual Studio Code.app" ]; then
    MARKDOWN_APPS+=("com.microsoft.VSCode")
    echo "   ✅ Visual Studio Code trouvé"
fi

# TextEdit (par défaut sur macOS)
MARKDOWN_APPS+=("com.apple.TextEdit")
echo "   ✅ TextEdit (par défaut)"

# Typora si installé
if [ -d "/Applications/Typora.app" ]; then
    MARKDOWN_APPS+=("abnerworks.Typora")
    echo "   ✅ Typora trouvé"
fi

# MacDown si installé
if [ -d "/Applications/MacDown.app" ]; then
    MARKDOWN_APPS+=("com.uranusjr.macdown")
    echo "   ✅ MacDown trouvé"
fi

if [ ${#MARKDOWN_APPS[@]} -eq 0 ]; then
    echo "❌ Aucune application Markdown trouvée"
    exit 1
fi

# Proposer les options à l'utilisateur
echo ""
echo "📋 Applications disponibles:"
for i in "${!MARKDOWN_APPS[@]}"; do
    APP_NAME=$(osascript -e "tell application \"Finder\" to get name of application file id \"${MARKDOWN_APPS[$i]}\"" 2>/dev/null || echo "${MARKDOWN_APPS[$i]}")
    echo "   $((i+1)). $APP_NAME (${MARKDOWN_APPS[$i]})"
done

# Utiliser VS Code par défaut s'il est disponible, sinon TextEdit
FOUND_VSCODE=false
for app in "${MARKDOWN_APPS[@]}"; do
    if [[ "$app" == "com.microsoft.VSCode" ]]; then
        FOUND_VSCODE=true
        break
    fi
done

if [ "$FOUND_VSCODE" = true ]; then
    DEFAULT_APP="com.microsoft.VSCode"
    DEFAULT_NAME="Visual Studio Code"
else
    DEFAULT_APP="com.apple.TextEdit"
    DEFAULT_NAME="TextEdit"
fi

echo ""
echo "🎯 Application par défaut sélectionnée: $DEFAULT_NAME ($DEFAULT_APP)"

# Créer l'association
echo "🔗 Création de l'association .mdmc → $DEFAULT_NAME..."
duti -s "$DEFAULT_APP" .mdmc all

# Vérifier l'association
echo "✅ Association créée!"
DEFAULT_HANDLER=$(duti -x mdmc 2>/dev/null || echo "Aucune")
echo "   Handler par défaut pour .mdmc: $DEFAULT_HANDLER"

# Test avec un fichier existant
if [ -f "simple-test.mdmc" ]; then
    echo ""
    echo "🧪 Test de l'association..."
    echo "   Ouverture de simple-test.mdmc avec l'application par défaut..."
    open simple-test.mdmc
fi

echo ""
echo "✅ Configuration terminée!"
echo ""
echo "📝 Pour modifier l'association:"
echo "   - Clic droit sur un fichier .mdmc → Obtenir des informations"
echo "   - Dans 'Ouvrir avec', choisir l'app souhaitée"
echo "   - Cliquer sur 'Tout modifier...'"