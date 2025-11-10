% example: tautology
% intended semantics: nothing is known

% K(p \/ ¬p)
form(box(all, neg(and(p,neg(p))))).

succ(p, q).