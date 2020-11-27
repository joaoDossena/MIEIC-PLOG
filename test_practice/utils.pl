%% membro(Elem, Lista).
membro(X, [X|_]).
membro(X, [_|T]) :-
	membro(X, T).

%% concatena(Lista1, Lista2, ListaFinal).
concatena([], L, L).
concatena([H|T], L2, [H|T1]) :-
	concatena(T, L2, T1).

%% inverter(Lista, ListaFinal).
inverter(L1, L2):-
	inverter_aux(L1,L2,[]).
inverter_aux([], L, L).
inverter_aux([H|T], L2, Acc) :-
	inverter(T, L2, [H|Acc]).

inverte([X], [X]).
inverte([X|T], L):-
	inverte(T, L1),
	concatena(L1, [X], L).

%% ordena(Lista, ListaFinal).
ordena(List, Sorted):-
	ordena_aux(List, [], Sorted).
ordena_aux([], L, L).
ordena_aux([X|T], Acc, Sorted) :-
	insere(X, Acc, NewAcc),
	ordena_aux(T, NewAcc, Sorted).


insere(X, [], [X]).
insere(X, [Y|T], [X,Y|T]) :-
	X =< Y.
insere(X, [Y|T], [Y|NT]) :-
	X > Y,
	insere(X, T, NT).