% Aufgabe 1.1

% Scenario:
% Kundenzufriedenheit:
% - zufrieden
% - neutral
% - unzufrieden
% Kriterien der Liste:
% - Preis
% - Erscheinungsdatum
% - Lieferzeit (Tage)
% - Garantie (Monate)

d([525, 1999, 8, 24], unzufrieden).
d([245, 2000, 12, 24], unzufrieden).
d([980, 1995, 7, 48], unzufrieden).
d([360, 2008, 4, 24], neutral).
d([221, 2013, 5, 48], neutral).
d([540, 2000, 6, 96], neutral).
d([105, 2014, 5, 48], zufrieden).
d([286, 2016, 2, 96], zufrieden).
d([693, 2009, 1, 96], zufrieden).

% Aufgabe 1.2
% e_Distanz(+A, +B, -Distanz).
e_Distanz(A, B, Distanz) :-
    e_Distanz_sum(A, B, Sum),
    Distanz is sqrt(Sum).

e_Distanz_sum([], [], 0).
e_Distanz_sum([A|As], [B|Bs], Sum) :-
    Diff is B - A,
    e_Distanz_sum(As, Bs, Next),
    Sum is Next + Diff * Diff.

%% ?- e_Distanz([1,2,3],[1,2,3],X).
%% X = 0.0.
%% ?- e_Distanz([4,0,0],[8,0,0],X).
%% X = 4.0.
%% ?- e_Distanz([1,2,3],[3,2,1],X).
%% X = 2.8284271247461903.

% Aufgabe 1.3
% erstelle_Liste(+Test, -Liste).
erstelle_Liste(Test, Liste) :-
    findall(Element, erstelle_Eintrag(Element, Test), Liste).

%Hilfsfunktion
erstelle_Eintrag(Distanz - Klasse, Test) :-
    d(Data, Klasse),
    e_Distanz(Data, Test, Distanz).

% Aufgabe 1.4
% klassenzuordnung(+Test, -Klasse).
klassenzuordnung(Test, Klasse) :-
    erstelle_Liste(Test, Liste),
    keysort(Liste, [Best|_]),
    Best = _ - Klasse.
