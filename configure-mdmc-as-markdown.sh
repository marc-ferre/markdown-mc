#!/bin/bash

# Script pour associer les fichiers .mdmc au type Markdown
# Cela permettra d'avoir la même icône et le même aperçu que les fichiers .md

echo "Association des fichiers .mdmc au type Markdown..."

# Méthode 1: Via UTI (Uniform Type Identifier)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Méthode 2: Via duti avec le bon identifiant d'application
# Trouver l'application par défaut pour .md
echo "Application par défaut pour .md:"
duti -x md

# Associer .mdmc à la même application
DEFAULT_MD_APP=$(duti -x md | head -n1 | awk '{print $NF}' | tr -d '()')
if [ ! -z "$DEFAULT_MD_APP" ]; then
    echo "Association de .mdmc à $DEFAULT_MD_APP"
    duti -s "$DEFAULT_MD_APP" .mdmc all
    echo "✓ Association effectuée"
else
    echo "⚠️  Impossible de détecter l'application par défaut pour .md"
fi

# Méthode 3: Association directe au type de contenu
echo "Association au type de contenu Markdown..."
# Utiliser l'UTI markdown
/usr/bin/plutil -insert LSItemContentTypes.0 -string "net.daringfireball.markdown" /dev/stdin << EOF 2>/dev/null || true
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>UTExportedTypeDeclarations</key>
    <array>
        <dict>
            <key>UTTypeIdentifier</key>
            <string>net.daringfireball.markdown.mdmc</string>
            <key>UTTypeConformsTo</key>
            <array>
                <string>net.daringfireball.markdown</string>
                <string>public.plain-text</string>
            </array>
            <key>UTTypeTagSpecification</key>
            <dict>
                <key>public.filename-extension</key>
                <array>
                    <string>mdmc</string>
                </array>
            </dict>
        </dict>
    </array>
</dict>
</plist>
EOF

echo "Redémarrage de LaunchServices..."
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -r -domain local -domain system -domain user

echo "Nettoyage du cache d'icônes..."
sudo rm -rf /Library/Caches/com.apple.iconservices.store
rm -rf ~/Library/Caches/com.apple.iconservices.store
killall Finder
killall Dock

echo "✅ Configuration terminée."
echo "Les fichiers .mdmc devraient maintenant apparaître comme des fichiers Markdown."
echo "Si les changements ne sont pas visibles immédiatement, redémarrez votre Mac."