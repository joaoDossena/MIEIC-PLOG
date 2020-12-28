:- consult('utils.pl').

:- use_module(library(clpfd)).


% DiamondIndexList is a list with the index number of each diamond on the original problem board

% Examples to copy & paste:
% solve([1, 4, 7, 18, 33, 42, 43, 47, 49], 7, 7, SolutionBoard).

% Main function that solves puzzle
% solve(+DiamondIndexList, +NumberOfRows, +NumberOfColumns, -SolutionBoard)
solve(DiamondIndexList, NumberOfRows, NumberOfColumns, SolutionBoard) :-
	% Draws Problem Board
	draw(1, NumberOfColumns, NumberOfRows, DiamondIndexList),

	% Timer starts
	statistics(walltime, [Start,_]),

	% Decision Variables
<<<<<<< HEAD
	length(DiamondIndexList, NumberOfDiamonds),
	length(SolutionBoard, NumberOfRows),
	build_cols(SolutionBoard, NumberOfColumns),\
=======
	length(DiamondIndexList, NumberOfDiamonds), % Gets number of diamonds in problem
	length(SolutionBoard, NumberOfRows),        % Sets numbers of rows to solution
	build_cols(SolutionBoard, NumberOfColumns), % Sets numbers of columns to solution
	append(SolutionBoard, Vars),                % Flattens solution
	domain(Vars, 1, NumberOfDiamonds),          % Sets domain of each cell in solution
>>>>>>> 522462fa169e77d6c9cb2533505050f472378cb1

	% Restrictions
	

	% Labeling


	% Timer ends
	statistics(walltime, [End,_]),
	Time is End - Start,
    format('Duration: ~3d s~n', [Time]).

	