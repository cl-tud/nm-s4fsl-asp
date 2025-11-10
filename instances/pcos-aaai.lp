% example: PCOS / FHA - example from AAAI paper

patom(hormone;ovudis;preg;pcos;fha).
pstand(all;d1;d2).

% knowledge base

% Box_all[ovudis]
form(box(all,ovudis)).
% Box_all[preg]
% form(box(all,preg)).            % <-- commment / uncomment to trigger non monotonic behaviour
% Box_all[pcos -> hormone]
form(box(all,neg(and(pcos,neg(hormone))))).
% Box_all[fha -> \neg hormone]
form(box(all,neg(and(fha,hormone)))).

% Box_d1[ovudis: pcos/pcos]
form(neg(
        and(
            and(
                box(d1,ovudis),  % prerequisite
                box(d1,neg(box(d1,neg(pcos)))) % justification 1
            ),   
            neg(box(d1, pcos))
        )
    )
).

% Box_d2[ovudis: ¬preg,fha: fha]
form(neg(
        and(
            and(
                box(d2,ovudis),  % prerequisite
                and(
                    box(d2,neg(box(d2,preg))), % justification 1
                    box(d2,neg(box(d2,neg(fha)))) % justification 1
                )
            ),   
            neg(box(d2, fha))
            )
        )
    ).


% needed 
succ(ovudis,hormone).
succ(hormone,pcos).
succ(pcos,fha).
succ(fha,preg).

% % % % % % % % % % %
% Expected behaviour
% % % % % % % % % % %

% before pregnancy is known

% k(all,ovudis) 
% k(d1,ovudis) 
% k(d1,pcos) 
% k(d1,hormone) 
% k(d1,n(fha)) 

% k(d2,ovudis) 
% k(d2,fha)
% k(d2,n(hormone)) 
% k(d2,n(pcos)) 

% % % % % % % % 

% k(all,ovudis) 
% k(all,preg) 

% k(d1,n(fha)) 
% k(d1,hormone) 
% k(d1,pcos) 
% k(d1,preg) 
% k(d1,ovudis)

% k(d2,ovudis) 
% k(d2,preg)

