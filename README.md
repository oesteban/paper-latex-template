# Paper Template

This folder is a LaTeX template configured to build cleanly with placeholder
content and minimal external dependencies.

## Build workflows

- Baseline template build (recommended for empty/new projects):
  - `make pdf`
- Full-content build (bibliography + shell-escape features enabled):
  - `make pdf-content`

## Template feature toggles (`main.tex`)

The template defaults to a minimal setup:

- `\templatebibliographyfalse`
- `\templatesvgfalse`
- `\templatemintedfalse`

Enable the corresponding `...true` toggles when needed.

- `\templatebibliographytrue`:
  - Enables `\bibliography{references}` output.
- `\templatesvgtrue`:
  - Loads `svg` package in safe mode (`inkscape=false, inkscapeversion=1`) by default.
  - To convert SVGs on the fly, switch package option to `inkscape=true`.
- `\templatemintedtrue`:
  - Enables `minted` support for syntax highlighting.

## Fonts

The template now builds without project-local custom font files.
By default, `nmeth.cls` uses TeX Live bundled fonts:

- Main text: `TeX Gyre Termes`
- Sans-serif: `TeX Gyre Heros`
- Monospace: `Latin Modern Mono`
- Math: `TeX Gyre Termes Math`

To use a custom font family, edit `main.tex` and uncomment the provided example:

```tex
% \ifdefined\setmainfont
%   \setmainfont{Your Font Family Name}
% \fi
```

Keep this example to one family unless you have a specific need for separate
sans/mono overrides.

## Dependencies

| Feature | Required tools |
| --- | --- |
| Baseline build (`make pdf`) | TeX Live with LuaLaTeX + latexmk |
| Bibliography (`\templatebibliographytrue`) | BibTeX |
| Minted (`\templatemintedtrue`) | Pygments (`pygmentize`) + shell-escape |
| SVG conversion (`inkscape=true`) | Inkscape + shell-escape |

## Troubleshooting

- If `make pdf` fails with `luaotfload ... no writeable cache path`, verify
  that `TEXMFVAR` and `TEXMFCACHE` point to writable directories. If your TeX
  setup still blocks cache writes in restricted mode, run `make pdf-content`
  (uses shell-escape) to complete the build.
- `make pdf` will automatically run a one-time shell-escape warm-up when the
  LuaTeX cache is missing.
