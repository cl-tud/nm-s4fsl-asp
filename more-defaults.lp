% And
and(A1,and(A2,A3)) :- and3(A1,A2,A3).
and(A1,and3(A2,A3,A4)) :- and4(A1,A2,A3,A4).
and(A1,and4(A2,A3,A4,A5)) :- and5(A1,A2,A3,A4,A5).
and(A1,and5(A2,A3,A4,A5,A6)) :- and6(A1,A2,A3,A4,A5,A6).
and(A1,and6(A2,A3,A4,A5,A6,A7)) :- and7(A1,A2,A3,A4,A5,A6,A7).
and(A1,and7(A2,A3,A4,A5,A6,A7,A8)) :- and8(A1,A2,A3,A4,A5,A6,A7,A8).
and(A1,and8(A2,A3,A4,A5,A6,A7,A8,A9)) :- and9(A1,A2,A3,A4,A5,A6,A7,A8,A9).
and(A1,and9(A2,A3,A4,A5,A6,A7,A8,A9,A10)) :- and10(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10).
and(A1,and10(A2,A3,A4,A5,A6,A7,A8,A9,A10,A11)) :- and11(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11).

% Just
box(S, neg(box(S, neg(A)))) :- just(S,A).



% Basic default skeleton
% form(neg(and(and(
%     box(S,P),
%     Q),
%     neg(box(S, R))))) :- baseDefaultSkeleton(S,P,Q,R).

% Basic default skeleton
form(neg(and(Q,
    neg(box(S, R))))) :- baseDefaultSkeleton(S, Q, R).

% Defaults for each arity
% 1 NoPrem
baseDefaultSkeleton(S,
    just(S,Q1),
    R) :- default1NoPrem(S,Q1,R).

% 1
baseDefaultSkeleton(S,P,
    and(box(S,P),just(S,Q1)),
    R) :- default1(S,P,Q1,R).

% 2 NoPrem 
baseDefaultSkeleton(S,
    and(just(S,Q1),just(S,Q2)),
    R) :- default2NoPrem(S,Q1,Q2,R).

% 2 
baseDefaultSkeleton(S,
    and3(box(S,P),just(S,Q1),just(S,Q2)),
    R) :- default2(S,P,Q1,Q2,R).

% 3 NoPrem
baseDefaultSkeleton(S,
    and3(just(S,Q1),just(S,Q2),just(S,Q3)),
    R) :- default3NoPrem(S,Q1,Q2,Q3,R).

% 3 
baseDefaultSkeleton(S,
    and4(box(S,P),just(S,Q1),just(S,Q2),just(S,Q3)),
    R) :- default3(S,P,Q1,Q2,Q3,R).

% 4 NoPrem
baseDefaultSkeleton(S,
    and4(just(S,Q1),just(S,Q2),just(S,Q3),just(S,Q4)),
    R) :- default4NoPrem(S,Q1,Q2,Q3,Q4,R).

% 4 
baseDefaultSkeleton(S,
    and5(box(S,P),just(S,Q1),just(S,Q2),just(S,Q3),just(S,Q4)),
    R) :- default4(S,P,Q1,Q2,Q3,Q4,R).

% 5 NoPrem
baseDefaultSkeleton(S,
    and5(just(S,Q1),just(S,Q2),just(S,Q3),just(S,Q4),just(S,Q5)),
    R) :- default5NoPrem(S,Q1,Q2,Q3,Q4,Q5,R).

% 5
baseDefaultSkeleton(S,
    and6(box(S,P),just(S,Q1),just(S,Q2),just(S,Q3),just(S,Q4),just(S,Q5)),
    R) :- default5(S,P,Q1,Q2,Q3,Q4,Q5,R).

% 6 NoPrem
baseDefaultSkeleton(S,
    and6(just(S,Q1),just(S,Q2),just(S,Q3),just(S,Q4),just(S,Q5),just(S,Q6)),
    R) :- default6NoPrem(S,Q1,Q2,Q3,Q4,Q5,Q6,R).

% 6
baseDefaultSkeleton(S,P,
    and7(box(S,P),just(S,Q1),just(S,Q2),just(S,Q3),just(S,Q4),just(S,Q5),just(S,Q6)),
    R) :- default6(S,P,Q1,Q2,Q3,Q4,Q5,Q6,R).

% 7 NoPrem
baseDefaultSkeleton(S,
    and7(just(S,Q1),just(S,Q2),just(S,Q3),just(S,Q4),just(S,Q5),just(S,Q6),just(S,Q7)),
    R) :- default7NoPrem(S,Q1,Q2,Q3,Q4,Q5,Q6,Q7,R).

% 7
baseDefaultSkeleton(S,
    and8(box(S,P),just(S,Q1),just(S,Q2),just(S,Q3),just(S,Q4),just(S,Q5),just(S,Q6),just(S,Q7)),
    R) :- default7(S,P,Q1,Q2,Q3,Q4,Q5,Q6,Q7,R).

% 8 NoPrem
baseDefaultSkeleton(S,
    and8(just(S,Q1),just(S,Q2),just(S,Q3),just(S,Q4),just(S,Q5),just(S,Q6),just(S,Q7),just(S,Q8)),
    R) :- default8NoPrem(S,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,R).

% 8
baseDefaultSkeleton(S,
    and9(box(S,P),just(S,Q1),just(S,Q2),just(S,Q3),just(S,Q4),just(S,Q5),just(S,Q6),just(S,Q7),just(S,Q8)),
    R) :- default8(S,P,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,R).

% 9 NoPrem
baseDefaultSkeleton(S,
    and9(just(S,Q1),just(S,Q2),just(S,Q3),just(S,Q4),just(S,Q5),just(S,Q6),just(S,Q7),just(S,Q8),just(S,Q9)),
    R) :- default9NoPrem(S,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,R).

% 9 
baseDefaultSkeleton(S,
    and10(box(S,P),just(S,Q1),just(S,Q2),just(S,Q3),just(S,Q4),just(S,Q5),just(S,Q6),just(S,Q7),just(S,Q8),just(S,Q9)),
    R) :- default9(S,P,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,R).

% 10 NoPrem
baseDefaultSkeleton(S,
    and10(just(S,Q1),just(S,Q2),just(S,Q3),just(S,Q4),just(S,Q5),just(S,Q6),just(S,Q7),just(S,Q8),just(S,Q9),just(S,Q10)),
    R) :- default10NoPrem(S,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,R).

% 10
baseDefaultSkeleton(S,
    and11(just(S,Q1),just(S,Q2),just(S,Q3),just(S,Q4),just(S,Q5),just(S,Q6),just(S,Q7),just(S,Q8),just(S,Q9),just(S,Q10)),
    R) :- default10(S,P,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,R).

% Strict rule <- has no assumptions
form(neg(and(
    box(S,P),
    neg(box(S, R))))) :- strictRule(S, P, R).