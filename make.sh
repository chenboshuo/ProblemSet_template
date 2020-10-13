echo "\documentclass[ebook,fleqn]{problemset}" > ebook.tex | awk 'FNR>1' main.tex >> ebook.tex
xelatex ebook.tex
xelatex ebook.tex
mv ebook.pdf _build/ebook.pdf

echo "\documentclass{problemset}" > plain.tex | awk 'FNR>1' main.tex >> plain.tex
xelatex plain.tex
xelatex plain.tex
mv plain.pdf _build/plain.pdf

rm ./ebook.tex
rm ./plain.tex
