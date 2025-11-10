% here we encode an asp program:
% a :- not a.
% in its S4F standpoint logic variant, to check if it has no minimal models, as expected


form(neg(and(box(all,neg(box(all,p))), neg(box(all,p))))).

succ(p,q).