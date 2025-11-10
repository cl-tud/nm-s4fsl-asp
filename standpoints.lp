% obtaining the hierarchy of standpoint names
% from explicitly given sharpening statements
% sharpens(S, U) ... S sharpens U ... S =< U

% reflexive pairs
sharpens(S, S) :- sn(S).

% everything sharpens *
sharpens(S, all) :- sn(S).

% transitive closure
sharpens(S, U) :- sharpens(S, T), sharpens(T, U).
