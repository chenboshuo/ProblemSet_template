# define a build
build_item(){
  xelatex $1.tex
  makeglossaries $1
  biber $1
  xelatex $1.tex
  xelatex $1.tex
}

# make the build directory
mkdir _build

# make ebook file
echo "\PassOptionsToPackage{disable}{todonotes} \documentclass[ebook,fleqn]{problemset}" > ebook.tex
awk 'FNR>2' main.tex >> ebook.tex
build_item ebook
mv ebook.pdf _build/ebook.pdf

# make plain book file
echo "\PassOptionsToPackage{disable}{todonotes} \documentclass{problemset}" > plain.tex
awk 'FNR>2' main.tex >> plain.tex
build_item plain
mv plain.pdf _build/plain.pdf

# make books with todos
echo "\documentclass{problemset}" > todo.tex
awk 'FNR>2' main.tex >> todo.tex
build_item todo
mv todo.pdf _build/todo.pdf

rm ./ebook.tex
rm ./plain.tex
rm ./todo.tex
