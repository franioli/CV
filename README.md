# Academic CV - Francesco Ioli

This repository contains the source code for my academic CV, built with LaTeX.
Based on the [latexcv template by Jan Küster](https://github.com/jankapunkt/latexcv).

## Structure
- `main.tex`: The main content file.
- `cv_style.cls`: Custom LaTeX class defining the layout, colors, and commands.
- `publications.bib`: Bibliography database.
- `assets/`: Folder containing images and icons.

## How to Build
Requirements: `pdflatex`, `biber`.

Run the following commands:
```bash
pdflatex resume.tex
biber main
pdflatex main.tex
pdflatex main.tex
