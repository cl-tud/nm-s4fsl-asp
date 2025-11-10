% filter: create spurious disjunction formulas, for each standpoint name S and proposition A create formula:
% Box_S[A] \/ ¬Box_S[A]
%    and 
% Box_S[¬A] \/ ¬Box_S[¬A]
%  which are both trivially true, but which introduce all boxed subformulas to the the theory. This is useful to see what is the stance of the model on each proposition in every standpoint BUT it is very inefficient, and should be just used for debugging.

% It requires each standpoint name S do be defined in pstand(S) and proposition A in patom(A). 

spurious(S,A) :- pstand(S), patom(A).

form(neg(
        and(
            box(S,P), % always true trivially % is this really always true trivially?
            neg(box(S,P))
        )
    )
) :- spurious(S,P).


% 
form(neg(
        and(
            box(S,neg(P)), % always true trivially
            neg(box(S,neg(P)))
        )
    )
) :- spurious(S,P).


% filter
propVar(X) :- succ(X,_).
propVar(X) :- succ(_,X).
k(S,P) :- known(box(S,P)), propVar(P).
k(S,n(P)) :- known(box(S,neg(P))), propVar(P).
#show k/2.

