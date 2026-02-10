%============================================================================%
%   
%   ACADEMIC CV CLASS FILE
%   
%   Author: Francesco Ioli
%   Created: 2026/02/10
%   License: MIT License
%   
%   Description:
%   A custom LaTeX class for academic CVs featuring a two-column layout with 
%   a sidebar, automatic bibliography management via BibLaTeX, and specific 
%   modules for publications, software, and teaching.
%   
%   Attribution:
%   This class is a heavily modified version of the 'latexcv' template 
%   by Jan Küster (https://github.com/jankapunkt/latexcv).
%   Original Copyright (c) 2016 Jan Küster
%   
%   Usage:
%   \documentclass{cv_style}
%   
%============================================================================%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv_style}[2026/02/10 Custom CV class based on latexcv]
\LoadClass[10pt,a4paper]{article}

%------------------------------------------------------------------------
%   ENCODING + FONT
%------------------------------------------------------------------------
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[default]{gillius}
\renewcommand*\familydefault{\sfdefault}
\RequirePackage{moresize}
\RequirePackage{fontawesome5}

%------------------------------------------------------------------------
%   COLOR PALETTE (Blue Theme)
%------------------------------------------------------------------------
\usepackage{xcolor}
% Main blue (sidebar background, section headers)
\definecolor{sectcol}{RGB}{25,90,140}
% Accent blue (employer names, highlights)
\definecolor{accentcol}{RGB}{65,140,200}
% Light accent (stars, secondary highlights)
\definecolor{lightaccent}{RGB}{100,180,230}
% Dark gray (header, dates, secondary text)
\definecolor{bgcol}{RGB}{70,70,70}
% Light gray (divider lines)
\definecolor{softcol}{RGB}{220,220,220}

%------------------------------------------------------------------------
%   LOGIC & PAGE LAYOUT
%------------------------------------------------------------------------
\RequirePackage{xifthen}
\RequirePackage{paracol}
\RequirePackage{graphbox}
\RequirePackage[a4paper]{geometry}
\geometry{top=1cm,bottom=1.2cm,left=1.25cm,right=1.25cm}
\setlength{\parindent}{0pt} \pagestyle{empty}

% Define column separation and ratio
\newlength{\headerstrut}
\setlength{\headerstrut}{10pt} % Adjust this value if you need more top padding

% Change column ratio: Sidebar (left) is smaller
\columnratio{0.30} % 30% Left, 70% Right
\setlength{\columnsep}{8pt} % Adjust column separation

% Define the command to set the background
% We create a helper command to be called in the document or executed at begin document
\newcommand{\setsidebarcolor}{%
    \backgroundcolor{c}[0]{sectcol} % Color column 0 (left) with sectcol
}

%------------------------------------------------------------------------
%   BIBLIOGRAPHY MANAGEMENT
%------------------------------------------------------------------------
\RequirePackage[
    backend=biber,
    style=authoryear,
    sorting=none,
    maxbibnames=99,
    doi=true,
    url=false
]{biblatex}

% Custom DOI format
\DeclareFieldFormat{doi}{\href{https://doi.org/#1}{\footnotesize\nolinkurl{#1}}}

% Simple formatting to remove bibliography margins to match your layout
% \defbibenvironment{bibliography}{%
%     \list{}{%
%         \setlength{\leftmargin}{0pt}%
%         \setlength{\itemsep}{2pt}%
%         \setlength{\parsep}{0pt}}} {\endlist} {%
%     \item %
% }

% Custom bullet bib env
\defbibenvironment{bibliography}{%
    \list{}{%
        \setlength{\leftmargin}{1.5em}%
        \setlength{\itemsep}{3pt}%
        \setlength{\parsep}{0pt}}} {\endlist} {%
    \item[\textcolor{softcol}{$\bullet$}]%
}

%------------------------------------------------------------------------
%   TABLES, GRAPHICS, LINKS
%------------------------------------------------------------------------
\RequirePackage{array}
\RequirePackage{tabularx}
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}

\RequirePackage{graphicx}
\RequirePackage{transparent}
\RequirePackage{tikz}
\usetikzlibrary{shapes,backgrounds,mindmap,trees}

\RequirePackage[colorlinks,urlcolor=accentcol]{hyperref}
\RequirePackage[most]{tcolorbox}


%=======================================================================%
%   CUSTOM COMMANDS
%=======================================================================%
\newcommand{\mpwidth}{\linewidth-\fboxsep-\fboxsep}
\newcommand{\mystrut}{\rule[-.3\baselineskip]{0pt}{\baselineskip}}

% -- Arrows
\newcommand{\tzlarrow}{(0,0) -- (0.2,0) -- (0.3,0.2) -- (0.2,0.4) -- (0,0.4) -- (0.1,0.2) -- cycle;}
\newcommand{\larrow}[1]{\begin{tikzpicture}[scale=0.58]\filldraw[fill=#1,draw=#1!100!black] \tzlarrow\end{tikzpicture}}

% -- Section header
\newcommand{\cvsection}[1]{%
    % \vspace{4pt}%
    \colorbox{sectcol}{\mystrut\makebox[1\mpwidth][l]{%
            \hspace{2pt}\larrow{bgcol}\hspace{-6pt}\larrow{bgcol}\hspace{-6pt}\larrow{bgcol}\hspace{6pt}%
            \textbf{\textcolor{white}{\uppercase{#1}}}%
        }}%
    \vspace{4pt}%
}

% -- Sidebar section title
\newenvironment{metasection}[1]{%
    \vspace{4pt}%
    \begin{center}%
        \textcolor{white}{\large{\uppercase{#1}}}\\
        \normalsize
        \parbox{0.85\linewidth}{\textcolor{white}\hrule} % Reduced width for line
        \par\vspace{2pt}
    }{%
    \end{center}%
}

% -- Icon helpers
\newcommand{\vcenteredhbox}[1]{\begingroup\setbox0=\hbox{#1}\parbox{\wd0}{\box0}\endgroup}

\newcommand{\icon}[3]{\makebox(#2,#2){\textcolor{#3}{\csname fa#1\endcsname}}}

\newcommand{\icontext}[4]{\vcenteredhbox{\icon{#1}{#2}{#4}}\
    \vcenteredhbox{\textcolor{#4}{#3}}}

\newcommand{\iconhref}[5]{\vcenteredhbox{\icon{#1}{#2}{#5}}\
    \href{#4}{\textcolor{#5}{#3}}}

\newcommand{\iconemail}[5]{\vcenteredhbox{\icon{#1}{#2}{#5}}\
    \href{mailto:#4}{\textcolor{#5}{#3}}}

% Custom icon command
\newcommand{\customicon}[2]{%
    \includegraphics[width=#2pt,height=#2pt]{#1}%
}
\newcommand{\customicontext}[4]{%
    \vcenteredhbox{\customicon{#1}{#2}}\ \vcenteredhbox{\textcolor{#4}{#3}}%
}

%=======================================================================%
%   EU-STYLE MAIN ENTRIES
%=======================================================================%
% Usage: \cvent{dates}{position}{employer}{place}{description} -> shows line
% Usage: \cvent[noline]{dates}{position}{employer}{place}{description} -> hides line
\newcommand{\cvent}[6][line]{% 1=toggle 2=dates 3=position 4=employer 5=place 6=description
    \begin{tabularx}{1\mpwidth}{@{}L{0.14\mpwidth}@{\hspace{2ex}}X@{}}
        \textcolor{bgcol}{\footnotesize\textbf{#2}} &
        \textbf{#3} \vspace{1pt} \newline
        \textcolor{accentcol}{\textbf{#4}}\ifthenelse{\isempty{#5}}{}{, \textcolor{bgcol}{{\footnotesize\faMapMarker*}\ #5}} \vspace{1pt} \newline
        \small\textcolor{black}{#6}
    \end{tabularx}
    \par\vspace{4pt}
    \ifthenelse{\equal{#1}{line}}{\textcolor{softcol}{\hrule}\vspace{6pt}}{\vspace{2pt}}
}

% Usage: \cventwide{dates}{position}{employer}{place}{description} -> shows line
% Usage: \cventwide[noline]{dates}{position}{employer}{place}{description} -> hides line
\newcommand{\cventwide}[6][line]{% 1=toggle 2=dates 3=position 4=employer 5=place 6=description
    \noindent
    \begin{tabularx}{\linewidth}{@{}p{0.10\linewidth} X@{}}
        \textcolor{bgcol}{\footnotesize\textbf{#2}} &
        {\textbf{#3} \hfill \textcolor{accentcol}{\textbf{#4}} \ifthenelse{\isempty{#5}}{}{, \textcolor{bgcol}{{\footnotesize\faMapMarker*}\ #5}}} \\[2pt] & \small\textcolor{black}{#6}
    \end{tabularx}
    \par\vspace{4pt}
    \ifthenelse{\equal{#1}{line}}{\textcolor{softcol}{\hrule}\vspace{6pt}}{\vspace{2pt}}
}

%=======================================================================%
%  BULLET LISTS
%=======================================================================%
\newcommand{\cvbullet}[1]{\parbox{1\mpwidth}{\larrow{softcol}\ #1}\vspace{3pt} }
\newcommand{\minibull}{\textcolor{softcol}{\scriptsize\faAngleRight}\hspace{0.6em}}
