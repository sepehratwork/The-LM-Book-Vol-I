%%
%% tstextbook.cls
%% A robust, English-language textbook class for the Large Language Models book.
%%
%% Compile with XeLaTeX or LuaLaTeX.
%% Optional artwork:
%%   images/cover.pdf|png|jpg
%%   images/idea.pdf|png|jpg
%%   images/wolframalpha.pdf|png|jpg
%%
%% Based on the Typesetters.se textbook class.
%% Distributed under the LaTeX Project Public License (LPPL), version 1.3c
%% or (at your option) any later version.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tstextbook}[2026/11/02 v1.1 LLM textbook class]

\LoadClass[11pt,onecolumn,titlepage,twoside,openany]{book}

% ============================================================================
% Language and fonts
% ============================================================================
% fontspec and polyglossia require XeLaTeX or LuaLaTeX.
\RequirePackage{fontspec}
\RequirePackage{polyglossia}
\setdefaultlanguage{english}

% Prefer Noto fonts, but fall back to TeX Gyre fonts commonly distributed
% with TeX Live and MiKTeX.
\IfFontExistsTF{Noto Serif}
  {\setmainfont{Noto Serif}}
  {\setmainfont{TeX Gyre Pagella}}

\IfFontExistsTF{Noto Sans}
  {\setsansfont{Noto Sans}}
  {\setsansfont{TeX Gyre Heros}}

\IfFontExistsTF{DejaVu Sans Mono}
  {\setmonofont{DejaVu Sans Mono}}
  {\setmonofont{TeX Gyre Cursor}}

% ============================================================================
% Page layout and paragraph setting
% ============================================================================
\RequirePackage[
  top=2.6cm,
  bottom=2.6cm,
  inner=3.0cm,
  outer=2.5cm,
  headheight=15pt,
  headsep=8mm,
  footskip=1.2cm,
  marginparwidth=1.1cm,
  marginparsep=2mm
]{geometry}

\setlength{\parindent}{1.5em}
\setlength{\parskip}{0pt}
\setlength{\emergencystretch}{2em}
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000

% ============================================================================
% Core mathematics, typography, and utilities
% ============================================================================
\RequirePackage{amsfonts}
\RequirePackage{mathtools}
\RequirePackage{bm}
\RequirePackage{xfrac}
\RequirePackage{siunitx}
\RequirePackage{microtype}
\RequirePackage{etoolbox}
\RequirePackage{csquotes}
\RequirePackage{epigraph}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{longtable}
\RequirePackage{url}

% Number equations, figures, and tables within chapters.
\RequirePackage{chngcntr}
\numberwithin{equation}{chapter}
\counterwithin{figure}{chapter}
\counterwithin{table}{chapter}

% ============================================================================
% Colors and boxed environments
% ============================================================================
\RequirePackage{xcolor}
\definecolor{tssteelblue}{RGB}{70,130,180}
\definecolor{tsorange}{RGB}{220,112,65}
\definecolor{tsblue}{RGB}{23,74,117}
\definecolor{tsforestgreen}{RGB}{21,122,81}
\definecolor{tsyellow}{RGB}{255,205,120}
\definecolor{tsgrey}{RGB}{200,200,200}
\definecolor{tslightblue}{RGB}{240,246,250}

\RequirePackage[most]{tcolorbox}

\newtcolorbox{boxtheorem}{
  enhanced,
  breakable,
  colback=black!4,
  colframe=tsorange,
  boxrule=0.6pt,
  arc=1mm,
  left=2mm,
  right=2mm,
  top=1.5mm,
  bottom=1.5mm
}

\newtcolorbox{boxdefinition}{
  enhanced,
  breakable,
  colback=yellow!8!white,
  boxrule=0pt,
  frame hidden,
  borderline west={1.5mm}{0pt}{tsforestgreen},
  arc=0mm,
  left=3mm,
  right=2mm,
  top=1.5mm,
  bottom=1.5mm
}

\newtcolorbox{boxexercise}{
  enhanced,
  breakable,
  colback=tsyellow!17,
  boxrule=0pt,
  frame hidden,
  arc=1mm,
  left=2mm,
  right=2mm,
  top=1.5mm,
  bottom=1.5mm
}

\newtcolorbox{boxproblem}{
  enhanced,
  breakable,
  colback=tsorange!12,
  boxrule=0pt,
  frame hidden,
  arc=1mm,
  left=2mm,
  right=2mm,
  top=1.5mm,
  bottom=1.5mm
}

\newtcolorbox{boxprogramming}{
  enhanced,
  breakable,
  colback=tsblue!7,
  boxrule=0pt,
  frame hidden,
  arc=1mm,
  left=2mm,
  right=2mm,
  top=1.5mm,
  bottom=1.5mm
}

\newtcolorbox{boxexample}{
  enhanced,
  breakable,
  colback=tsgrey!13,
  boxrule=0pt,
  frame hidden,
  arc=1mm,
  left=2mm,
  right=2mm,
  top=1.5mm,
  bottom=1.5mm
}

% ============================================================================
% Graphics and optional page artwork
% ============================================================================
\RequirePackage{graphicx}
\graphicspath{{images/}{figures/}}
\DeclareGraphicsExtensions{.pdf,.png,.jpg,.jpeg}

\RequirePackage{tikz}
\RequirePackage[pages=some]{background}
\RequirePackage{wrapfig}
\RequirePackage{marginnote}

\makeatletter

% Optional cover artwork. If no cover image exists, the title page uses a
% solid-color background. The image file is expected in images/ and may be
% PDF, PNG, or JPG.
\backgroundsetup{
  scale=1,
  color=black,
  opacity=1.0,
  angle=0,
  contents={\includegraphics[width=\paperwidth,height=\paperheight]{images/cover}}
}

\newcommand{\ts@applycover}{%
  \IfFileExists{images/cover.pdf}{\BgThispage}{%
    \IfFileExists{images/cover.png}{\BgThispage}{%
      \IfFileExists{images/cover.jpg}{\BgThispage}{%
      \IfFileExists{images/cover.jpeg}{\BgThispage}{\pagecolor{tsblue}}%
    }%
    }%
  }%
}

% ============================================================================
% Headers and footers
% ============================================================================
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE,RO]{\bfseries\thepage}
\fancyhead[RE]{\small\itshape\sffamily\nouppercase{\rightmark}}
\fancyhead[LO]{\small\itshape\sffamily\nouppercase{\leftmark}}
\renewcommand{\headrulewidth}{0.35pt}
\renewcommand{\footrulewidth}{0pt}

% Chapter-opening pages use a clean footer page number.
\fancypagestyle{plain}{%
  \fancyhf{}
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

% ============================================================================
% Section heading styles
% ============================================================================
\RequirePackage{sectsty}
\sectionfont{\sffamily\color{tssteelblue}\sectionrule{0ex}{0pt}{-1ex}{1pt}}
\subsectionfont{\sffamily\color{tsblue}}
\subsubsectionfont{\sffamily}

% ============================================================================
% Code and algorithm formatting
% ============================================================================
\RequirePackage{listings}
\lstloadlanguages{Python,Mathematica}
\lstset{
  basicstyle=\ttfamily\small,
  keywordstyle=\color{tsblue}\bfseries,
  commentstyle=\color{tsforestgreen},
  stringstyle=\color{tsorange},
  numbers=left,
  numberstyle=\tiny\color{tsgrey},
  numbersep=8pt,
  breaklines=true,
  breakatwhitespace=true,
  showstringspaces=false,
  frame=single,
  rulecolor=\color{tsgrey},
  tabsize=4,
  captionpos=b
}

\RequirePackage[ruled,vlined,linesnumbered]{algorithm2e}
\RequirePackage{algpseudocode}

% ============================================================================
% Chapter heading design
% ============================================================================
% Flexible-width title boxes prevent long chapter titles from overflowing.
\renewcommand{\@makechapterhead}[1]{%
  \vspace*{0.5cm}%
  \noindent
  \colorbox{tsorange!16}{%
    \parbox{\dimexpr\textwidth-2\fboxsep\relax}{%
      \vspace{8pt}%
      {\huge\bfseries\sffamily\color{tsblue}%
       \thechapter.\enspace #1\par}%
      \vspace{8pt}%
    }%
  }%
  \par\nobreak\vspace*{2.2cm}%
}

\renewcommand{\@makeschapterhead}[1]{%
  \vspace*{0.5cm}%
  \noindent
  \colorbox{tsorange!16}{%
    \parbox{\dimexpr\textwidth-2\fboxsep\relax}{%
      \vspace{8pt}%
      {\huge\bfseries\sffamily\color{tsblue}#1\par}%
      \vspace{8pt}%
    }%
  }%
  \par\nobreak\vspace*{2.2cm}%
}

% ============================================================================
% Front matter: title page, publication details, and table of contents
% ============================================================================
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{3}

% Arguments:
% 1 title, 2 author, 3 cover designer, 4 year, 5 publication identifier,
% 6 ISBN, 7 edition, 8 publisher, 9 place of printing.
\newcommand{\tsbook}[9]{%
  \pagestyle{empty}%
  \def\@tstitle{#1}%
  \def\@tsauthor{#2}%
  \def\@tscoverdesign{#3}%
  \def\@tsyear{#4}%
  \def\@tsartno{#5}%
  \def\@tsisbn{#6}%
  \def\@tsedition{#7}%
  \def\@tspublished{#8}%
  \def\@tsprinted{#9}%

  \begin{titlepage}
    \ts@applycover
    \centering
    \null
    \vspace*{2.0cm}
    \begin{minipage}{0.88\textwidth}
      \centering
      {\color{white}\sffamily\bfseries
        \Huge \@tstitle\par
        \vspace{1.2cm}
        \LARGE \@tsauthor\par
      }
    \end{minipage}
    \vfill
  \end{titlepage}
  \nopagecolor

  \clearpage
  \thispagestyle{empty}
  \null
  \vfill
  \begin{flushleft}
    \small
    Copyright \copyright\ \@tsyear\ \@tsauthor. All rights reserved.\par
    \vspace{5mm}
    No part of this book may be reproduced, stored in a retrieval system,
    or transmitted in any form or by any means---electronic, mechanical,
    photocopying, recording, or otherwise---without prior written permission
    of the copyright holder, except as permitted by law.\par
    \vspace{5mm}
    \ifdefempty{\@tsedition}{}{\textbf{Edition:} \@tsedition\par}
    \ifdefempty{\@tscoverdesign}{}{\textbf{Cover design:} \@tscoverdesign\par}
    \ifdefempty{\@tsartno}{}{\textbf{Publication identifier:} \@tsartno\par}
    \ifdefempty{\@tsisbn}{}{\textbf{ISBN:} \@tsisbn\par}
    \ifdefempty{\@tspublished}{}{\textbf{Publisher:} \@tspublished\par}
    \ifdefempty{\@tsprinted}{}{\textbf{Printed in:} \@tsprinted\par}
  \end{flushleft}

  \cleardoublepage
  \pagenumbering{roman}
  \pagestyle{plain}
  \tableofcontents
  \cleardoublepage
  \pagenumbering{arabic}
  \setcounter{page}{1}
  \pagestyle{fancy}
}

% ============================================================================
% Theorem-like environments
% ============================================================================
\RequirePackage{amsthm}

\newtheoremstyle{styletheorem}
  {4pt}{4pt}{\normalfont}{0pt}
  {\small\bfseries\sffamily\color{tsorange}}{\;}{0.25em}
  {\small\sffamily\color{tsorange}\thmname{#1}
   \nobreakspace\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}
   \thmnote{\nobreakspace\the\thm@notefont\sffamily\bfseries\color{black} (#3)}}

\newtheoremstyle{styledefinition}
  {4pt}{4pt}{\normalfont}{0pt}
  {\small\bfseries\sffamily\color{black}}{\;}{0.25em}
  {\small\sffamily\color{tsforestgreen}\thmname{#1}
   \nobreakspace\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}
   \thmnote{\nobreakspace\the\thm@notefont\sffamily\bfseries\color{black} (#3)}}

\newtheoremstyle{styleexercise}
  {4pt}{4pt}{\normalfont}{0pt}
  {\small\bfseries\sffamily\color{black}}{\;}{0.25em}
  {\small\sffamily\color{black}\thmname{#1}
   \nobreakspace\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}
   \thmnote{\nobreakspace\the\thm@notefont\sffamily\bfseries\color{black} (#3)}}

\theoremstyle{styledefinition}
\newtheorem{envdefinition}{Definition}[chapter]

\theoremstyle{styletheorem}
\newtheorem{envtheorem}{Theorem}[chapter]
\newtheorem{envlemma}[envtheorem]{Lemma}
\newtheorem{envcorollary}[envtheorem]{Corollary}

\theoremstyle{styleexercise}
\newtheorem{envexercise}{Exercise}[chapter]
\newtheorem{envproblem}{Problem}[chapter]
\newtheorem{envprogramming}{Programming Exercise}[chapter]
\newtheorem{envexample}{Example}[chapter]

\newenvironment{definition}
  {\begin{boxdefinition}\begin{envdefinition}}
  {\end{envdefinition}\end{boxdefinition}}

\newenvironment{theorem}
  {\begin{boxtheorem}\begin{envtheorem}}
  {\end{envtheorem}\end{boxtheorem}}

\newenvironment{lemma}
  {\begin{boxtheorem}\begin{envlemma}}
  {\end{envlemma}\end{boxtheorem}}

\newenvironment{corollary}
  {\begin{boxtheorem}\begin{envcorollary}}
  {\end{envcorollary}\end{boxtheorem}}

\newenvironment{exercise}
  {\begin{boxexercise}\begin{envexercise}}
  {\end{envexercise}\end{boxexercise}}

\newenvironment{problem}
  {\begin{boxproblem}\begin{envproblem}}
  {\end{envproblem}\end{boxproblem}}

\newenvironment{programming}
  {\begin{boxprogramming}\begin{envprogramming}}
  {\end{envprogramming}\end{boxprogramming}}

\newenvironment{example}
  {\begin{boxexample}\begin{envexample}}
  {\end{envexample}\end{boxexample}}

% ============================================================================
% Other reusable environments
% ============================================================================
\newenvironment{summary}
  {\begin{tcolorbox}[
     enhanced,
     breakable,
     colback=tslightblue,
     colframe=tssteelblue,
     boxrule=0.4pt,
     arc=1mm,
     left=2mm,
     right=2mm
   ]\small\itshape}
  {\end{tcolorbox}}

\newenvironment{remark}
  {%
    \par\smallskip
    \marginnote{%
      \IfFileExists{images/idea.pdf}
        {\includegraphics[width=0.9cm]{images/idea.pdf}}
        {\IfFileExists{images/idea.png}
          {\includegraphics[width=0.9cm]{images/idea.png}}
          {\textbf{\scriptsize NOTE}}}%
    }%
    \noindent\itshape
  }
  {\par\smallskip}

\newenvironment{walpha}
  {%
    \marginnote{%
      \IfFileExists{images/wolframalpha.pdf}
        {\includegraphics[width=0.9cm]{images/wolframalpha.pdf}}
        {\IfFileExists{images/wolframalpha.png}
          {\includegraphics[width=0.9cm]{images/wolframalpha.png}}
          {\textbf{\scriptsize W.A.}}}%
    }%
  }
  {}

% ============================================================================
% Bibliography and index
% ============================================================================
% Load biblatex only when the project's bibliography file exists. This keeps
% early drafts buildable without producing unnecessary Biber requests.
\IfFileExists{bibliography.bib}{%
  \RequirePackage[
    backend=biber,
    style=authoryear,
    sorting=nyt,
    maxbibnames=99,
    maxcitenames=2,
    mincitenames=1
  ]{biblatex}%
}{}

\RequirePackage{makeidx}
\makeindex

% ============================================================================
% Hyperlinks and cross-references (load after most other packages)
% ============================================================================
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=tsblue,
  citecolor=tsforestgreen,
  urlcolor=tssteelblue,
  bookmarksopen=true,
  bookmarksnumbered=true,
  pdftitle={Large Language Models: Foundations, Architecture, Training, and Evaluation},
  pdfsubject={A textbook on the foundations of large language models}
}

\RequirePackage{bookmark}
\RequirePackage[nameinlink,noabbrev]{cleveref}

\crefname{envdefinition}{definition}{definitions}
\Crefname{envdefinition}{Definition}{Definitions}
\crefname{envtheorem}{theorem}{theorems}
\Crefname{envtheorem}{Theorem}{Theorems}
\crefname{envlemma}{lemma}{lemmas}
\Crefname{envlemma}{Lemma}{Lemmas}
\crefname{envcorollary}{corollary}{corollaries}
\Crefname{envcorollary}{Corollary}{Corollaries}
\crefname{envexercise}{exercise}{exercises}
\Crefname{envexercise}{Exercise}{Exercises}
\crefname{envproblem}{problem}{problems}
\Crefname{envproblem}{Problem}{Problems}
\crefname{envprogramming}{programming exercise}{programming exercises}
\Crefname{envprogramming}{Programming Exercise}{Programming Exercises}
\crefname{envexample}{example}{examples}
\Crefname{envexample}{Example}{Examples}

\makeatother

\endinput
