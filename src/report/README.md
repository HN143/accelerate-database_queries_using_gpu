# Vietnam University Thesis in Typst

A template for writing university theses using the Typst typesetting system.

## Prerequisites

- [Typst](https://github.com/typst/typst)
  - **MacOS:** `brew install typst`
  - **Windows:** `winget install --id Typst.Typst`

## Usage

### Development Environment

For the best editing experience, we recommend:

- Visual Studio Code with these extensions:
  - **Tinymist Typst**
  - **LaTeX Workshop**

### Generating PDF Output

To automatically compile and watch for changes:

```sh
typst watch main.typ main.pdf
```

Or simply use:

```sh
make watch
```

### PDF Viewing

When using the LaTeX Workshop extension:

1. Execute `LaTeX Workshop: Refresh all LaTeX viewers`
2. Set LaTeX Workshop as the default viewer for PDF files for automatic updates
