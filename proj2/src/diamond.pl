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
	length(DiamondIndexList, NumberOfDiamonds),
	length(SolutionBoard, NumberOfRows),
	build_cols(SolutionBoard, NumberOfColumns),

	% Restrictions


	% Labeling


	% Timer ends
	statistics(walltime, [End,_]),
	Time is End - Start,
    format('Duration: ~3d s~n', [Time]).

	