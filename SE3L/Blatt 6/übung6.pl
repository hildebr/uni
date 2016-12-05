%Aufgabe 1

%goldener_schnitt(+Schritte, ?Resultat)
goldener_schnitt(0, 2).
goldener_schnitt(Schritte, Resultat) :- Schritte > 0, Schritte2 is Schritte - 1, goldener_schnitt(Schritte2, Resultat2), Resultat is 1 / Resultat2 + 1.

%.....
goldenerSchnittE(0,Akk,Res) :- Res = Akk.
goldenerSchnittE(Schritte, Akk, Res) :- Schritte > 0, Schritte1 is Schritte - 1, Akk1 is 1 / Akk + 1,
                                        goldenerSchnittE(Schritte1, Akk1, Res).

%time harter unteschied, verständlichkeit gleich
%time(goldener_schnitt(1000000, Res)).

%fibonacci ineffizient weil 2 rekursiv aufrufe nötig
%.....
fibonacci(Schritte, Resultat) :- fibonacci_(Schritte, 1, 0, Resultat).
fibonacci_(0, _, Prev, Prev).
fibonacci_(1, Val, _, Val).
fibonacci_(Schritte, Val, Prev, Resultat) :- Schritte >= 0, Schritte2 is Schritte - 1, ValPrev is Val + Prev, fibonacci_(Schritte2, ValPrev, Val, Resultat).

%.....
goldener_schnitt_fib(Schritte, Resultat) :- fibonacci(Schritte, Resultat1), Schritte2 is Schritte -1, fibonacci(Schritte2, Resultat2), Resultat is Resultat1 / Resultat2.

%time(goldener_schnitt_fib(1000000, Res)).


%Aufgabe2
%....
goldener_schnitt_incr(Schritte, Resultat) :-
    goldener_schnitt_incr_schritt(1, Schritte, Resultat).

goldener_schnitt_incr_schritt(Akku, 0, Akku).
goldener_schnitt_incr_schritt(Akku, SchrittLinks, Resultat) :-
    SchrittLinks > 0,
    (Resultat is Akku; (
        Zwischen is ((1 / Akku) + 1),
        SchrittLinksJetzt is SchrittLinks - 1,
        goldener_schnitt_incr_schritt(Zwischen, SchrittLinksJetzt, Resultat)
    )).


%bei 9 gibts eine linie

%typtest
typTestBaum(s(B,C)) :- typTestBaumSub(B), typTestBaumSub(C).

typTestBaumSub(A) :- atom(A).
typTestBaumSub(A) :- typTestBaum(A).


%spitze zu blatt

blatttiefe(Baum, 0) :-
    atom(Baum).

blatttiefe(s(X, Y), Tiefe) :-
    typTestBaum(s(X, Y)),
    blatttiefe(X, XTiefe),
    Tiefe is XTiefe + 1.

blatttiefe(s(X, Y), Tiefe) :-
    typTestBaum(s(X, Y)),
    blatttiefe(Y, YTiefe),
    Tiefe is YTiefe + 1.

%2.
baumTiefe(s(B,C), Akk, RL, RR) :- baumTiefeSubL(B, Akk, RL), baumTiefeSubR(C, Akk, RR).
baumTiefeSubL(A, Akk, RL) :- atom(A), RL is Akk.
baumTiefeSubL(A, Akk, RL) :- Akk1 is Akk + 1, baumTiefe(A, Akk1, RL, _).
baumTiefeSubR(A, Akk, RR) :- atom(A), RR is Akk.
baumTiefeSubR(A, Akk, RR) :- Akk1 is Akk + 1, baumTiefe(A, Akk1, RR, _).
