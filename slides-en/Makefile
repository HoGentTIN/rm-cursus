## POSIX-compliant Makefile for compiling LaTeX files in the current directory

##---------- Preliminaries ----------------------------------------------------
.POSIX:     # Get reliable POSIX behaviour
.SUFFIXES:  # Clear built-in inference rules
.PHONY : help clean mrproper

##---------- Variables --------------------------------------------------------

sources := $(wildcard rm*.tex)           # Files to be compiled
pdfs := $(patsubst %.tex,%.pdf,$(sources)) # Names of all resulting PDFs
output_dir := ../output

# LaTeX command for compiling the .tex files:
latex_cmd := latexmk -output-directory="$(output_dir)" -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -shell-escape

##---------- Build targets ----------------------------------------------------

help: ## Toon deze hulpboodschap
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@printf "Specifieke PDF genereren: make NAAM.pdf\n"
	@printf "Met NAAM een van de hieronder opgesomde bestandsnamen:\n"
	@printf "\033[36m%s\033[0m\n" $(pdfs)

all: $(pdfs) ## Compileer alle LaTeX-bestanden (hieronder opgesomd)

%.pdf: %.tex
	$(latex_cmd) $<

clean: ## Verwijder LaTeX hulpbestanden
	rm -vf "$(output_dir)"/*.aux "$(output_dir)"/*.bak "$(output_dir)"/*.bbl "$(output_dir)"/*.bcf "$(output_dir)"/*.blg "$(output_dir)"/*.fdb_latexmk "$(output_dir)"/*.fls "$(output_dir)"/*.idx "$(output_dir)"/*.ilg "$(output_dir)"/*.ind "$(output_dir)"/*.lof "$(output_dir)"/*.log "$(output_dir)"/*.lol "$(output_dir)"/*.lot "$(output_dir)"/*.nav "$(output_dir)"/*.out "$(output_dir)"/*.ptc "$(output_dir)"/*.run.xml "$(output_dir)"/*.snm "$(output_dir)"/*.synctex.gz "$(output_dir)"/*.tcp "$(output_dir)"/*.toc "$(output_dir)"/*.tps "$(output_dir)"/*.vrb "$(output_dir)"/*.xdv 
	rm -vrf "$(output_dir)"/_minted*

mrproper: clean ## Verwijder LaTeX hulpbestanden én PDFs
	rm -v "$(output_dir)"/*.pdf
