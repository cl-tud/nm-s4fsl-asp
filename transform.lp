% transform formulas in nicer syntax into restricted syntax
% use transform/1 to declare that the argument is a formula in extended syntax whose restricted syntax equivalent is an element of the theory

form(G) :- transform(F), transform(F, G).
transub(F) :- transform(F).
transub(F) :- transub(neg(F)).
transub(F) :- transub(or(F,_)).
transub(F) :- transub(or(_,F)).
transub(F) :- transub(and(F,_)).
transub(F) :- transub(and(_,F)).
transub(F) :- transub(implies(F,_)).
transub(F) :- transub(implies(_,F)).
transub(F) :- transub(box(_, F)).
transub(F) :- transub(diamond(_, F)).

% assume that atoms are declared
atom(P) :- succ(P, _).
atom(P) :- succ(_, P).

% actual transformations
transform(P, P) :- transub(P), atom(P).
transform(neg(F), neg(F1)) :- transub(neg(F)), transform(F, F1).
transform(and(F,G), and(F1,G1)) :- transub(and(F,G)), transform(F, F1), transform(G, G1).
transform(or(F,G), neg(and(neg(F1),neg(G1)))) :- transub(or(F,G)), transform(F, F1), transform(G, G1).
transform(implies(F,G), neg(and(F1, neg(G1)))) :- transub(implies(F,G)), transform(F, F1), transform(G, G1).
transform(box(S,F), box(S, F1)) :- transub(box(S,F)), transform(F, F1).
transform(diamond(S,F), neg(box(S, neg(F1)))) :- transub(diamond(S,F)), transform(F, F1).