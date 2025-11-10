% example
% multiple defaults in different standpoints

default(S, P, Q, Q) :- normaldefault(S, P, Q).

form(neg(and(and(box(S,P),box(S, neg(box(S, neg(Q))))),neg(box(S, R))))) :- default(S, P, Q, R).


normaldefault(all,p,q).
normaldefault(s1,p1,q1).
normaldefault(s2,p2,q2).
form(box(all,p)).
form(box(s1,p1)).
form(box(s2,p2)).

succ(p,q).
succ(q,p1).
succ(p1,q1).
succ(q1,p2).
succ(p2,q2).
