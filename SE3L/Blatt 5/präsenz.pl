p(1,2).
p(2,3).
p(3,4).

p(A,C) :- p(A,B), p(B, C).

transitiv(A,C) :- p(A,C).
transitiv(A,C) :- p(A,B), transitiv(B,C).

lt(0,s(_)).
lt(s(X), s(Y)) :- lt(X,Y).

%?????????????
sub(X,X,0).
sub(s(X),Y,s(Z)) :- sub(X,Y,Z).
sub(X,s(Y),Z) :- sub(X,Y,sub(Z)).
