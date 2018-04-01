\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{bible-study-handout}[2018/04/01 v1.1.1 Bible-Study-Handout class]

\RequirePackage[utf8]{inputenc}
\RequirePackage{graphicx}
  \setkeys{Gin}{width=\linewidth,totalheight=\textheight,keepaspectratio}
\RequirePackage{color}
\RequirePackage{framed}
\RequirePackage[sharp]{easylist}
\RequirePackage{wrapfig}
\RequirePackage{xparse}
\RequirePackage{environ}
\RequirePackage{scrextend}

% uncomment following line to see frames drawn on pages
%\RequirePackage{showframe}

% we inherit from tufte-handout class
\LoadClass[symmetric,justified]{tufte-handout}

\geometry{
  left=1cm, % left margin
  top=1cm, % top margin
  textwidth=12.56cm, % main text block
  marginparsep=0.75cm, % gutter between main text block and margin notes
  marginparwidth=6.28cm, % width of margin notes
  textheight=25.94cm
}

% <bottompar>: forces paragraph to bottom of page
\newenvironment{bottompar}{\par\vspace*{\fill}}{\clearpage}

% <V>: verse numbers
\def\V#1{\textsuperscript{#1~}}

% <bookoutline>: shaded boxes for book outline
\definecolor{shadecolor}{gray}{0.9}
\ListProperties(Numbers1=R,Numbers2=L,Numbers3=a,Numbers4=r,Numbers5=l,Numbers6=z,Indent=.25cm,Hang=true,Align=fixed,FinalSpace=1.25em,Progressive=2.5ex,Style=\sffamily)
\newenvironment{bookoutline}%
  {\begin{snugshade*}\begin{easylist}}%
  {\end{easylist}\end{snugshade*}}

% indent margin if on odd pages (used to differentiate study comments from Bible text)
\def\changemargin#1#2{\list{}{\rightmargin#2\leftmargin#1}\item[]}
\let\endchangemargin=\endlist

% font for study comments
\definecolor{darkgray}{gray}{0.5}
\newcommand{\studycommentstyle}{\scriptsize\sffamily\color{darkgray}}

% <studycomment>: study comments (show in gray to ensure Bible text stands out)
\NewEnviron{studycomment}{%
  \marginnote{\studycommentstyle\BODY}%
}

% <studycomment*>: full-width study comments (with indented margin if on odd pages)
\newenvironment{studycomment*}%
  {\begin{fullwidth}\ifthispageodd{\begin{changemargin}{1.5cm}{0cm}}{}\studycommentstyle}%
  {\ifthispageodd{\end{changemargin}}{}\end{fullwidth}}

% <studycommentinline>: study comments in column with Bible text (always with indented margin)
\newenvironment{studycommentinline}%
  {\begin{changemargin}{1.5cm}{0cm}\studycommentstyle}%
  {\end{changemargin}}

% <studyblock*>: full-width block of study notes (never indent margin, always show in black)
\newenvironment{studyblock*}%
  {\begin{fullwidth}\studycommentstyle\color{black}}%
  {\end{fullwidth}}

% <copyrightstatement>: copyright statement at very bottom of page
\NewEnviron{copyrightstatement}{%
  \begin{bottompar}\begin{fullwidth}\studycommentstyle\textit{\BODY}\end{fullwidth}\end{bottompar}%
}
