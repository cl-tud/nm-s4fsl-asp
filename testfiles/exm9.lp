% default theory {p, p:q/q}
% intended semantics: both p and q are known

% p
form(box(all, p)).

% p:q/q
normaldefault(s, p, q).

succ(p,q).