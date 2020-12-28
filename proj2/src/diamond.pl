:- use_module(library(clpfd)).


% Main function that solves puzzle
solve() :-
	% Timer starts
	statistics(walltime, [Start,_]),

	% Decision Variables
	Solution = [Diamond, BoxStart, BoxEnd],
	Diamond = [X, Y],


	List = [X, Y, BoxStart, BoxEnd],
	domain(List, 1, Size),
	% Restrictions
	

	% Labeling


	% Timer ends
	statistics(walltime, [End,_]),
	Time is End - Start,
    format('Duration: ~3d s~n', [Time]).

	