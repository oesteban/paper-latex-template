SHELL := /bin/bash

MAIN := main
PDF := $(MAIN).pdf

LATEXMK := latexmk
BIB ?= 0
SHELL_ESCAPE ?= 0
LATEXMK_OPTS := -lualatex -interaction=nonstopmode -halt-on-error -file-line-error

ifeq ($(BIB),0)
LATEXMK_OPTS += -bibtex-
endif
ifeq ($(SHELL_ESCAPE),1)
LATEXMK_OPTS += -shell-escape
endif

# Keep LuaTeX caches writable even in restricted environments.
export TEXMFVAR := $(CURDIR)/.texmf-var
export TEXMFCACHE := $(CURDIR)/.texmf-cache
LUAOTFLOAD_CACHE_MARKER := $(TEXMFCACHE)/luatex-cache/generic/names/luaotfload-names.luc.gz

.PHONY: all pdf pdf-content ensure-font-cache build clean distclean

all: pdf

pdf: ensure-font-cache
	$(MAKE) BIB=0 SHELL_ESCAPE=0 build

pdf-content:
	$(MAKE) BIB=1 SHELL_ESCAPE=1 build

ensure-font-cache:
	@if [ ! -f "$(LUAOTFLOAD_CACHE_MARKER)" ]; then \
		echo "LuaTeX font cache missing; running warm-up build with shell-escape."; \
		$(MAKE) BIB=0 SHELL_ESCAPE=1 build; \
	fi

build:
	mkdir -p "$(TEXMFVAR)" "$(TEXMFCACHE)"
	TEXMFVAR="$(TEXMFVAR)" TEXMFCACHE="$(TEXMFCACHE)" $(LATEXMK) $(LATEXMK_OPTS) $(MAIN).tex

clean:
	mkdir -p "$(TEXMFVAR)" "$(TEXMFCACHE)"
	TEXMFVAR="$(TEXMFVAR)" TEXMFCACHE="$(TEXMFCACHE)" $(LATEXMK) -c $(MAIN).tex
	rm -rf _minted-$(MAIN) $(TEXMFVAR) $(TEXMFCACHE)
	rm -f $(MAIN).bbl $(MAIN).out $(MAIN).suppinfo count.txt
	rm -f *.log

distclean: clean
	mkdir -p "$(TEXMFVAR)" "$(TEXMFCACHE)"
	TEXMFVAR="$(TEXMFVAR)" TEXMFCACHE="$(TEXMFCACHE)" $(LATEXMK) -C $(MAIN).tex
