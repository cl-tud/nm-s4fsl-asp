% % % % % % % % % % %
% Knowledge base
% % % % % % % % % % %

%  y -> x
transform(implies(y,x)).  

% Box_s1[(a and b): -x / p]
default(s1,and(a,b),neg(x),p).


% Box_s2[(a and b) or (a and c) or (b and c): -x / p]
default(s2, neg(and(and(neg(and(a,b)), neg(and(a,c))),  neg(and(b,c)))), neg(x), p).

% this doesn't work
% default(s2,transform(or(transform(or(and(a,b),and(a,c))),and(b,c))),neg(x),p).


% Box_s3[a and (b or c): -y / p]
default(s3,and(a,neg(and(neg(b),neg(c)))), neg(y),p).

% this doesn't work
% default(s3,and(a,transform(or(b,c))), neg(y),p).

% % % % % % % % % % %
% Needed
% % % % % % % % % % % 
succ(a,b).
succ(b,c).
succ(c,p).
succ(p,x).
succ(x,y).

% 
succ(all,s1).
succ(s1,s2).
succ(s2,s3).


% % % % % % % % % % %
% Instance
% % % % % % % % % % %

form(box(all,a)).
% form(box(all,b)).
form(box(all,c)).

% form(box(all,x)).  % <- uncomment one of these
form(box(all,y)).  %  <- uncomment one of these