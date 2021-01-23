.PHONY : all clean help

## all : regenerate all results.
all: _build/todo.pdf _build/ebook.pdf _build/book.pdf

## todo.tex: make books tex file with todos
todo.tex : _build
	echo "\documentclass[fleqn]{problemset}" > todo.tex
	awk 'FNR>2' main.tex >> todo.tex

## todo.tex: make ebook tex file
ebook.tex: _build
	echo "\PassOptionsToPackage{disable}{todonotes}"\
	  "\documentclass[ebook,fleqn]{problemset}" \
	  > ebook.tex
	awk 'FNR>2' main.tex >> ebook.tex

## book.tex: make ebook tex file
book.tex: _build
	echo "\PassOptionsToPackage{disable}{todonotes}" \
		"\documentclass[fleqn]{problemset}" > book.tex
	awk 'FNR>2' main.tex >> book.tex

%.pdf: %.tex
	xelatex $<
	biber $(basename $<)
	xelatex $<
	makeglossaries $(basename $<)
	xelatex $<

_build/%.pdf: %.pdf
	mv $< $@


## clean the temp files
clean:
	git clean -fxd --exclude='*.pdf'

_build:
	mkdir _build

## help : show this message.
help :
	@grep '^##' ./makefile
