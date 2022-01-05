function build {
  param (
    $fileName
  )

  xelatex -output-directory="./build" $fileName".tex"
  bibtex ./build/$fileName
  xelatex -output-directory="./build" $fileName".tex"
  xelatex -output-directory="./build" $fileName".tex"
}

function add_extra {
  param (
    $fileName
  )

  Get-Content main.tex |
  Select-Object -Skip 2 |
  Out-File $fileName -Append
}

# encoding
$PSDefaultParameterValues['*:Encoding'] = 'utf8'

# make build directory
mkdir build

# make inkscpae
if (inkscape --version){
  cd figures
  foreach ($i in $(Get-ChildItem | where {$_.extension –eq “.svg”})){
    inkscape $i --export-filename=_$($i.Name.Split('.')[0]).pdf --export-latex --export-area-drawing
  }
  cd ..
}

# make todo
echo "\documentclass{problemset}" |
  Out-File todo.tex
add_extra todo.tex
build todo
rm todo.tex

# make ebook
echo "\PassOptionsToPackage{disable}{todonotes} \documentclass[ebook]{problemset}" |
  Out-File ebook.tex
add_extra ebook.tex
build ebook
rm ebook.tex

# make book version
echo "\PassOptionsToPackage{disable}{todonotes} \documentclass{problemset}" |
  Out-File book.tex
add_extra book.tex
build book
rm book.tex

Read-Host
