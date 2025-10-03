# Extension Markdown-MC pour VS Code

Cette extension ajoute le support du langage **Markdown-MC** (Multiple Choice) pour créer des questionnaires à choix multiples dans VS Code.

## Fonctionnalités

### Syntaxe Markdown-MC

- **Identifiant QCM** : `## [identifiant]`
- **Question** : `### Votre question ici`  
- **Bonne réponse** : `+ Réponse correcte`
- **Mauvaise réponse** : `- Réponse incorrecte`

### Exemple

```markdown
## [seq2g]
### Parmi les techniques de séquençage suivantes, laquelle ou lesquelles sont dites haut débit et «courts fragments» (deuxième génération) :

+ Illumina.
+ Ion Torrent.
- Nanopore.
- Sanger (par terminateurs).
```

### Coloration syntaxique

- **Identifiants QCM** en bleu avec crochets mis en évidence
- **Questions** en jaune doré  
- **Bonnes réponses** en vert avec symbole `+` en gras
- **Mauvaises réponses** en rouge avec symbole `-` en gras

### Snippets disponibles

- `qcm` : Crée un QCM complet
- `qcmh` : En-tête de QCM uniquement
- `quest` : Question seule
- `+` : Bonne réponse
- `-` : Mauvaise réponse
- `qcm+` : QCM avec plusieurs bonnes réponses
- `qcm1` : QCM avec une seule bonne réponse

### Validation

L'extension vérifie automatiquement :

- Le format des identifiants QCM
- La présence d'une question après chaque identifiant
- La structure générale des QCM

## Installation

1. Ouvrez le dossier de l'extension dans VS Code
2. Appuyez sur `F5` pour lancer l'extension en mode développement
3. Dans la nouvelle fenêtre VS Code, ouvrez un fichier `.md`
4. Commencez à taper vos QCM avec la syntaxe Markdown-MC

## Développement

Pour compiler l'extension :

```bash
npm install
npm run compile
```

Pour la surveiller en mode développement :

```bash
npm run watch
```

## Configuration requise

- VS Code 1.74.0 ou supérieur
- Node.js et npm pour le développement

## Contribution

N'hésitez pas à contribuer en proposant des améliorations ou en signalant des problèmes.
