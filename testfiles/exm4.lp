% example: AF with self-attacking argument
% intended semantics: no minimal model

% (K¬K¬p → Kp)
form(neg(and(box(all,neg(box(all,neg(p)))),neg(box(all,p))))).

% (Kp → K¬p)
form(neg(and(box(all,p),neg(box(all,neg(p)))))).

succ(p, q).