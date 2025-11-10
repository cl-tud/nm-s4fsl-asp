% (C1): theta_s is propositionally satisfiable

% first obtain propositional atoms
pa(P) :- atom(P).
pa(box(U, F)) :- subf(box(U, F)).

% for every standpoint name,
% guess a satisfying assigment for the propositional atoms
t(P, S) | f(P, S) :- pa(P), sn(S).

% evaluate formulas propositionally
true(P, S) :- t(P, S).
false(P, S) :- f(P, S).
true(neg(F), S) :- subf(neg(F)), false(F, S).
false(neg(F), S) :- subf(neg(F)), true(F, S).
true(and(F,G), S) :- subf(and(F,G)), true(F, S), true(G, S).
false(and(F,G), S) :- subf(and(F,G)), false(F, S).
false(and(F,G), S) :- subf(and(F,G)), false(G, S).

% make sure that all formulas in Theta_S are satisfied
:- theta(F, S), not true(F, S).
