:- consult('utils.pl').

:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(random)).


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
noMore([], _Elem, _ElemIx, _CurrIx).

noMore([_H|T], ElemNotToRepeat, ElemIndex, ElemIndex) :-
	%% write('same element'),nl,
	%% H #= ElemNotToRepeat,
	NewCurrentIndex is ElemIndex + 1,
	noMore(T, ElemNotToRepeat, ElemIndex, NewCurrentIndex).

noMore([H|T], ElemNotToRepeat, ElemIndex, CurrIndex) :-
	%% write('different element'),nl,
	H #\= ElemNotToRepeat,
	%% write('after comparison different'),nl,
	NewCurrentIndex is CurrIndex + 1,
	noMore(T, ElemNotToRepeat, ElemIndex, NewCurrentIndex).


%% check_number_of_equals([], _ULIndex, _CurrentIndex, Total, Total).
%% check_number_of_equals([_H], _ULIndex, _CurrentIndex, Total, Total).
%% check_number_of_equals([_H, NH|T], ULIndex, CurrentIndex, Number, Total):-
%% 	CurrentIndex < ULIndex,
%% 	NewCurrentIndex is CurrentIndex + 1,
%% 	check_number_of_equals([NH|T], ULIndex, NewCurrentIndex, Number, Total). 
%% check_number_of_equals([H, NH|_T], ULIndex, CurrentIndex, Total, Total):-
%% 	CurrentIndex >= ULIndex,
%% 	H #\= NH.
%% check_number_of_equals([H, NH|T], ULIndex, CurrentIndex, Number, Total):-
%% 	CurrentIndex >= ULIndex,
%% 	H #= NH,
%% 	NewNumber is Number + 1,
%% 	NewCurrentIndex is CurrentIndex + 1,
%% 	check_number_of_equals([NH|T], ULIndex, NewCurrentIndex, NewNumber, Total). 


%% check_columns(_List, _NColumns, _Index, _Element, Count, Number, 0):- %false
%% 	Count > Number.
%% check_columns(List, _NColumns, Index, Element, Number, Number, 1):- %true
%% 	element(Index, List, TestElement),
%% 	TestElement #\= Element.
%% check_columns(List, NColumns, Index, Element, Count, Number, IsSquare):-
%% 	element(Index, List, TestElement),
%% 	TestElement #= Element,
%% 	NewCount is Count + 1,
%% 	NewIndex is Index + NColumns,
%% 	Number < NColumns,
%% 	check_columns(List, NColumns, NewIndex, Element, NewCount, Number, IsSquare).
%% check_columns(List, NColumns, Index, Element, _Count, Number, 0):- %false
%% 	element(Index, List, TestElement),
%% 	TestElement #= Element,
%% 	%% NewCount is Count + 1,
%% 	%% NewIndex is Index + NColumns,
%% 	Number >= NColumns.


%% check_square(_List, NRows, NColumns, Index, _IsSquare):-
%% 	Index =:= (NRows * NColumns).
%% check_square(List, _NRows, NColumns, Index, IsSquare):-
%% 	check_number_of_equals(List, Index, 1, 0, Number),
%% 	write('Number: '),
%% 	write(Number), nl,
%% 	element(Index, List, ElementToCheck),
%% 	check_columns(List, NColumns, Index, ElementToCheck, 0, Number, IsSquare).






























check_cell(_List, _NRows, _NColumns, FinalIndex, FinalIndex). 
	%% Index > (NRows * NColumns).

check_cell(List, NRows, NColumns, Index, FinalIndex) :-
%% 	%% Index =< (NRows * NColumns),
	domain([IsUpperLeftCorner], 0, 1),
	Index mod NColumns \= 0,
	Index // NRows < (NRows - 1),
	check_upper_left_corner(List, NRows, NColumns, Index, IsUpperLeftCorner),
	%% IsUpperLeftCorner =:= 1,
	element(Index, List, Elem),
	RightIndex is Index + 1,
	element(RightIndex, List, RightElem),
	BottomIndex is Index + NColumns,
	element(BottomIndex, List, BottomElem),
	Elem #= RightElem,
	Elem #= BottomElem,
%% 	write('Index: '),
%% 	write(Index), nl,
%% 	% write('IsUpperLeftCorner: '),
%% 	% write(IsUpperLeftCorner), nl,
%% 	% check_square %%TODO
%% 	% check_square(List, NRows, NColumns, Index, IsSquare),
%% 	% write('IsSquare: '),
%% 	% write(IsSquare), nl,
%% 	% IsUL #=> IsSquare
%% 	% IsUpperLeftCorner #=> IsSquare,
	NextIndex is Index + 1,
	check_cell(List, NRows, NColumns, NextIndex, FinalIndex).


check_cell(List, NRows, NColumns, Index, FinalIndex) :- %% Not upperleft
%% 	%% Index < (NRows * NColumns),
	domain([IsUpperLeftCorner], 0, 1),
	check_upper_left_corner(List, NRows, NColumns, Index, IsUpperLeftCorner),
	%% IsUpperLeftCorner =:= 0,
	write('Index: '),
	write(Index), nl,
	NextIndex is Index + 1,
	check_cell(List, NRows, NColumns, NextIndex, FinalIndex).

check_cell(List, NRows, NColumns, Index, FinalIndex) :- %%  UperLeft and 1x1 square
	domain([IsUpperLeftCorner], 0, 1),
	check_upper_left_corner(List, NRows, NColumns, Index, IsUpperLeftCorner),
	%% IsUpperLeftCorner =:= 1,
	write('Index of 1x1 square: '),
	write(Index), nl,
	element(Index, List, Elem),
	%% write('before noMore: '),nl,
	noMore(List, Elem, Index, 1),
	%% write('after noMore: '),nl,
	NextIndex is Index + 1,
	check_cell(List, NRows, NColumns, NextIndex, FinalIndex).























%% SE NÃO ME ENGANO FAZ SENTIDO O PRIMEIRO ELEMENTO SEMPRE SER UM UPPER LEFT CORNER
% In case the element is the first element, then it logically is an Upper Left Corner
check_upper_left_corner(_List, _NRows, _NColumns, 1, IsUpperLeftCorner) :-
	IsUpperLeftCorner #= 1. %true

% In case the element is on the first row but not in first column
check_upper_left_corner(List, _NRows, NColumns, Index, IsUpperLeftCorner) :- %true
	Row is Index // NColumns,
	Row == 1, % Or (Index // NColumns) == 1
	element(Index, List, CurrElement),
	LeftIndex is Index - 1,
	element(LeftIndex, List, LeftElement),
	CurrElement #\= LeftElement,
	IsUpperLeftCorner #= 1. % If they have different values, then the current element is an Upper Left Corner
% In case the element is not on the first row but is in the first column
check_upper_left_corner(List, NRows, NColumns, Index, IsUpperLeftCorner) :- %true
	Column is Index mod NRows,
	Column == 1, % Or (Index mod NRows) == 1
	element(Index, List, CurrElement),
	TopIndex is Index - NColumns,
	element(TopIndex, List, TopElement),
	CurrElement #\= TopElement,
	IsUpperLeftCorner #= 1. % If they have different values, then the current element is an Upper Left Corner

% In case the element is neither on the first row nor is it in the first column
check_upper_left_corner(List, _NRows, NColumns, Index, IsUpperLeftCorner) :- %true
	element(Index, List, CurrElement),
	TopIndex is Index - NColumns,
	element(TopIndex, List, TopElement),
	CurrElement #\= TopElement,
	LeftIndex is Index - 1,
	element(LeftIndex, List, LeftElement),
	CurrElement #\= LeftElement,
	IsUpperLeftCorner #= 1. % If it is different from both the top and the left, then the current element is an Upper Left Corner

%% SE NÃO ME ENGANO, ANALISEI TODOS OS CASOS VERDADEIROS
% In the other cases it is false
check_upper_left_corner(_List, _NRows, _NColumns, _Index, IsUpperLeftCorner) :-
	IsUpperLeftCorner #= 0. %false

% DiamondIndexList is a list with the index number of each diamond on the original problem board

% Examples to copy & paste:
% solve2([1, 4, 7, 18, 33, 42, 43, 47, 49], 7, 7, SolutionBoard).

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
	% trace,
	%% write('Before checking cells'), nl,
	FinalIndex is NumberOfRows * NumberOfColumns + 1,
	check_cell(Vars, NumberOfRows, NumberOfColumns, 1, FinalIndex),
	%% write('After checking cells'), nl,
	/*V1,V1,T

	nth1(1+ColunmNumber, Vars, V1)*/

	% all_squares(Vars),

	% O número de vezes que uma variavel aparece tem de ser um quadrado perfeito

	% Se aparecer mais que 1 vez então tem de estar todos juntos



	% Labeling
	labeling([], Vars),
	% notrace,
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
