TEX       = xelatex
TEXFLAGS  = -shell-escape -file-line-error -halt-on-error
BIB       = bibtex
BIBFLAGS  = -terse
REFS      = references.bib
ALL       = beamer.pdf beamer_handout.pdf

.PHONY: all
all: $(ALL)

.PHONY: clean
clean:
	-$(RM) -r *.aux *.bbl *.blg *.lof *.log *.lol *.lot *.nav *.out *.pdf \
	          *.snm *.synctex *.toc *.thm *.pyg _minted*

book.pdf: book.tex book.bbl book.blg

%.pdf: %.tex
	$(TEX) $(TEXFLAGS) $<
	$(TEX) $(TEXFLAGS) $<

%_handout.pdf: %.tex
	$(TEX) $(TEXFLAGS) -jobname "$(@:.pdf=)" "\PassOptionsToClass{handout}{beamer}\input{$<}"
	$(TEX) $(TEXFLAGS) -jobname "$(@:.pdf=)" "\PassOptionsToClass{handout}{beamer}\input{$<}"

%.bbl %.blg: $(REFS) %.aux
	$(BIB) $(BIBFLAGS) $*

%.aux: %.tex
	$(TEX) $(TEXFLAGS) $<
