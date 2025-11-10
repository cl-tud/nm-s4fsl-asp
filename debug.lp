
ok(formfalse(F), K) :- form(F), sfalse(F, _, K).
ok(unknownfalse(neg(F)), K) :- unknown(F), strue(F, _, K).
ok(kfalse(box(S,F)), box(S,F)) :- known(box(S,F)), boxouter(S, F, box(S, F)).

ok(innerouter, K) :- inner(W, K), outer(W, K).
ok(truefalse, K) :- t(P, W, K), f(P, W, K).
ok(allouter, K) :- allouter(S, K).
ok(nstanall, K) :- nstan(all, _, K).
ok(sharpenstan, K) :- stan(S, W, K), nstan(U, W, K), sharpens(S, U).

% we are wondering why box(s, neg(p)) is entailed by the theory
:- not known(box(s, neg(p))).

% and we wish to look at the actual counterexample and why it is checked off the list
:- not inner(box(s,neg(p)), box(s,neg(p))).
:- not inner(box(u,neg(p)), box(s,neg(p))).
:- not inner(box(s,neg(and(p,neg(p)))), box(s,neg(p))).
:- not inner(box(s,neg(box(s,neg(p)))), box(s,neg(p))).
:- not outer(box(s,p), box(s,neg(p))).

% inner world(s)
:- not stan(s, box(s,neg(p)), box(s,neg(p))).
:- not stan(u, box(s,neg(p)), box(s,neg(p))).
:- not stan(s, box(u,neg(p)), box(s,neg(p))).
:- not stan(u, box(u,neg(p)), box(s,neg(p))).
:- not stan(s, box(s,neg(and(p,neg(p)))), box(s,neg(p))).
:- not stan(u, box(s,neg(and(p,neg(p)))), box(s,neg(p))).
:- not stan(s, box(s,neg(box(s,neg(p)))), box(s,neg(p))).
:- not stan(u, box(s,neg(box(s,neg(p)))), box(s,neg(p))).
% outer world
:- not stan(s, box(s,p), box(s,neg(p))).
:- not nstan(u, box(s,p), box(s,neg(p))).

holds(F, W) :- strue(F, W, box(s,neg(p))).

holdsouter(F) :- holds(F, box(s,p)).
holdsinner(F) :- holds(F, box(s,neg(p))).

:- not holds(neg(p), box(s, neg(p))).
:- not holds(neg(p), box(u, neg(p))).
:- not holds(neg(p), box(s, neg(and(p,neg(p))))).
:- not holds(neg(p), box(s, neg(box(s,neg(p))))).

:- not holds(p, box(s, p)).

:- not holdsinner(box(s,neg(p))).
:- not holdsinner(neg(box(s,neg(box(s,neg(p)))))).

:- not holdsouter(neg(box(s,neg(p)))).
:- not holdsouter(neg(box(s,neg(box(s,neg(p)))))).
% here comes the problem
:- not holdsouter(box(u,neg(p))).
:- not holdsouter(neg(box(u,neg(p)))).

:- ok(nstanall, box(s,neg(p))).
:- ok(nstanall, box(u,neg(p))).
:- ok(nstanall, box(s,neg(box(s,neg(p))))).
:- ok(nstanall, box(s,neg(and(p,neg(p))))).

boxinner(S, F) :- boxinner(S, F, box(s,neg(p))).
boxouter(S, F) :- boxouter(S, F, box(s,neg(p))).

#show ok/2.
%#show holds/2.
#show holdsinner/1. #show holdsouter/1.
#show boxinner/2. #show boxouter/2.

% %#show first/1.  #show next/2.  #show last/1.
