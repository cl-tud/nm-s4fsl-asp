% The knowledge base is as follows:
% □*[a]
% □*[c]
% □*[(a ∧ (b ∨ c)): ¬y / p]


% Encoding:
% □*[a]
form(box(all,a)).
% □*[c]
form(box(all,c)).

% □*[(a ∧ (b ∨ c)): ¬y / p]
% (a ∧ -(-b ∧ -c))
% and(a,and(neg(and(neg(b,neg(c))))))
form(neg(
        and(
            and(
                % box(all,a),  % <- can uncomment this and comment the next line to check 
                box(all,and(a,neg(and(neg(b),neg(c))))),  % prerequisite
                box(all,neg(box(all,y))) % justification 
            ),   
            neg(box(all,p)) % conclusion
        )
    )
).

% needed 
succ(a,b).
succ(b,c).
succ(c,p).
succ(p,y).

% NOTE: this is a quite regular looking knowledge base, but somehow the formula in the prerequisite breaks it. If the prerequisite was □*[a] it would work with no problem (please see above.) 
% Somehow to trigger this behaviour, prerequisite must be more complicated, though it is also satisfied in this KB (entailed by □*[a] and □*[c])

% Explanation
% This instance when executed has 2 answer sets, namely:
% Answer: 1
% known(box(all,a)) known(box(all,c)) known(box(all,and(a,neg(and(neg(b),neg(c)))))) known(box(all,y))
% Answer: 2
% known(box(all,a)) known(box(all,c)) known(box(all,p)) known(box(all,and(a,neg(and(neg(b),neg(c)))))) known(box(all,neg(box(all,y))))

% These differ in that in (1) we have:
% □*[y]
% whereas in (2) we instead have:
% □*[p] 

% I claim that only (2) is actually a minimal model. To this end lets investigate (2) first. 

% For ease of analysis we will decode the default:
% □*[(a ∧ (b ∨ c)): ¬y / p]
% to 
% □*[a ∧ (b ∨ c)] ∧ □*[¬□*y] → □*p

% We will show the inner worlds evaluations first, and then consider the remaining evaluations to see that they cannot be added as outer world without breaking modelhood whence proving (2) is indeed minimal. 

% INNER EVALUATIONS
% a   c p           
% a b c p 
% a   c p y
% a b c p y

% each of these evaluations satisfies respectively the following subformulas:
%   ⊨ □*[a ∧ (b ∨ c)]; 
%   ⊭ □*y; 
%   ⊨ ¬□*y; 
%   ⊨ □*[¬□*y]; 
%   ⊨ □*p; 
%   ⊨ □*[a ∧ (b ∨ c)] ∧ □*[¬□*y] → □*p ✓✓✓✓✓✓✓✓✓✓
% so we have a model. 
% Now consider the remaining evaluations, if they were added as outer worlds:
% a   c 
%   ⊨ □*[a ∧ (b ∨ c)]; 
%   ⊭ □*y; 
%   ⊨ ¬□*y; 
%   ⊨ □*[¬□*y]; 
%   ⊭ □*p; 
%   ⊭ □*[a ∧ (b ∨ c)] ∧ □*[¬□*y] → □*p ✗✗✗✗✗✗✗✗✗✗
% the same would happen with all remaining evaluations, as they can only differ by not containing p.
% Hence (2) is indeed minimal. 

% Now let's turn to (1) and consider the model with following inner worlds:

% INNER EVALUATIONS
% a   c   y          
% a b c   y
% a   c p y
% a b c p y
% each of these evaluations satisfies respectively the following:
%   ⊨ □*[a ∧ (b ∨ c)]; 
%   ⊨ □*y; 
%   ⊭ ¬□*y; 
%   ⊭ □*[¬□*y]; 
%   ⊭ □*p; 
%   ⊨ □*[a ∧ (b ∨ c)] ∧ □*[¬□*y] → □*p ✓✓✓✓✓✓✓✓✓✓

% Now consider the remaining evaluations, if they were added as outer worlds:
% a   c
%   ⊨ □*[a ∧ (b ∨ c)]; 
%   ⊭ □*y; 
%   ⊨ ¬□*y; 
%   ⊭ □*[¬□*y]; 
%   ⊭ □*p; 
%   ⊨ □*[a ∧ (b ∨ c)] ∧ □*[¬□*y] → □*p ✓✓✓✓✓✓✓✓✓✓
% so it would still be a model if we added this outer world, which means (1) cannot be a minimal model.

