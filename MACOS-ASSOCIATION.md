# Association des fichiers .mdmc sous macOS

Ce guide explique comment faire en sorte que les fichiers `.mdmc` apparaissent comme des fichiers Markdown sous macOS (même icône et aperçu dans Quick Look).

## ✅ Ce qui fonctionne déjà

Après avoir exécuté `setup-mdmc-association.sh`, les fichiers `.mdmc` :

- S'ouvrent automatiquement avec Visual Studio Code (ou l'app choisie)
- Bénéficient de la coloration syntaxique Markdown dans VS Code
- Peuvent être ouverts avec un double-clic

## 🎯 Pour l'apparence visuelle (icône et aperçu)

Sur macOS moderne (Sequoia 15.x), il existe plusieurs approches :

### Méthode 1: Association temporaire (immédiate)

```bash
# Exécuter le script d'association
./setup-mdmc-association.sh
```

### Méthode 2: UTI personnalisée (persistante mais nécessite un redémarrage)

```bash
# Installer la déclaration UTI
./install-mdmc-type.sh

# Redémarrer le système pour la prise en compte complète
sudo reboot
```

### Méthode 3: Association manuelle (recommandée)

1. Clic droit sur un fichier `.mdmc` → **Obtenir des informations**
2. Dans la section **Ouvrir avec**, choisir une application Markdown
3. Cliquer sur **Tout modifier...** pour appliquer à tous les fichiers `.mdmc`
4. L'icône peut changer pour refléter l'application associée

## 🔍 Vérification

Utilisez le script de vérification pour contrôler l'état :

```bash
./verify-mdmc-type.sh
```

## 📝 État actuel

- ✅ **Extension VS Code** : Les fichiers `.mdmc` sont reconnus avec coloration syntaxique
- ✅ **Association d'application** : Les fichiers s'ouvrent avec l'app choisie  
- ⚠️  **Apparence système** : Type dynamique, peut nécessiter un redémarrage

## 🛠️ Dépannage

Si les changements visuels ne sont pas visibles :

1. **Redémarrer le Finder** :

   ```bash
   killall Finder
   ```

2. **Vider les caches** :

   ```bash
   rm -rf ~/Library/Caches/com.apple.iconservices.store
   ```

3. **Redémarrer complètement le Mac** (solution la plus efficace)

4. **Forcer l'association manuelle** via Obtenir des informations

## 📚 Explication technique

macOS utilise plusieurs systèmes pour gérer les types de fichiers :

1. **UTI (Uniform Type Identifiers)** : Système moderne d'identification des types
2. **LaunchServices** : Gestion des associations application ↔ fichier  
3. **Cache système** : Stockage des icônes et métadonnées

Les fichiers avec des extensions non standards reçoivent un type "dynamique" (`dyn.xxx`) jusqu'à ce qu'une UTI explicite soit enregistrée et reconnue par le système.

## 🎉 Résultat attendu

Après configuration complète et redémarrage :

- Les fichiers `.mdmc` devraient apparaître avec une icône Markdown
- Quick Look devrait afficher un aperçu formaté du contenu Markdown
- L'association avec VS Code (ou l'app choisie) sera permanente
