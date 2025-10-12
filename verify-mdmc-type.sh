#!/bin/bash

# Script de vérification de l'association .mdmc

echo "🔍 Vérification de l'association .mdmc → Markdown"
echo "================================================"

# Vérifier que le fichier UTI est installé
UTI_FILE="$HOME/Library/Application Support/UTI/mdmc-type.plist"
if [ -f "$UTI_FILE" ]; then
    echo "✅ Fichier UTI installé: $UTI_FILE"
else
    echo "❌ Fichier UTI manquant: $UTI_FILE"
fi

# Vérifier les fichiers de test
echo ""
echo "📝 Test des fichiers .mdmc:"
for file in *.mdmc; do
    if [ -f "$file" ]; then
        echo "   Fichier: $file"
        CONTENT_TYPE=$(mdls -name kMDItemContentType "$file" 2>/dev/null | cut -d'"' -f2)
        echo "   Type: $CONTENT_TYPE"
        
        # Vérifier si c'est reconnu comme Markdown
        if [[ "$CONTENT_TYPE" == *"markdown"* ]] || [[ "$CONTENT_TYPE" == "net.daringfireball.markdown" ]] || [[ "$CONTENT_TYPE" == "com.marcferre.mdmc" ]]; then
            echo "   Status: ✅ Reconnu comme Markdown"
        else
            echo "   Status: ⚠️  Type dynamique ($CONTENT_TYPE)"
        fi
        echo ""
    fi
done

# Informations système
echo "ℹ️  Informations système:"
echo "   macOS: $(sw_vers -productVersion)"
echo "   Architecture: $(uname -m)"

# Instructions
echo ""
echo "📋 Instructions de dépannage:"
echo "   1. Si le type est encore 'dyn.xxx', essayez:"
echo "      - Redémarrer le Finder: killall Finder"
echo "      - Redémarrer complètement le Mac"
echo "   2. Pour forcer la reconnaissance:"
echo "      - Clic droit sur un fichier .mdmc → Obtenir des informations"
echo "      - Changer 'Ouvrir avec' vers une app Markdown"
echo "   3. Pour désinstaller: rm '$UTI_FILE'"