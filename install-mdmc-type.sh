#!/bin/bash

# Script d'installation pour associer les fichiers .mdmc au type Markdown
# Ce script installe une déclaration UTI personnalisée

set -e

PLIST_FILE="mdmc-type.plist"
INSTALL_DIR="$HOME/Library/Application Support/UTI"
DEST_FILE="$INSTALL_DIR/mdmc-type.plist"

echo "🔧 Installation de l'association .mdmc → Markdown"
echo "================================================"

# Vérifier que le fichier plist existe
if [ ! -f "$PLIST_FILE" ]; then
    echo "❌ Erreur: Le fichier $PLIST_FILE n'existe pas"
    exit 1
fi

# Créer le répertoire de destination
echo "📁 Création du répertoire UTI..."
mkdir -p "$INSTALL_DIR"

# Copier le fichier plist
echo "📋 Installation de la déclaration UTI..."
cp "$PLIST_FILE" "$DEST_FILE"

# Vérifier que le fichier a été copié
if [ -f "$DEST_FILE" ]; then
    echo "✅ Fichier installé: $DEST_FILE"
else
    echo "❌ Erreur: Installation échouée"
    exit 1
fi

# Recharger LaunchServices pour prendre en compte la nouvelle UTI
echo "🔄 Rechargement de LaunchServices..."
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain user

# Vider le cache des icônes
echo "🧹 Nettoyage du cache des icônes..."
rm -rf ~/Library/Caches/com.apple.iconservices.store 2>/dev/null || true

# Redémarrer le Finder
echo "🔄 Redémarrage du Finder..."
killall Finder 2>/dev/null || true

echo ""
echo "✅ Installation terminée !"
echo ""
echo "📝 Instructions:"
echo "   1. Les fichiers .mdmc devraient maintenant apparaître comme des fichiers Markdown"
echo "   2. Si les changements ne sont pas visibles, redémarrez votre Mac"
echo "   3. Pour désinstaller: rm '$DEST_FILE' et relancer lsregister"
echo ""

# Test de l'installation
if [ -f "simple-test.mdmc" ]; then
    echo "🧪 Test de l'association..."
    echo "   Avant: $(mdls -name kMDItemContentType simple-test.mdmc 2>/dev/null || echo 'Type non détecté')"
    sleep 2
    echo "   Après: $(mdls -name kMDItemContentType simple-test.mdmc 2>/dev/null || echo 'Type en cours de mise à jour...')"
fi