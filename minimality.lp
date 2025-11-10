% check minimality: for every F with known(F), we have that "form/1 \cup neg(unknown/1) \cup {neg(F)}" is S4F-unsatisfiable
% idea: use the small model property of S4F standpoint logic to verify unsatisfiability with a given number of worlds 

% for each world, guess whether it's an inner or outer world
inner(W, K) | outer(W, K) :- world(W), known(K).

% for each world and standpoint name, guess whether the world is in that standpoint's set of precisifications
stan(S, W, K) | nstan(S, W, K) :- world(W), known(K), sn(S).

% guess a valuation for every world
t(P, W, K) | f(P, W, K) :- atom(P), world(W), known(K).

% evaluate "form cup unknown cup neg(K)", in a separate copy for each K in known:
% derive positively which formulas hold in which world W, for each copy K
strue(P, W, K) :- t(P, W, K).
sfalse(P, W, K) :- f(P, W, K).
strue(neg(F), W, K) :- subf(neg(F)), sfalse(F, W, K).
sfalse(neg(F), W, K) :- subf(neg(F)), strue(F, W, K).
strue(and(F,G), W, K) :- subf(and(F,G)), strue(F, W, K), strue(G, W, K).
sfalse(and(F,G), W, K) :- subf(and(F,G)), sfalse(F, W, K).
sfalse(and(F,G), W, K) :- subf(and(F,G)), sfalse(G, W, K).
strue(box(S,F), W, K) :- subf(box(S,F)), inner(W, K), boxinner(S, F, K).
strue(box(S,F), W, K) :- subf(box(S,F)), outer(W, K), boxouter(S, F, K).
sfalse(box(S,F), W, K) :- subf(box(S,F)), inner(W, K), inner(X, K), stan(S, X, K), sfalse(F, X, K).
sfalse(box(S,F), W, K) :- subf(box(S,F)), outer(W, K), inner(X, K), stan(S, X, K), sfalse(F, X, K).
sfalse(box(S,F), W, K) :- subf(box(S,F)), outer(W, K), outer(X, K), stan(S, X, K), sfalse(F, X, K).

% in order to positively establish what is known in (inner and outer) worlds,
% iterate over worlds along the ordering, making sure the formula is true in every world

%% boxinner
% boxinner(S, F, W, K) means that for copy K, formula F is known in all inner S-worlds up to and including W (according to the total order on worlds)
% thus for every world in the sequence:
%   (a) it is an inner S-world and F is true there, or
%   (b) it is an S-world, but not an inner world
%   (c) it is not an S-world
boxinner(S, F, W, K) :- first(W), strue(F, W, K), stan(S, W, K), inner(W, K).
boxinner(S, F, W, K) :- first(W), subf(F), stan(S, W, K), outer(W, K).
boxinner(S, F, W, K) :- first(W), subf(F), nstan(S, W, K).

boxinner(S, F, W, K) :- boxinner(S, F, V, K), next(V, W), strue(F, W, K), stan(S, W, K), inner(W, K).
boxinner(S, F, W, K) :- boxinner(S, F, V, K), next(V, W), stan(S, W, K), outer(W, K).
boxinner(S, F, W, K) :- boxinner(S, F, V, K), next(V, W), nstan(S, W, K).

% thus a formula F is known in all inner worlds if it is known in all inner worlds up to the last one
boxinner(S, F, K) :- boxinner(S, F, W, K), last(W).

%% similarly for boxouter
% boxouter(S, F, W, K) means that for copy K, formula F is known in all inner S-worlds, and in all outer S-worlds up to and including W
boxouter(S, F, W, K) :- boxinner(S, F, K), first(W), strue(F, W, K), stan(S, W, K), outer(W, K).
boxouter(S, F, W, K) :- boxinner(S, F, K), first(W), inner(W, K), stan(S, W, K).
boxouter(S, F, W, K) :- boxinner(S, F, K), first(W), nstan(S, W, K).

boxouter(S, F, W, K) :- boxouter(S, F, V, K), next(V, W), strue(F, W, K), stan(S, W, K), outer(W, K).
boxouter(S, F, W, K) :- boxouter(S, F, V, K), next(V, W), inner(W, K), stan(S, W, K).
boxouter(S, F, W, K) :- boxouter(S, F, V, K), next(V, W), nstan(S, W, K).

% a formula is true in all outer S worlds if it is true in all up to the last one
boxouter(S, F, K) :- boxouter(S, F, W, K), last(W).

%% make sure that every S4F structure of maximal size (implicitly including those of lesser size through identical copies) refutes the relevant theory

% a guess is OK if it falsifies some formula in the premises, that is, ...
% ... a formula from the main theory T, or
ok(K) :- form(F), sfalse(F, _, K).
% ... a negated formula from Phi, or
ok(K) :- unknown(F), strue(F, _, K).
% ... or it satisfies the formula box(S,F) whose entailment we check in this copy
ok(box(S,F)) :- known(box(S,F)), boxouter(S, F, box(S, F)).


% we only need to look at the guesses where:
% inner and outer worlds are disjoint
ok(K) :- inner(W, K), outer(W, K).
% and where no atom is both true and false in some world
ok(K) :- t(P, W, K), f(P, W, K).
% and where there are at least some inner worlds for every standpoint name S
ok(K) :- allouter(S, K).
% and where all worlds belong to the universal standpoint
ok(K) :- nstan(all, _, K).
% and where sharpening statements are satisfied
ok(K) :- stan(S, W, K), nstan(U, W, K), sharpens(S, U).
% and in those we need a positively constructive reason for ok
ok(K) :- known(K), not ok(K).

% saturate for this copy if it is OK

t(P, W, K) :- ok(K), atom(P), world(W).
f(P, W, K) :- ok(K), atom(P), world(W).

inner(W, K) :- ok(K), world(W).
outer(W, K) :- ok(K), world(W).

stan(S, W, K) :- ok(K), world(W), sn(S).
nstan(S, W, K) :- ok(K), world(W), sn(S).
