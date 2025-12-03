% % % % % % % % % % %
% Knowledge base
% % % % % % % % % % %


% xa <- b
% xb <- a
form(box(all,neg(b))).
prereqfreedefault(s2,b,neg(a)).
prereqfreedefault(s1,a,w).
% prereqfreedefault(s1,s,neg(w)).

sharpens(s1,s2).


% % % % % % % % % % %
% Needed
% % % % % % % % % % % 
succ(a,b).
succ(b,s).
succ(s,w).

% 
succ(all,s1).
succ(s1,s2).
succ(s2,s3).


% % % % % % % % % % %
% Instance
% % % % % % % % % % %
