% S5 tautology
% intended semantics: one minimal model where nothing is known:
% known(box(all,neg(box(all,p)))) unknown(box(all,p))

form(neg(and(box(all, neg(box(all, p))),neg(box(all, neg(box(all, p))))))).

%form(neg(and(box(all, p), neg(box(all, p))))).

succ(p, q).