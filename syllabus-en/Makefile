## Makefile for compiling a LaTeX document
#
# This Makefile is somewhat generic for a project with a single LaTeX document
# Set the name of the main document without extension in $(main_document) and
# optionally change the compiler (XeLaTeX).

##---------- Preliminaries ----------------------------------------------------
.POSIX:            # Get reliable POSIX behaviour
.SUFFIXES:         # Clear built-in inference rules
.DELETE_ON_ERROR:  # Delete incomplete pdf/aux/idx files when TeX aborts with an error
##---------- Variables --------------------------------------------------------
latex2pdf := xelatex -synctex=1 -interaction=nonstopmode -shell-escape
bibliography := biber

main_document := research-methods-syllabus

##---------- Build targets ----------------------------------------------------

help: ## Show this help message (default)
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

all: $(main_document).pdf ## Build the PDF

%.pdf %.aux: %.tex
	$(latex2pdf) $<
	while grep 'Rerun to get ' $*.log ; do $(latex2pdf) $< ; done
	$(bibliography) $(main_document)
	$(latex2pdf) $<
	while grep 'Rerun to get ' $*.log ; do $(latex2pdf) $< ; done

.PHONY: clean mrproper

clean: ## Verwijder LaTeX hulpbestanden
	rm -f ./*.{bak,aux,log,nav,out,snm,ptc,toc,bbl,blg,idx,ilg,ind,tcp,vrb,tps,log,lot,synctex.gz,fls,fdb_latexmk,bcf,run.xml,xdv}

mrproper: clean ## Verwijder LaTeX hulpbestanden én PDFs
	rm -f *.pdf

