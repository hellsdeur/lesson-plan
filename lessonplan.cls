%% lessonplan.cls
%% LaTeX class for lesson plans (planos de aula).
%% Engine: LuaLaTeX only.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lessonplan}[2026/09/04 v1.0 Lesson plan class]

\LoadClass[11pt,a4paper]{article}

\RequirePackage{iftex}
\RequireLuaTeX

\RequirePackage{fontspec}
\RequirePackage{geometry}
\RequirePackage{titlesec}
\RequirePackage{enumitem}
\RequirePackage{scrlayer-scrpage}
\RequirePackage[brazilian]{babel}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{xparse}
\RequirePackage{csquotes}
\RequirePackage[backend=biber, style=abnt, language=brazilian]{biblatex}

%% Page geometry

\geometry{
  a4paper,
  top=2cm,
  bottom=2cm,
  left=2.2cm,
  right=2.2cm,
  headheight=28pt,
  headsep=10pt,
  footskip=1cm
}

%% Typography

\setmainfont{Latin Modern Roman}
\definecolor{lpaccent}{HTML}{2F3E52}
\definecolor{lprule}{HTML}{B0B8C1}

\setlength{\parindent}{0pt}
\setlength{\parskip}{4pt}

%% Section styling

\titleformat{\section}
  {\normalfont\large\bfseries\color{lpaccent}}
  {}{0pt}{}
  [\vspace{-2pt}{\color{lprule}\titlerule}]
\titlespacing*{\section}{0pt}{10pt}{4pt}

\titleformat{\subsection}
  {\normalfont\bfseries\color{lpaccent}}
  {}{0pt}{}
\titlespacing*{\subsection}{0pt}{6pt}{2pt}

\setlist{itemsep=1pt, topsep=2pt, parsep=0pt}

%% Title block fields

\newcommand{\lpuniversity}[1]{\def\lp@university{#1}}
\newcommand{\lpinstitute}[1]{\def\lp@institute{#1}}
\newcommand{\lpfaculty}[1]{\def\lp@faculty{#1}}

%% Optional logo per institutional field. Set only the ones you want
%% \maketitle counts how many are set (0–3) and lays them out
%% accordingly: 3 side by side above the text, 2 flanking the text on
%% the same line, 1 centered above the text, 0 no logo.

\newcommand{\lpuniversitylogo}[1]{\def\lp@universitylogo{#1}}
\newcommand{\lpinstitutelogo}[1]{\def\lp@institutelogo{#1}}
\newcommand{\lpfacultylogo}[1]{\def\lp@facultylogo{#1}}

\def\lp@university{}
\def\lp@institute{}
\def\lp@faculty{}
\def\lp@universitylogo{}
\def\lp@institutelogo{}
\def\lp@facultylogo{}

\newlength{\lp@logoheight}
\setlength{\lp@logoheight}{1.6cm}

%% Identificação fields

\newcommand{\lpdiscipline}[1]{\def\lp@discipline{#1}}
\newcommand{\lptheme}[1]{\def\lp@theme{#1}}
\newcommand{\lpdate}[1]{\def\lp@date{#1}}
\newcommand{\lpduration}[1]{\def\lp@duration{#1}}
\newcommand{\lpteacher}[1]{\def\lp@teacher{#1}}
\newcommand{\lplocation}[1]{\def\lp@location{#1}}

\def\lp@discipline{}
\def\lp@theme{}
\def\lp@date{}
\def\lp@duration{}
\def\lp@teacher{}
\def\lp@location{}

\newcommand{\lp@titletext}{%
  {\Large\bfseries\color{lpaccent} Plano de Aula}\\[2pt]
  \ifx\lp@university\@empty\else {\lp@university}\\ \fi
  \ifx\lp@institute\@empty\else {\small\lp@institute}\\ \fi
  \ifx\lp@faculty\@empty\else {\small\lp@faculty} \fi
}

\newcounter{lp@nlogos}
\newcounter{lp@logoidx}
\def\lp@logoA{}
\def\lp@logoB{}
\def\lp@logoC{}

\newcommand{\lp@collectlogo}[1]{%
  \ifx#1\@empty\else
    \stepcounter{lp@nlogos}%
    \stepcounter{lp@logoidx}%
    \ifnum\value{lp@logoidx}=1 \let\lp@logoA#1\fi
    \ifnum\value{lp@logoidx}=2 \let\lp@logoB#1\fi
    \ifnum\value{lp@logoidx}=3 \let\lp@logoC#1\fi
  \fi
}

\renewcommand{\maketitle}{%
  \begingroup
  \setlength{\parindent}{0pt}
  \setcounter{lp@nlogos}{0}
  \setcounter{lp@logoidx}{0}
  \def\lp@logoA{}\def\lp@logoB{}\def\lp@logoC{}
  \lp@collectlogo{\lp@universitylogo}%
  \lp@collectlogo{\lp@institutelogo}%
  \lp@collectlogo{\lp@facultylogo}%

  \noindent
  \ifcase\value{lp@nlogos}
    % 0 logos, text only, centered
    \begin{center}
      \lp@titletext
    \end{center}%
  \or
    % 1 logo, centered above the text
    \begin{center}
      \includegraphics[height=\lp@logoheight]{\lp@logoA}\\[6pt]
      \lp@titletext
    \end{center}%
  \or
    % 2 logos, flanking the text on the same line
    \begin{minipage}[c]{0.15\textwidth}
      \includegraphics[height=\lp@logoheight]{\lp@logoA}
    \end{minipage}%
    \begin{minipage}[c]{0.70\textwidth}
      \centering
      \lp@titletext
    \end{minipage}%
    \begin{minipage}[c]{0.15\textwidth}
      \raggedleft
      \includegraphics[height=\lp@logoheight]{\lp@logoB}
    \end{minipage}%
  \or
    % 3 logos, side by side in a row above the text
    \begin{center}
      \includegraphics[height=\lp@logoheight]{\lp@logoA}\hspace{1.2cm}%
      \includegraphics[height=\lp@logoheight]{\lp@logoB}\hspace{1.2cm}%
      \includegraphics[height=\lp@logoheight]{\lp@logoC}\\[6pt]
      \lp@titletext
    \end{center}%
  \fi

  \vspace{4pt}
  {\color{lprule}\hrule height 0.6pt}

  \section*{Identificação}
  \noindent
  \begin{minipage}[t]{0.5\textwidth}
    \ifx\lp@discipline\@empty\else \textbf{Disciplina:} \lp@discipline \\ \fi
    \ifx\lp@theme\@empty\else \textbf{Tema:} \lp@theme \\ \fi
    \ifx\lp@teacher\@empty\else \textbf{Docente:} \lp@teacher \fi
  \end{minipage}%
  \begin{minipage}[t]{0.5\textwidth}
    \ifx\lp@date\@empty\else \textbf{Data:} \lp@date \\ \fi
    \ifx\lp@duration\@empty\else \textbf{Duração:} \lp@duration \\ \fi
    \ifx\lp@location\@empty\else \textbf{Local:} \lp@location \fi
  \end{minipage}
  \endgroup
}

%% Running header

\KOMAoptions{headsepline=0.4pt}
\addtokomafont{headsepline}{\color{lprule}}
\pagestyle{scrheadings}
\clearpairofpagestyles
\ihead{\small\color{lpaccent}\lp@discipline}
\chead{}
\ohead{\small\color{lpaccent}\lp@teacher}
\ifoot{\small\lp@date}
\cfoot{\small\thepage}
\ofoot{\small\lp@location}
\setkomafont{pageheadfoot}{\normalfont}

%% Bibliography (Referências)
%%
%% Register entries with \lpbibresource{file.bib}, then in the
%% Referências section call \lpprintbibliography.
%%
%% - With citation: use \cite{key} anywhere in the text; only cited
%%   entries are printed.
%% - Without citation: call \nocite{*} before \lpprintbibliography to
%%   print every entry in the .bib file regardless of citation.
%%
%% Requires the biber backend.

\newcommand{\lpbibresource}[1]{\addbibresource{#1}}
\newcommand{\lpprintbibliography}{\printbibliography[title={Referências}]}
