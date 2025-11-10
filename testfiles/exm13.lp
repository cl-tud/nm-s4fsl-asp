% keeping defaults local
% intended semantics: supernormal default is applied in standpoint s
% not-p holds in standpoint u

% supernormal default p should be local to s
normaldefault(s, neg(and(p, neg(p))), p).

% p being false should be local to u
form(box(u, neg(p))).

succ(p, q).