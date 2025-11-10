% example: choice between knowing two things
% intended semantics: two minimal models:
%   1:  known(p)
%   2:  known(q)

% Kp \/ Kq
form(neg(and(neg(box(all,p)),neg(box(all,q))))).

succ(p, q).