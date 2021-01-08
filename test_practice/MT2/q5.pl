%% Question 5:
%% O Eleutério trabalha numa loja que corta prateleiras de madeira à medida. 
%% Para efeitos deste exercício, consideramos apenas cortes numa dimensão 
%% (isto é, assumimos que todas as prateleiras têm sempre a mesma largura). 
%% A páginas tantas, o Eleutério dispõe de várias pranchas, cada qual com um determinado comprimento,
%% e precisa de cortar um conjunto de prateleiras, cada qual com a sua dimensão. 
%% Construa um programa, usando programação em lógica com restrições, 
%% que determine em que prancha é que cada prateleira deve ser cortada. 
%% O predicado cut(+Shelves,+Boards,-SelectedBoards) recebe a lista de prateleiras a cortar 
%% Shelves com a dimensão (unidimensional) de cada uma, e a lista Boards com o comprimento de cada prancha;
%% devolve em SelectedBoards as pranchas a utilizar para cada prateleira.

%% Answer:
:- use_module(library(clpfd)).

cut(Shelves, Boards, SelectedBoards) :-
	%% Variables
	length(Shelves, N),
	length(SelectedBoards, N),

	%% Domain
	length(Boards, M),
	domain(SelectedBoards, 1, M),

	%% Constraints
	getTasks(Shelves, SelectedBoards, Tasks),
	getMachines(Boards, Machines, 1),
	cumulatives(Tasks, Machines, [bound(upper)]),

	%% Labeling
	labeling([], SelectedBoards).

getTasks([], [], []).
getTasks([Shelf|S], [SelectedBoard|B], [Task|T]) :-
	Task = task(0, Shelf, Shelf, Shelf, SelectedBoard),
	getTasks(S, B, T).

getMachines([], [], _).
getMachines([Board|B], [Machine|M], ID) :-
	Machine = machine(ID, Board),
	NewID is ID + 1,
	getMachines(B, M, NewID).

%% Test examples:
%% | ?- cut([12,50,14,8,10,90,24], [100,45,70], S).
%% S = [2,3,3,2,1,1,2] ? ;
%% S = [3,3,2,3,1,1,2] ? ;
%% no