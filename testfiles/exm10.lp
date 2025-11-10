% default theory {p, p:q/q}
% intended semantics: both p and q are known in standpoint s
% here we use another standpoint name, s rather than all

% p
form(box(s, p)).

% p:q/q
normaldefault(s, p, q).


succ(p,q).
