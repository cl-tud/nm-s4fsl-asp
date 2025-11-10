% here we encode an simple default:
% p:q/q
% in its S4F standpoint logic variant

form(neg(and(and(box(all,p),box(all,neg(box(all,neg(q))))), neg(box(all,q))))).
form(box(all,p)).

succ(p,q).