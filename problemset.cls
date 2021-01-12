\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{problemset}[2019/12/29 made by chenboshuo]

\def\myclasstype{book}% make sure a default is defined
\def\myclassoptions{a4paper,12pt,fleqn} % 一般不加载

% 标志
\newif\if@Ebook
\newif\if@Plain
\newif\if@NoSolution


% reference https://tex.stackexchange.com/questions/173643/how-can-i-set-up-my-custom-class-to-load-a-different-class-depending-on-the-clas
\RequirePackage{xkeyval}% better option processing - there are many other possibilities as you probably know so just adapt as needed

% 移动设备模式
\DeclareOptionX{ebook}{
  \gdef\myclasstype{book}
  \gdef\myclassoptions{12pt,fleqn}
  \@Ebooktrue
}

% 打印模式
\DeclareOptionX{plain}{
  \gdef\myclasstype{book}
  \gdef\myclassoptions{a4paper,12pt,fleqn}
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
  \RequirePackage[papersize={108mm,144mm},margin=2mm]{geometry}
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
\RequirePackage{hyperref}
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
\newtheorem{conclusion}{结论}[section]
\newtheorem{definition}{定义}[section]


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


% \newenvironment{solution}{\par
%     \textbf{答案}\quad
% }{\par}

% reference
% https://tex.stackexchange.com/questions/167925/how-to-make-maths-equations-start-at-the-left
\setlength\mathindent{10pt}
\setuptodonotes{inline, color=blue!30}

% remark environment
\newenvironment{remark}{\textbf{\color{blue}注}}{\par}

\newenvironment{proof}{\textbf{\color{blue}证明}}{\par}


% Load the package with the acronym option
\RequirePackage[acronym,nomain]{glossaries}

% chapter references
\RequirePackage[alldates=iso8601]{biblatex}
\endinput
