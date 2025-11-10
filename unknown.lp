%% (C2): for every F with unknown(F), we have that theta \cup neg(F) is propositionally satisfiable 
%% idea: create |unknown/1| many copies of the propositional atoms, do the above satisfiability check (plus the negated formula) on each copy independently
pa(P, U) :- pa(P), unknown(U).

% guess a propositional valuation in each copy
t(P, S, U) | f(P, S, U) :- pa(P, U), sn(S).

%% localise the formulas in theta to the formulas in Phi:

% create a localised copy of Theta_S, localised to box(T, G), whenever T =< S

theta(F, S, box(T, G)) :- theta(F, S), unknown(box(T, G)), sharpens(T, S).
theta(neg(G), S, box(T, G)) :- unknown(box(T, G)), sharpens(T, S).

% check relevant formula from unkown below

% evaluate the copies of theta independently
true(P, S, U) :- t(P, S, U).
false(P, S, U) :- f(P, S, U).
true(neg(F), S, U) :- subf(neg(F)), false(F, S, U).
false(neg(F), S, U) :- subf(neg(F)), true(F, S, U).
true(and(F,G), S, U) :- subf(and(F,G)), true(F, S, U), true(G, S, U).
false(and(F,G), S, U) :- subf(and(F,G)), false(F, S, U).
false(and(F,G), S, U) :- subf(and(F,G)), false(G, S, U).

% make sure all the copies of theta are satisfied by their respective valuation
:- theta(F, S, U), not true(F, S, U).
