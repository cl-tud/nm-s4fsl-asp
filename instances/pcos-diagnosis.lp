% % % % % % % % % % %
% Knowledge base
% % % % % % % % % % %

%  y -> x
% (- y or x)
% --(- y or x)
% -(y and -x)
% form(neg(and(y,neg(x)))).  

% T:-p/-p  
% form(neg(and(                  %  <- uncomment
%     box(all,neg(box(all,p))),
%     neg(box(all,neg(p)))
% ))).  

% Box_s1[(a and b): -x / p]
form(neg(
        and(
            and(
                box(s1,and(a,b)),  % prerequisite
                box(s1,neg(box(s1,x))) % justification 1
            ),   
            neg(box(s1,p))
        )
    )
).

% Box_s2[(a and b) or (a and c) or (b and c): -x / p]

%   --(((a and b) or (a and c)) or (b and c))
%   -(-((a and b) or (a and c)) and -(b and c))
%   -((-(a and b) and -(a and c)) and -(b and c))
% and(and(neg(and(a,b)), neg(and(a,c))),  neg(and(b,c)))
form(neg(
        and(
            and(
                box(s2,neg(and(and(neg(and(a,b)), neg(and(a,c))),  neg(and(b,c))))),  % prerequisite
                box(s2,neg(box(s2,x))) % justification 1
            ),   
            neg(box(s2,p))
        )
    )
).


% Box_s3[a and (b or c): -y / p]

% (a and --(b or c))
% (a and -(-b and -c))
% and(a,and(neg(and(neg(b,neg(c))))))
form(neg(
        and(
            and(
                box(s3,and(a,neg(and(neg(b),neg(c))))),  % prerequisite
                box(s3,neg(box(s3,y))) % justification 1
            ),   
            neg(box(s3,p))
        )
    )
).

% needed 
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
form(box(all,c)).

% form(box(all,x)). <- uncomment one of these
% form(box(all,y)). <- uncomment one of these


% % % % % % % % % % %
% Expected behaviour
% % % % % % % % % % %
