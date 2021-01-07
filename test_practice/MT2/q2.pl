%% Question 2:
%% Asdrúbal wants to implement an equivalent version to the previous program using 
%% constraint logic programming (CLP).

:- use_module(library(clpfd)).

p2(L1,L2) :-
    length(L1,N),
    length(L2,N),
    %
    pos(L1,L2,Is),
    all_distinct(Is),
    %
    labeling([],Is),
    test(L2).

pos([],_,[]).
pos([X|Xs],L2,[I|Is]) :-
    nth1(I,L2,X),
    pos(Xs,L2,Is).

%% However, after studying more, he found out that his program was not a correct implementation
%% in CLP. Choose the option that best translates this affirmation:

%% Answers:
%% [ ] a - Not every restriction was put before the search phase
%% [ ] b - It is not possible to label Is, because these variables have no defined domain
%% [ ] c - The domain variables are instantiated before the search phase
%% [ ] d - The domain variables are instantiated before the search phase, and not every restriction was put before the search phase
%% [X] e - It is not possible to label Is, because these variables have no defined domain, and not every restriction was put before the search phase


