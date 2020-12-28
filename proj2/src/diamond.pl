:- consult('utils.pl').

:- use_module(library(clpfd)).
:- use_module(library(lists)).

createDiamonds([], _, []).

createDiamonds([Index|T], Vars, [Diamond| T1]):-
	nth1(Index, Vars, Diamond),
	createDiamonds(T, Vars, T1).

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


	% Restrictions
	all_distinct(DiamondList),

	getEquals(Vars, Equals),

	length(Equals, N*N),

	%TODO fazer com que todos os numeros que aparecem sejam quadrados perfeitos e no caso de serem existir pelo menos dois numeros iguais adjacentes (caso o lenght seja > 1)





	% Labeling
	labeling([], Vars),

	% Timer ends
	statistics(walltime, [End,_]),
	Time is End - Start,
    format('Duration: ~3d s~n', [Time]),

	
	% Draws Problem Board
	draw_solve(NumberOfColumns, Vars, NumberOfColumns).

	