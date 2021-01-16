# define a build
build_item(){
  xelatex $1.tex
  biber $1
  xelatex $1.tex
  makeglossaries $1
  xelatex $1.tex
  # xelatex $1.tex
}
# make ebook file
echo "\PassOptionsToPackage{disable}{todonotes} \documentclass[ebook,fleqn]{problemset}" > ebook.tex
awk 'FNR>2' main.tex >> ebook.tex
build_item ebook

# make plain book file
echo "\PassOptionsToPackage{disable}{todonotes} \documentclass[fleqn]{problemset}" > plain.tex
awk 'FNR>2' main.tex >> plain.tex
build_item plain

# make books with todos
echo "\documentclass[fleqn]{problemset}" > todo.tex
awk 'FNR>2' main.tex >> todo.tex
build_item todo

# clean the temp files
git clean -fxd --exclude='*.pdf'

# make the build directory
mkdir _build

# move files
mv ebook.pdf _build/ebook.pdf
mv plain.pdf _build/plain.pdf
mv todo.pdf _build/todo.pdf
