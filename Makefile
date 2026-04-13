LATEXMK ?= latexmk
LATEXFLAGS ?= -pdf -interaction=nonstopmode -file-line-error

MAIN_DOC := document2.tex
EXAMPLE_DOC := example.tex
TIKZ_TEMPLATE_DOC := tikz-template-pages.tex
TIKZ_EXAMPLE_DOC := tikz-example.tex
TIKZ_EXAMPLE_LISTING := $(TIKZ_EXAMPLE_DOC:.tex=.listing)
SMOKE_DOC := smoke-packaging.tex
TEST_DOCS := tests/test-basic.tex tests/test-environments.tex tests/test-graphics.tex tests/test-tikz-styles.tex tests/test-wrap-layout.tex tests/test-workflow-guide.tex
TEST_NAMES := test-basic test-environments test-graphics test-tikz-styles test-wrap-layout test-workflow-guide

MAIN_PDF := $(MAIN_DOC:.tex=.pdf)
EXAMPLE_PDF := $(EXAMPLE_DOC:.tex=.pdf)
TIKZ_TEMPLATE_PDF := $(TIKZ_TEMPLATE_DOC:.tex=.pdf)
TIKZ_EXAMPLE_PDF := $(TIKZ_EXAMPLE_DOC:.tex=.pdf)
SMOKE_PDF := $(SMOKE_DOC:.tex=.pdf)
TEST_PDFS := $(TEST_NAMES:%=%.pdf)

.PHONY: all main example tikz-templates tikz-example smoke test clean

all: main example tikz-templates test

main: $(MAIN_PDF)

example: $(EXAMPLE_PDF)

tikz-templates: $(TIKZ_TEMPLATE_PDF)

tikz-example: $(TIKZ_EXAMPLE_PDF)

smoke: $(SMOKE_PDF)

test: smoke $(TEST_PDFS)

%.pdf: %.tex maki-notes.cls maki-notes.sty latexmkrc
	$(LATEXMK) $(LATEXFLAGS) $<

$(TEST_PDFS): %.pdf: tests/%.tex maki-notes.cls maki-notes.sty latexmkrc
	$(LATEXMK) $(LATEXFLAGS) $<

clean:
	$(LATEXMK) -C $(MAIN_DOC)
	$(LATEXMK) -C $(EXAMPLE_DOC)
	$(LATEXMK) -C $(TIKZ_TEMPLATE_DOC)
	$(LATEXMK) -C $(TIKZ_EXAMPLE_DOC)
	rm -f $(TIKZ_EXAMPLE_LISTING)
	$(LATEXMK) -C $(SMOKE_DOC)
	for doc in $(TEST_DOCS); do $(LATEXMK) -C $$doc; done
