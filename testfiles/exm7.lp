% example: encoding of credulous reasoning
% intended semantics: only the minimal model with p remains

% this formula on its own has two minimal models
form(neg(and(neg(box(all, p)),neg(box(all, q))))).

% this formula acts as a constraint that disables all minimal models where box(all, p) holds
form(neg(and(and(box(all, neg(box(all, z))),neg(box(all, neg(box(all,p))))),neg(box(all, z))))).

succ(p, q).
succ(q, z).