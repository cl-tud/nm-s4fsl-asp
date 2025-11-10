% obtain subformulas
subf(F) :- form(F).
subf(neg(F), F) :- subf(neg(F)).
subf(and(F,G), F) :- subf(and(F,G)).
subf(and(F,G), G) :- subf(and(F,G)).
subf(box(S, F), F) :- subf(box(S, F)).
subf(F) :- subf(_, F).

% also consider the negation of a modalised formula to be a formula, because it is put into Theta_S and must be evaluated
subf(neg(box(S, F))) :- subf(box(S, F)).
% the same holds for any formula behind a box
subf(neg(F)) :- subf(box(_, F)).

% identify atomic subformulas
composite(F) :- subf(F, _).
atom(F) :- subf(F), not composite(F).

% identify standpoint names
sn(S) :- subf(box(S, _)).
sn(all).

% obtain relevant subformulas
relevant(box(S, F)) :- subf(box(S, F)).

% for relevant subformulas, guess whether they are known
% that is, guess a partition (\Phi,\Psi)
known(F) | unknown(F) :- relevant(F).

% obtain Theta_S
% theta(F, S) means that formula F is an element of Theta_S
theta(F, S) :- form(F), sn(S).
theta(neg(F), S) :- unknown(F), sn(S).
theta(F, S) :- known(F), sn(S).
theta(F, S) :- known(box(U, F)), sharpens(S, U).
