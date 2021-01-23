.PHONY : all clean help

## make all : regenerate all results.
all: _build/todo.pdf _build/ebook.pdf _build/book.pdf

## make todo.tex: make books tex file with todos
todo.tex : _build
	echo "\documentclass[fleqn]{problemset}" > todo.tex
	awk 'FNR>2' main.tex >> todo.tex

## make todo.tex: make ebook tex file
ebook.tex: _build
	echo "\PassOptionsToPackage{disable}{todonotes}"\
	  "\documentclass[ebook,fleqn]{problemset}" \
	  > ebook.tex
	awk 'FNR>2' main.tex >> ebook.tex

## make book.tex: make ebook tex file
book.tex: _build
	echo "\PassOptionsToPackage{disable}{todonotes}" \
		"\documentclass[fleqn]{problemset}" > book.tex
	awk 'FNR>2' main.tex >> book.tex

## make *.pdf : generate the pdf files
%.pdf: %.tex
	xelatex $<
	biber $(basename $<)
	xelatex $<
	makeglossaries $(basename $<)
	xelatex $<

## make _build/*.pdf : generate *.pdf and remove to _build/
_build/%.pdf: %.pdf
	mv $< $@


## make clean: clean the temp files
clean:
	git clean -fxd --exclude='*.pdf'

## make _build: create directory _build
_build:
	mkdir _build

## make help : show this message.
help :
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' \
		| column -t -s ':'