%% Question 4:
%% Para os seus cozinhados natalícios, o Bonifácio dispunha de um determinado número de ovos,
%% com prazo de validade próximo. Este era o único recurso limitado, dispondo ele de quantidades intermináveis
%% de todos os outros ingredientes. Na sua lista de receitas de doces, cada receita inclui, entre outras coisas,
%% o tempo de preparação e o número de ovos que leva. O Bonifácio tem um tempo limitado para cozinhar, 
%% pretende fazer 3 pratos diferentes de doce e gastar o maior número possível de ovos de que dispõe.
%% Usando programação em lógica com restrições, construa um programa que determine que receitas é que o Bonifácio
%% deve fazer. O predicado sweet_recipes(+MaxTime,+NEggs,+RecipeTimes,+RecipeEggs,-Cookings,-Eggs) 
%% recebe o máximo de tempo disponível (MaxTime), o número de ovos disponíveis (NEggs), 
%% os tempos (RecipeTimes) e ovos (RecipeEggs) gastos por cada receita; 
%% devolve em Cookings os cozinhados a realizar (índices das listas RecipeTimes/RecipeEggs) 
%% e em Eggs os ovos utilizados.

%% Answer:
:- use_module(library(clpfd)).
sweet_recipes(MaxTime, NEggs, RecipeTimes, RecipeEggs, Cookings, Eggs) :-
	%% Variables
	length(Cookings, 3),

	%% Domain
	length(RecipeTimes, N),
	domain(Cookings, 1, N),

	%% Constraints
	all_distinct(Cookings),
	sum_by_index(Cookings, RecipeTimes, TotalTime),
	sum_by_index(Cookings, RecipeEggs, Eggs),
	TotalTime #=< MaxTime,
	Eggs #=< NEggs, 
	order(Cookings), % Removes symmetries (redundant responses)

	%% Labeling
	labeling([maximize(Eggs)], Cookings).


sum_by_index([], _, 0).
sum_by_index([Ix|Indexes], ListToSum, Sum) :-
	sum_by_index(Indexes, ListToSum, AccSum),
	element(Ix, ListToSum, NewValue),
	Sum #= AccSum + NewValue.

order([]).
order([_]).
order([F, S|Rest]) :-
	F #< S,
	order([S|Rest]).

%% Test examples:
%% | ?- sweet_recipes(60,30,[20,50,10,20,15],[6,4,12,20,6],Cookings,Eggs).
%% Cookings = [1,3,5],
%% Eggs = 24
%% no

%% | ?- sweet_recipes(120,30,[20,50,10,20,15],[6,4,12,20,6],Cookings,Eggs).
%% Cookings = [1,2,4],
%% Eggs = 30
%% no