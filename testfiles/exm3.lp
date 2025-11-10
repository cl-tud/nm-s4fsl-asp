% example: satisfiable theory without minimal model
% intended semantics: no minimal model

% K¬Kp → Kp
form(neg(and(box(all, neg(box(all, p))),neg(box(all, p))))).

succ(p, q).
