% % % % % % % % % % %
% Knowledge base
% % % % % % % % % % %

%  p -> h
% (- p or h)
% --(-p or h)
% -(p and -h)
form(neg(and(p,neg(h)))).  

%  f -> -h
% (- f or -h)
% --(-f or -h)
% -(f and -h)
form(neg(and(f,h))).  

% T:-p/-p  
% form(neg(and(                  %  <- uncomment
%     box(all,neg(box(all,p))),
%     neg(box(all,neg(p)))
% ))).  

% Box_all[o:p/p]
form(neg(
        and(
            and(
                box(all,o),  % prerequisite
                box(all,neg(box(all,neg(p)))) % justification 1
            ),   
            neg(box(all,p))
        )
    )
).

% Box_all[o:-pr,f/f]
form(neg(
        and(
            and(
                box(all,o),  % prerequisite
                and(
                    box(all,neg(box(all,pr))), % justification 1
                    box(all,neg(box(all,neg(f)))) % justification 2
                )
            ),   
            neg(box(all,f))
        )
    )
).

% needed 
succ(all,s1).

succ(o,p).
succ(p,pr).
succ(pr,f).
succ(f,h).



% % % % % % % % % % %
% Instance
% % % % % % % % % % %
form(box(all,o)).
form(box(all,pr)).

% form(box(all,x)). <- uncomment one of these
% form(box(all,y)). <- uncomment one of these


% % % % % % % % % % %
% Expected behaviour
% % % % % % % % % % %
