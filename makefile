.PHONY : all clean help todo ebook book
.ONESHELL: # Applies to every targets in the file!
.INTERMEDIATE : inkscape

## make all : regenerate all results.
all: inkscape todo ebook book

## make todo: make build/todo.pdf
todo: build/todo.pdf
	rm -f todo.tex
## make ebook: make build/ebook.pdf
ebook: build/ebook.pdf
	rm -f ebook.tex
## make book: make build/book.pdf
book: build/book.pdf
	rm -f book.tex


## make todo.tex: make books tex file with todos
todo.tex : build
	echo "\documentclass{problemset}" > todo.tex
	awk 'FNR>2' main.tex >> todo.tex

## make todo.tex: make ebook tex file
ebook.tex: build
	echo "\PassOptionsToPackage{disable}{todonotes}"\
	  "\documentclass[ebook]{problemset}" \
	  > ebook.tex
	awk 'FNR>2' main.tex >> ebook.tex

## make book.tex: make ebook tex file
book.tex: build
	echo "\PassOptionsToPackage{disable}{todonotes}" \
		"\documentclass{problemset}" > book.tex
	awk 'FNR>2' main.tex >> book.tex

## make *.pdf : generate the pdf files
build/%.pdf: %.tex
	xelatex -output-directory="./build" $<
	biber ./build/$(basename $<)
	xelatex -output-directory="./build" $<
	makeglossaries -d ./build/ $(basename $<)
	# makeglossaries $(basename $<)
	xelatex -output-directory="./build" $<

## make inkscape: if has inkscape svg,convert it into pdf+latex version
inkscape:
	cd figures
	for i in $$(find . -type f -name '*.svg');do
		inkscape $$i --export-filename=$$(basename $$i .svg ).pdf \
		  --export-latex --export-area-drawing
	done


## make clean: clean the temp files
clean:
	git clean -fXd --exclude='*.pdf'
	# git ls-files --others | xargs gio trash
	@echo Removing ebook.tex
	@rm -f ebook.tex
	@echo Removing book.tex
	@rm -f book.tex
	@echo Removing todo.tex
	@rm -f todo.tex

## make build: create directory build
build:
	mkdir build

## make help : show this message.
help :
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' \
		| column -t -s ':'
