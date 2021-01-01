:- consult('utils.pl').

:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(between)).

createDiamonds([], _, []).

createDiamonds([Index|T], Vars, [Diamond| T1]):-
	nth1(Index, Vars, Diamond),
	createDiamonds(T, Vars, T1).


getRest(_, [], _, []).

getRest(DiamondIndexList, [_H|T], Count, Rest):-
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

%% "Template" do professor:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% check_cell(Row-Col):-
%%        check_upper_left_corner(Row-Col,IsUL),
%%        check_square(Row-Col,IsSquare),
%%        IsUL #=> IsSquare.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

check_cell(_List, NRows, NColumns, Index) :-
	Index is (NRows * NColumns) + 1.

check_cell(List, NRows, NColumns, Index) :-
	check_upper_left_corner(List, NRows, NColumns, Index, _IsUpperLeftCorner), %%REMOVE '_' from _IsUpperLeftCorner when we have to use this function
	% check_square %%TODO
	% IsUL #=> IsSquare
	NextIndex is Index + 1,
	check_cell(List, NRows, NColumns, NextIndex).


%% SE NÃO ME ENGANO FAZ SENTIDO O PRIMEIRO ELEMENTO SEMPRE SER UM UPPER LEFT CORNER
% In case the element is the first element, then it logically is an Upper Left Corner
check_upper_left_corner(_List, _NRows, _NColumns, 1, true).

% In case the element is on the first row but not in first column
check_upper_left_corner(List, _NRows, NColumns, Index, true) :-
	Row is Index // NColumns,
	Row == 1, % Or (Index // NColumns) == 1
	element(Index, List, CurrElement),
	LeftIndex is Index - 1,
	element(LeftIndex, List, LeftElement),
	CurrElement #\= LeftElement. % If they have different values, then the current element is an Upper Left Corner
% In case the element is not on the first row but is in the first column
check_upper_left_corner(List, NRows, NColumns, Index, true) :-
	Column is Index mod NRows,
	Column == 1, % Or (Index mod NRows) == 1
	element(Index, List, CurrElement),
	TopIndex is Index - NColumns,
	element(TopIndex, List, TopElement),
	CurrElement #\= TopElement. % If they have different values, then the current element is an Upper Left Corner

% In case the element is neither on the first row nor is it in the first column
check_upper_left_corner(List, _NRows, NColumns, Index, true) :-
	element(Index, List, CurrElement),
	TopIndex is Index - NColumns,
	element(TopIndex, List, TopElement),
	CurrElement #\= TopElement,
	LeftIndex is Index - 1,
	element(LeftIndex, List, LeftElement),
	CurrElement #\= LeftElement. % If it is different from both the top and the left, then the current element is an Upper Left Corner

%% SE NÃO ME ENGANO, ANALISEI TODOS OS CASOS VERDADEIROS
% In the other cases it is false
check_upper_left_corner(_List, _NRows, _NColumns, _Index, false).

% DiamondIndexList is a list with the index number of each diamond on the original problem board

% Examples to copy & paste:
% solve([1, 4, 7, 18, 33, 42, 43, 47, 49], 7, 7, SolutionBoard).

% Main function that solves puzzle
% solve(+DiamondIndexList, +NumberOfRows, +NumberOfColumns, -SolutionBoard).
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
	%% check_cell(Vars, NumberOfRows, NumberOfColumns, 1),
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

	