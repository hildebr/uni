peano(0).
peano(s(X)) :- peano(X).

ht(s(_),0).
ht(0,0).
ht(s(X),s(Y)) :- ht(X,Y).

dB2(0, Q, R) :- Q is 0, R is 0.
dB2(s(0),Q,R) :- Q is 0, R=s(0).
dB2(s(s(X)), Q, R) :- dB2(X, Q1, R), Q=s(Q1).

max(A,B,M) :- ht(A,B), M=A.
max(A,B,M) :- ht(B,A), M=A.

pAdd(0, B, R) :- R = B.
pAdd(s(A), B, S) :- pAdd(A,s(B),S).

wertOderNull(_,0,E) :- E = 0.
wertOderNull(W,_,E) :- E = W.

produkt(0,_,PRODUKT) :- PRODUKT = 0.
produkt(s(0),MPKAND,PRODUKT) :- PRODUKT = MPKAND.

produkt(MPKTOR,MPKAND,PRODUKT) :-
	dB2(MPKTOR,MPKTOR2,REST),
	dB2(MPKAND2,MPKAND,0),
	produkt(MPKTOR2,MPKAND2,PRODUKT2),
	wertOderNull(MPKAND,REST,A),
	pAdd(PRODUKT2,A,PRODUKT).

einordnungH(Name, Art, Oberklasse):-sub(Name,_,Oberklasse), sub(Oberklasse, Art, _).
einordnungH(Name, Art, Oberklasse):-sub(Name,_,Oberklasse), reich(Oberklasse), Art = reich.
einordnungH(Name, Art, Oberklasse):-sub(Name,_,Unterklasse), einordnungH(Unterklasse, Art, Oberklasse).
einordnung(Name, L) :- findall((Art, Oberklasse), einordnungH(Name,Art,Oberklasse), L).
