:- consult('utils.pl').

:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(between)).

createDiamonds([], _, []).

createDiamonds([Index|T], Vars, [Diamond| T1]):-
	nth1(Index, Vars, Diamond),
	createDiamonds(T, Vars, T1).


getRest(_, [], _, []).

getRest(DiamondIndexList, [H|T], Count, Rest):-
	member(Count, DiamondIndexList),
	NewCount is Count + 1,
	getRest(DiamondIndexList, T, NewCount, Rest).

getRest(DiamondIndexList, [H|T], Count, [H|Rest]):-
	\+member(Count, DiamondIndexList),
	NewCount is Count + 1,
	getRest(DiamondIndexList, T, NewCount, Rest).


count([], _, 0).

count([H|T], P, Number):-
	dif(H, P),
	count(T, P, Number).

count([H|T], H, NewNumber):-
	count(T, H, Number),
	NewNumber is Number + 1.





% DiamondIndexList is a list with the index number of each diamond on the original problem board

% Examples to copy & paste:
% solve([1, 4, 7, 18, 33, 42, 43, 47, 49], 7, 7, SolutionBoard).

% Main function that solves puzzle
% solve(+DiamondIndexList, +NumberOfRows, +NumberOfColumns, -SolutionBoard)
solve(DiamondIndexList, NumberOfRows, NumberOfColumns, Vars) :-
	% Draws Problem Board
	draw(1, NumberOfColumns, NumberOfRows, DiamondIndexList),

	% Timer starts
	statistics(walltime, [Start,_]),

	% Decision Variables
	length(DiamondIndexList, NumberOfDiamonds), % Gets number of diamonds in problem
	length(SolutionBoard, NumberOfRows),        % Sets numbers of rows to solution
	build_cols(SolutionBoard, NumberOfColumns), % Sets numbers of columns to solution
	append(SolutionBoard, Vars),                % Flattens solution
	domain(Vars, 1, NumberOfDiamonds),          % Sets domain of each cell in solution
	createDiamonds(DiamondIndexList, Vars, DiamondList),
	getRest(DiamondIndexList, Vars, 1, Rest),

	%Criar variaveis que representem os numeros

	% Restrictions
	all_distinct(DiamondList),

	/*V1,V1,T

	nth1(1+ColunmNumber, Vars, V1)*/

	% all_squares(Vars),

	% O número de vezes que uma variavel aparece tem de ser um quadrado perfeito

	% Se aparecer mais que 1 vez então tem de estar todos juntos



	% Labeling
	labeling([], Vars),
	findall(Count, (between(1, NumberOfDiamonds, N), count(Vars, N, Count)), CountList),
	write(Rest), nl,
	write(CountList), nl,
	write(Vars), nl,

	% Timer ends
	statistics(walltime, [End,_]),
	Time is End - Start,
    format('Duration: ~3d s~n', [Time]),

	
	% Draws Problem Board
	draw_solve(NumberOfColumns, Vars, NumberOfColumns).

	