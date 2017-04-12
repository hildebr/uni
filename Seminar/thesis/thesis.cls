% my thesis

% First identify the class:

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions

\LoadClass{report}

% add dots to chapters in TOC
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}  \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}


% no indentation for paragraphs and space inbetween paragraphs  (euro standard)
% this happens to spread also the table of contents, list of figures and tables
\setlength{\parindent}{0pt}
\setlength{\parskip}{7pt plus 2pt minus 1pt}


% Make the captions in your floats of the form:
% Figure 1 -> Fig. 1

\renewcommand{\figurename}{Fig.}
\renewcommand{\contentsname}{Table of Contents}


% force footnotes to the bottom
\usepackage[bottom]{footmisc}


% Redefining the \section command:

%\renewcommand{\section}{\@startsection
%{section}%                   % the name
%{1}%                         % the level
%{0mm}%                       % the indent
%{-\baselineskip}%            % the before skip
%{0.5\baselineskip}%          % the after skip
%{\normalfont\large\itshape}} % the style


% Redefining the chapter heading styles

% Numbered chapter heading style:

\renewcommand{\@makechapterhead}[1]{%
  {\singlespacing
    \parindent \z@ \raggedright \normalfont
    \rule{\textwidth}{2pt}                           % horizontal line
    \vspace{5pt}%                                    % add some vertical space
    \ifnum \c@secnumdepth >\m@ne
        \huge\scshape \@chapapp\space \thechapter    % Chapter followed by number
        \par\nobreak
    \fi
    \interlinepenalty\@M
    \huge \scshape \bf #1\par                        % chapter title
    \vspace{5pt}%                                    % add some vertical space
    \nobreak
    \vskip 40\p@
  }}

% Unnumbered chapter heading style:

\renewcommand{\@makeschapterhead}[1]{%
  {\singlespacing
    \parindent \z@ \raggedright
    \normalfont
    \rule{\textwidth}{2pt}                           % horizontal line
    \vspace{5pt}%                                    % add some vertical space
    \interlinepenalty\@M
    \huge \scshape \bf #1\par                        % chapter title
    \vspace{5pt}%                                    % add some vertical space
    \nobreak
    \vskip 40\p@
  }}


% end of file:
\endinput
