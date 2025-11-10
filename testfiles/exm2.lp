% example: simple theory
% intended semantics: both p and q are known

% Kp
form(box(s, p)).
% Kp → Kq
form(neg(and(box(s, p),neg(box(s, q))))).

% ordering
succ(p, q).