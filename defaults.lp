default(S, P, Q, Q) :- normaldefault(S, P, Q).

form(neg(and(and(box(S,P),box(S, neg(box(S, neg(Q))))),neg(box(S, R))))) :- default(S, P, Q, R).

form(neg(and(box(S, neg(box(S, neg(J)))),neg(box(S, C))))) :- prereqfreedefault(S,J,C).