% approach:
% define an ordering on subformulas that can be used to derive an ordering on the worlds that can be iterated
% positively derive satisfaction of a formula in all worlds by traversing the ordering-induced successor-relation on the worlds
% for this, require an ordering on atoms to be given by the user via succ/2 where succ(P,Q) expresses that Q is the direct successor of P in the ordering

% pref(F, G) expresses that formula F is before formula G in the preference ordering

% induction base: specified relation on atoms
pref(F, G) :- succ(F, G).

% explicitly obtain the size
atom(A) :- subf(A), succ(A, _).
atom(A) :- subf(A), succ(_, A).

size(A, 1) :- atom(A).
size(neg(F), S+1) :- subf(neg(F)), size(F, S).
size(box(U, F), S+1) :- subf(box(U, F)), size(F, S).
size(and(F, G), S+T) :- subf(and(F, G)), size(F, S), size(G, T).

% preference based on different sizes
pref(F, G) :- size(F, S), size(G, T), S < T.
same_size(F, G) :- size(F, S), size(G, S).

% preference based on same size (tie breaking)
pref(neg(F), neg(G)) :- same_size(F, G), subf(neg(F)), subf(neg(G)), pref(F, G).
pref(neg(F), box(S, G)) :- same_size(F, G), subf(neg(F)), subf(box(S, G)).
pref(box(S, F), box(U, G)) :- same_size(F, G), subf(box(S, F)), subf(box(U, G)), pref(S, U).
pref(box(S, F), box(S, G)) :- same_size(F, G), subf(box(S, F)), subf(box(S, G)), pref(F, G).
pref(box(S, F), and(G, H)) :- same_size(box(S, F), and(G, H)), subf(box(S, F)), subf(and(G, H)).
pref(and(F, G1), and(F, G2)) :- same_size(G1, G2), subf(and(F, G1)), subf(and(F, G2)), pref(G1, G2).
pref(and(F1, G1), and(F2, G2)) :- same_size(and(F1, G1), and(F2, G2)), subf(and(F1, G1)), subf(and(F2, G2)), pref(F1, F2).

% transitive closure
pref(X, Z) :- pref(X, Y), pref(Y, Z).

% for S4F satisfiability, we make use of the small model property:
% we need at most as many worlds as there are boxes in the theory
world(box(U, F)) :- subf(box(U, F)).

% since boxes are subformulas, the (strict) order on subformulas is an order on worlds
% we now make this order on worlds iterable:
% obtain a relation of direct successors on worlds
% the worlds and the relation do not depend on guesses, only on subf/1, that is, on form/1

% two worlds are indirectly related if there is some world in between
indirect(F, H) :- world(F), world(G), world(H), pref(F, G), pref(G, H).

% G is the next world after F if there is no world in between
next(F, G) :- world(F), world(G), pref(F, G), not indirect(F, G).

% a world has a previous world
hasPrev(G) :- next(_, G).

% a world is the first if it has no previous world
first(F) :- world(F), not hasPrev(F).

% a world is the last world if it has no next world
hasNext(F) :- next(F, _).
last(G) :- world(G), not hasNext(G).

% detect the case when there is no inner world for some standpoint name S
% allouter(S, W, K) expresses that every world V up to and including W is: not in S or an outer world (relative to copy K)
% in particular, it says that all S-worlds up to and including W are outer worlds
allouter(S, W, K) :- first(W), stan(S, W, K), outer(W, K).
allouter(S, W, K) :- first(W), nstan(S, W, K).
allouter(S, W, K) :- allouter(V, K), next(V, W), stan(S, W, K), outer(W, K).
allouter(S, W, K) :- allouter(V, K), next(V, W), nstan(S, W, K).
allouter(S, K) :- allouter(S, W, K), last(W).

% temporarily check for unintended properties
% incomp(F, G) :- subf(F), subf(G), F != G, not pref(F, G), not pref(G, F).
% incomp :- incomp(_, _).

% cycle :- pref(C, C).
% cycle(C) :- pref(C, C).

% :- not cycle, not incomp.
