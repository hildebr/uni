\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2015/10/26 Homework class]

%% Optionen, die an article.cls weitergegeben werden sollen...
\DeclareOption{12pt,a4paper}{
  \PassOptionsToClass{\CurrentOption}{article}
}

%% Fallback, falls ein Parameter unbekannt ist...
\DeclareOption*{
  \ClassWarning{homework}{Unknown option '\CurrentOption'}
}

%% Default options...
\ExecuteOptions{12pt}

%% Process given options...
\ProcessOptions\relax

%% Superklasse laden...
\LoadClass[12pt,a4paper]{article}

%% Abhängigkeiten laden...
\RequirePackage[utf8]{inputenc}
\RequirePackage[ngerman]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{titling}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{datetime}
\RequirePackage[
	headsep=1cm,
	headheight=2cm,
	left=2cm,
	right=2cm,
	bottom=2.5cm
]{geometry}

%%----------%%
%% Es folgt der Kram, der sonst in der Präambel wäre, also hauptsächlich Definitionen.
%%----------%%

%% Mit \datef kann man nun das Datum im DD.MM.YYYY-Format eingeben.
%% Dabei wird dann \@date direkt überschrieben.
\newcommand{\datef}[3]{
	\newdate{datex}{#1}{#2}{#3}
	\date{\protect\displaydate{datex}}
}
%% Standardmäßig zeigt \thedate das Datum im US-Format an.
%% In \@date steht es hingegen richtig drin.
%% Das \makeat(...) ist nötig, weil LaTeX sonst mit dem @ nicht klar kommt.
\let\oldthedate\thedate
\makeatletter
\let\thedate\@date
\makeatother

%% Kleine Arbeitserleichterung, weil \fontsize so kacke ist
\newcommand{\size}[1]{
	\fontsize{#1}{\number\numexpr#1*6/5\relax} \selectfont
}

\makeatletter

%% \setter#1#2 definiert eine Überschreibfunktion für Variablen.
%% #1 ist die Variable, die Überschrieben werden soll.
%% #2 ist der Name der Funktion.
\newcommand{\setter}[2]{
	\newcommand{#2}[1]{
		\renewcommand{#1}{##1}
	}
}
%% \newstring#1#2#3 definiert eine String-Variable mit einem Setter.
%% #1 ist der Name der Variable, vorzugsweise \@variable oder \thevariable.
%% \@variable wird üblicherweise für lokale (versteckte) Varianblen verwendet,
%% da es nur über \makeatletter...\makeatother verfügbar ist.
%% \thevariable wird für Variablen verwendet, die innerhalb der Klasse lesbar sein sollen.
%% #2 ist der Name der Überschreibfunktion, vorzugsweise \variable.
%% Wird \variable{Wert} verwendet, kann man den Wert danach aus der Variable lesen.
%% #3 ist der Standardwert der Variable.
\newcommand{\newstring}[3]{
	\newcommand{#1}{#3}
	\setter{#1}{#2}
} 

%% \thecourse ist der Kursname
\newstring {\@courseprefix}        {\courseprefix}        {Übungen }
\newstring {\thecourse}            {\course}              {}
\newstring {\@coursesuffix}        {\coursesuffix}        {}
\newcommand{\thecoursetext}{\@courseprefix\thecourse\@coursesuffix}
%% \thesheet ist die fortlaufende Nummer des Arbeitsbogens
\newstring {\@sheetprefix}         {\sheetprefix}         {Blatt }
\newstring {\thesheet}             {\sheet}               {0}
\newstring {\@sheetsuffix}         {\sheetsuffix}         {}
\newcommand{\thesheettext}{\@sheetprefix\thesheet\@sheetsuffix}
%% \thegroup ist die Übungsgruppennummer
\newstring {\@groupprefix}         {\groupprefix}         {Gruppe }
\newstring {\thegroup}             {\group}               {0}
\newstring {\@groupsuffix}         {\groupsuffix}         {}
\newcommand{\thegrouptext}{\@groupprefix\thegroup\@groupsuffix}
%% Sections erhalten ebenfalls jeweils einen optionalen Pre- und Suffix.
%% \the(...)section ist bereits definiert und enthält den Counter.
\newstring {\@sectionprefix}       {\sectionprefix}       {Aufgabe }
\newstring {\@sectionsuffix}       {\sectionsuffix}       {:}
\newstring {\@subsectionprefix}    {\subsectionprefix}    {}
\newstring {\@subsectionsuffix}    {\subsectionsuffix}    {:}
\newstring {\@subsubsectionprefix} {\subsubsectionprefix} {}
\newstring {\@subsubsectionsuffix} {\subsubsectionsuffix} {:}
%%
\newcommand{\thepagetext}{\thepage\ /\ \pageref{LastPage}}


%% Falls man den Counter der Sections umformatieren möchte...
%% Z.B.: Römische Zahlen für Sections: \sectioncounter{\Roman{section}}
\setter {\thesection}       {\sectioncounter}
\setter {\thesubsection}    {\subsectioncounter}
\setter {\thesubsubsection} {\subsubsectioncounter}

%% Kopf- und Fußzeile formatieren...
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\thedate\\ \thegrouptext}
\fancyhead[R]{\theauthor}
\fancyfoot[C]{\thepagetext}
\renewcommand{\headrulewidth}{0.5pt} %obere Trennlinie
\renewcommand{\footrulewidth}{0.5pt} %untere Trennlinie

%% Headline formatieren...
\newcommand{\makecoursetext}{
	\centerline{ \size{20} \textbf{\thecoursetext} }
}
\newcommand{\makesheettext}{
	\centerline{ \size{18} \textbf{\thesheettext} }
}
\newcommand{\makeheadline}{
	\makecoursetext
	\vspace{2 mm}
	\makesheettext
}

%% (sub)(sub)sections formatieren...
\titleformat{\section}
{\normalfont\size{16}\bfseries}
{\@sectionprefix\thesection\@sectionsuffix}
{1em}{}[\vspace{-3mm}]

\titleformat{\subsection}
{\normalfont\size{14}\bfseries}
{\@subsectionprefix\thesubsection\@subsectionsuffix}
{1em}{}[\vspace{-1mm}]

\titleformat{\subsubsection}
{\normalfont\size{12}\bfseries}
{\@subsubsectionprefix\thesubsubsection\@subsubsectionsuffix}
{1em}{}[\vspace{-1mm}]

\makeatother


\endinput