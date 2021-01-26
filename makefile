.PHONY : all clean help todo ebook book

## make all : regenerate all results.
all: todo ebook book

## make todo: make _build/todo.pdf
todo: _build/todo.pdf
	rm -f todo.tex
## make ebook: make _build/ebook.pdf
ebook: _build/ebook.pdf
	rm -f ebook.tex
## make book: make _build/book.pdf
book: _build/book.pdf
	rm -f book.tex

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
_build/%.pdf: %.tex
	xelatex -output-directory="./_build" $<
	biber ./_build/$(basename $<)
	xelatex -output-directory="./_build" $<
	makeglossaries -d ./_build/ $(basename $<)
	# makeglossaries $(basename $<)
	xelatex -output-directory="./_build" $<

## make clean: clean the temp files
clean:
	git clean -fxd --exclude='*.pdf'
	@echo Removing ebook.tex
	@rm -f ebook.tex
	@echo Removing book.tex
	@rm -f book.tex
	@echo Removing todo.tex
	@rm -f todo.tex

## make _build: create directory _build
_build:
	mkdir _build

## make help : show this message.
help :
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' \
		| column -t -s ':'
