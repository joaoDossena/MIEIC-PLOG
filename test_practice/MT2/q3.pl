%% Question 3:
%% Correct the program, so that you obtain a correct implementation in CLP.

%% Answer:
:- use_module(library(clpfd)).

p2(L1,L2) :-
    length(L1,N),
    length(L2,N),
	length(Is, N),
	domain(Is, 1, N),
    %
	all_distinct(Is),
    pos(L1,L2,Is),
    test(L2),

    %
    labeling([],Is).

test([_,_]).
test([X1,X2,X3|Xs]) :-
    (X1 #< X2, X2 #< X3; X1 #> X2, X2 #> X3),
    test([X2,X3|Xs]).

pos([],_,[]).
pos([X|Xs],L2,[I|Is]) :-
    element(I,L2,X),
    pos(Xs,L2,Is).