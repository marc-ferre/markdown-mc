# Markdown-MC Extension for VS Code

[![Release v1.3.1](https://img.shields.io/badge/release-v1.3.1-blue?style=flat-square)](https://github.com/marc-ferre/markdown-mc/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/marc-ferre/markdown-mc/total?style=flat-square)](https://github.com/marc-ferre/markdown-mc/releases)

This extension adds support for the **Markdown-MC** (Multiple Choice) language to create multiple-choice questionnaires in VS Code.

## Features

### Markdown-MC Syntax

- **QCM Identifier**: `## [identifier]`
- **Question**: `### Your question here`
- **Correct Answer**: `+ Correct answer`
- **Incorrect Answer**: `- Incorrect answer`

### Example

```markdown
## [seq2g]

### Among the following sequencing techniques, which one(s) are called high-throughput and "short fragments" (second generation):

- Illumina.
- Ion Torrent.

* Nanopore.
* Sanger (by terminators).
```

### Syntax Highlighting

The extension provides syntax highlighting that works with any VS Code theme:

- **QCM Identifiers** `## [id]` - highlighted as headings with special brackets
- **Questions** `### Question` - highlighted as section headings
- **Correct Answers** `+ Answer` - highlighted as inserted text (usually green)
- **Incorrect Answers** `- Answer` - highlighted as deleted text (usually red)### Available Snippets

- `qcm`: Creates a complete QCM
- `qcmh`: QCM header only
- `quest`: Question only
- `+`: Correct answer
- `-`: Incorrect answer
- `qcm+`: QCM with multiple correct answers
- `qcm1`: QCM with single correct answer

### Validation

The extension automatically checks:

- QCM identifier format
- Presence of a question after each identifier
- General QCM structure

## Installation

### Method 1: From Release (Recommended)

1. Go to the [Releases page](https://github.com/marc-ferre/markdown-mc/releases)
2. Download the latest `markdown-mc-x.x.x.vsix` file
3. In VS Code: `Cmd+Shift+P` → "Extensions: Install from VSIX..."
4. Select the downloaded `.vsix` file

### Method 2: From Source

1. Clone this repository
2. Open the folder in VS Code
3. Press `F5` to launch the extension in development mode
4. In the new VS Code window, open a `.md` file
5. Start typing your QCMs with the Markdown-MC syntax

## Usage

### Option 1: Using .mdmc files (recommended)

1. Create a new file with the `.mdmc` extension
2. The Markdown-MC syntax highlighting will be automatically activated!

### Option 2: Using existing .md files

1. Open any `.md` file in VS Code
2. Change the language mode (bottom right) from "Markdown" to "Markdown-MC"

### Supported File Extensions

- `.mdmc` (automatically detected)
- `.qcm` (automatically detected)
- `.mcq` (automatically detected)
- `.md` (manual mode switch required)

The syntax highlighting works with any VS Code theme you prefer.

## Development

To compile the extension:

```bash
npm install
vsce package
```

To package for distribution:

```bash
npm install -g @vscode/vsce
vsce package
```

## Requirements

- VS Code 1.74.0 or higher
- Node.js and npm for development

## Contributing

Feel free to contribute by suggesting improvements or reporting issues on the [GitHub repository](https://github.com/marc-ferre/markdown-mc).

## License

MIT License - see [LICENSE](LICENSE) file for details.
