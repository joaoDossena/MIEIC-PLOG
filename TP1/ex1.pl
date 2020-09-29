% Family tree

male(aldoBurrows).
male(lincolnBurrows).
male(michaelScofield).
male(ljBurrows).

female(christinaRoseScofield).
female(lisaRix).
female(saraTancredi).
female(ellaScofield).

parent(aldoBurrows, lincolnBurrows).
parent(christinaRoseScofield, lincolnBurrows).
parent(aldoBurrows, michaelScofield).
parent(christinaRoseScofield, michaelScofield).
parent(lisaRix, ljBurrows).
parent(lincolnBurrows, ljBurrows).
parent(michaelScofield, ellaScofield).
parent(saraTancredi, ellaScofield).

% 1a) parent(X, michaelScofield).
% 1b) parent(aldoBurrows, X).
