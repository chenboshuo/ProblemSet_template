\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{problemset}[2019/12/29 made by chenboshuo]

\def\myclasstype{book}% make sure a default is defined
\def\myclassoptions{a4paper,12pt} % 一般不加载

% 标志
\newif\if@Ebook
\newif\if@Plain
\newif\if@NoSolution


% reference https://tex.stackexchange.com/questions/173643/how-can-i-set-up-my-custom-class-to-load-a-different-class-depending-on-the-clas
\RequirePackage{xkeyval}% better option processing - there are many other possibilities as you probably know so just adapt as needed

% 移动设备模式
\DeclareOptionX{ebook}{
  \gdef\myclasstype{book}
  \gdef\myclassoptions{12pt,oneside}
  \@Ebooktrue
}

% 打印模式
\DeclareOptionX{plain}{
  \gdef\myclasstype{book}
  \gdef\myclassoptions{a4paper,12pt}
  \@Plaintrue
}


\DeclareOption{NoSolution}{
  \@NoSolutiontrue
}

\DeclareOptionX*{%
  \PassOptionsToClass{\CurrentOption}{\myclasstype}%
}

\ProcessOptionsX
\LoadClass[\myclassoptions]{\myclasstype}



\newtheorem{@problem}{问题}[chapter]
\newtheorem{@solution}{解}[chapter]

% 加载移动版选项
\if@Ebook
  \RequirePackage[papersize={108mm,144mm},
    margin=3mm,
    bottom=3mm
  ]{geometry}
  \newenvironment{problem}{\begin{@problem}}{\end{@problem}\newpage}
  \newenvironment{solution}{\begin{@solution}}{\end{@solution}}
\else
  \newtheorem{problem}{问题}[chapter]
  \newtheorem{solution}{解}[chapter]
\fi
% \newtheorem{proof}{证明}[chapter]
\newtheorem{theorem}{定理}[chapter]


% 加载打印版选项
\if@Plain
  \null
\fi

\if@NoSolution
  \RequirePackage{comment}
  \excludecomment{solution}   %添加这两句话将注释掉所有的`solution`环境
\fi
% 包
\RequirePackage{ctex} % 中文包

% 自动链接
\RequirePackage[pdfusetitle]{hyperref}
\hypersetup{hidelinks} % 隐藏超链接周围红框

% 数学宏包
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{bm}
\RequirePackage{mathtools}

%% booktabs 提供了\toprule 等命令.
\RequirePackage{booktabs}

% 插入图片
\RequirePackage{graphicx}
\RequirePackage{float}
% 物理单位
\RequirePackage{siunitx}
% 子图排版
\RequirePackage{subfigure}
% 积分符号
\RequirePackage{esint}  % various fancy integral symbols
% tikz
\RequirePackage{tikz}
\usetikzlibrary{math} % 一些数值计算
\usetikzlibrary{graphs} % 画节点图
\usetikzlibrary{matrix,backgrounds,positioning} % 画内存条需要的库

% 如果图片没有指定后缀, 依次按下列顺序搜索
\DeclareGraphicsExtensions{.pdf,.eps,.jpg,.png}

% 图片路径
\RequirePackage{graphicx}
\graphicspath{{./figures/}{../figures/}}

% 矢量
\renewcommand{\vec}[1]{\overrightarrow{#1}}
% \renewcommand{\vec}[1]{\boldsymbol{#1}}

% 微分命令
  %% 参考 https://liam.page/2017/05/01/the-correct-way-to-use-differential-operator/
\newcommand*{\dif}{\mathop{}\!\mathrm{d}}

% 除法命令
\newcommand*{\bdiv}{%
  \nonscript\mskip-\medmuskip\mkern5mu%
  \mathbin{\operator@font div}\penalty900\mkern5mu%
  \nonscript\mskip-\medmuskip
}

% 其他定理环境 引理, 推论已经定义
\newtheorem{conclusion}{结论}[chapter]
\newtheorem{definition}{定义}[chapter]
\newtheorem{corollary}{推论}[theorem]


% 优化大于等于和小于等于
\renewcommand{\le}{\leqslant}
\renewcommand{\ge}{\geqslant}

% 算法环境
\RequirePackage{algorithm}
% \RequirePackage{clrscode}
\RequirePackage{clrscode3e}

% <- 的定义
\DeclareMathSymbol{\leftarrow}{\mathrel}{symbols}{"20}
\let\gets=\leftarrow

% 引用
\RequirePackage{cleveref}
\crefformat{equation}{#2公式(#1#3)}
\crefrangeformat{equation}{公式(#3#1#4)\;\~{}\;(#5#2#6)}
\crefmultiformat{equation}{公式(#2#1#3)}{ 和~(#2#1#3)}{，(#2#1#3)}{ 和~(#2#1#3)}

% todo
\RequirePackage{todonotes}
\setuptodonotes{inline, color=blue!30}


% \newenvironment{solution}{\par
%     \textbf{答案}\quad
% }{\par}

% reference
% % https://tex.stackexchange.com/questions/167925/how-to-make-maths-equations-start-at-the-left
% \setlength\mathindent{10pt}

% remark environment
\newenvironment{remark}{\textbf{\color{blue}注}}{\par}

\newenvironment{proof}{\textbf{\color{blue}证明}}{\par}


% Load the package with the acronym option
\RequirePackage[acronym,nomain]{glossaries}

% chapter references
\RequirePackage[alldates=iso]{biblatex}
% 中文链接
\newfontfamily\urlfontfamily{KaiTi-Regular}
\def\UrlFont{\urlfontfamily}

% subsubsection int toc
\RequirePackage{titletoc}% http://ctan.org/pkg/titletoc
\titlecontents*{subsubsection}% <section>
  [7em]% <left>
  {\small}% <above-code>
  {}% <numbered-entry-format>; you could also use {\thecontentslabel. } to show the numbers
  {}% <numberless-entry-format>
  % {\ \thecontentspage}% <filler-page-format>
  {}% <filler-page-format>
  [,\ ]% <separator>
  []% <end>
\setcounter{tocdepth}{3}

% toc in toc
\RequirePackage{tocbibind}

% 上标文献
\newcommand{\upcite}[1]{$^{\mbox{\scriptsize \cite{#1}}}$}


\def\sectionFootnote{
  \ifx
    \protect\@typeset@protect
    \expandafter\footnote
  \else\expandafter\@gobble
  \fi
}

\def\sectionCite{
  \ifx
    \protect\@typeset@protect
    \expandafter\upcite
  \else\expandafter\@gobble
  \fi
}

\newcommand{\glsnote}[2]{
  \newacronym{#1}{#1}{#2}
  \textbf{#1}
  \footnote{\gls{#1}}
}
% matrix col number
% https://tex.stackexchange.com/a/59519
\RequirePackage{blkarray}

% mutlicol itemize
% https://tex.stackexchange.com/questions/194426/split-itemize-into-multiple-columns
\RequirePackage{etoolbox,refcount}
\RequirePackage{multicol}

\newcounter{countitems}
\newcounter{nextitemizecount}
\newcommand{\setupcountitems}{%
  \stepcounter{nextitemizecount}%
  \setcounter{countitems}{0}%
  \preto\item{\stepcounter{countitems}}%
}
\makeatletter
\newcommand{\computecountitems}{%
  \edef\@currentlabel{\number\c@countitems}%
  \label{countitems@\number\numexpr\value{nextitemizecount}-1\relax}%
}
\newcommand{\nextitemizecount}{%
  \getrefnumber{countitems@\number\c@nextitemizecount}%
}
\newcommand{\previtemizecount}{%
  \getrefnumber{countitems@\number\numexpr\value{nextitemizecount}-1\relax}%
}
\makeatother
\newenvironment{autoMultiColItemize}{%
\ifnumcomp{\nextitemizecount}{>}{3}{\begin{multicols}{2}}{}%
\setupcountitems\begin{itemize}}%
{\end{itemize}%
\unskip\computecountitems\ifnumcomp{\previtemizecount}{>}{3}{\end{multicols}}{}}

% code setting
\RequirePackage{listings}
\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}
\lstset{
  frame=tb,
  aboveskip=3mm,
  belowskip=3mm,
  showstringspaces=false,
  columns=flexible,
  framerule=1pt,
  rulecolor=\color{gray!35},
  backgroundcolor=\color{gray!5},
  basicstyle={\small\ttfamily},
  numbers=none,
  numberstyle=\tiny\color{gray},
  keywordstyle=\color{blue},
  commentstyle=\color{dkgreen},
  stringstyle=\color{mauve},
  breaklines=true,
  breakatwhitespace=true,
  tabsize=2,
}
\RequirePackage{ifplatform}
\ifwindows
\else
  \setmonofont{DejaVu Sans Mono}
\fi

% romannum
% https://tex.stackexchange.com/a/303530
\RequirePackage{romannum}


\endinput
