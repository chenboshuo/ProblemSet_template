# make the build directory
mkdir _build

# make ebook file
echo "\PassOptionsToPackage{disable}{todonotes} \documentclass[ebook,fleqn]{problemset}" > ebook.tex
awk 'FNR>2' main.tex >> ebook.tex
xelatex ebook.tex
xelatex ebook.tex
mv ebook.pdf _build/ebook.pdf

# make plain book file
echo "\PassOptionsToPackage{disable}{todonotes} \documentclass{problemset}" > plain.tex
awk 'FNR>2' main.tex >> plain.tex
xelatex plain.tex
xelatex plain.tex
mv plain.pdf _build/plain.pdf

# make books with todos
echo "\documentclass{problemset}" > todo.tex
awk 'FNR>2' main.tex >> todo.tex
xelatex todo.tex
xelatex todo.tex
mv todo.pdf _build/todo.pdf

rm ./ebook.tex
rm ./plain.tex
rm ./todo.tex
