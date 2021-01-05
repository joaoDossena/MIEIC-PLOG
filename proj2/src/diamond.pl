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



% count_numbers_in_row(List, NRow, NCol, OldElem, Total, Total):-
% 	nth1(NRow, List, Row),
% 	element(NCol, Row, Elem),
% 	Elem #\= OldElem.

count_numbers_in_row(_List, TotalColumns, _NRow, NewNCol, _Elem, 0, _NotFinished):-
	NewNCol > TotalColumns.
count_numbers_in_row(List, TotalColumns, NRow, NCol, OldElem, Count, NotFinished):-
	NCol =< TotalColumns,
	nth1(NRow, List, Row),
	nth1(NCol, Row, Elem),
	Count #= CountNext + NotFinished,
	NotFinishedNext #<=> NotFinished #/\ (Elem #= OldElem),
	NewNCol is NCol + 1,
	count_numbers_in_row(List, TotalColumns, NRow, NewNCol, Elem, CountNext, NotFinishedNext).



count_equal_rows(_List, TotalRows, _TotalColumns, NRow, _NCol, _Elem, 0, _Sum, _NotFinished):-
	NRow > TotalRows.
count_equal_rows(List, TotalRows, TotalColumns, NRow, NCol, Elem, Count, Sum, NotFinished):-
	NRow =< TotalRows,
	count_numbers_in_row(List, TotalColumns, NRow, NCol, Elem, RowCount, 1),

	Count #= (CountNext + NotFinished),
	NotFinishedNext #<=> (NotFinished #/\ (RowCount #= Sum)),

	NewNRow is NRow + 1,
	count_equal_rows(List, TotalRows, TotalColumns, NewNRow, NCol, Elem, CountNext, Sum, NotFinishedNext).




check_square(List, Index, NRows, NColumns, IsSquare):-
	TCol is Index mod NColumns,
	%% NRow is Index // NRows + 1,
	( (Index mod NColumns > 0, NRow is Index // NColumns + 1); (NRow is Index // NColumns) ),

	( (TCol > 0, NCol = TCol); (NCol = NColumns) ),

	write('(Ix/Row/Col): '), write('('),write(Index),write('/'),write(NRow),write('/'),write(NCol),write(')'),nl,

	nth1(NRow, List, Row),
	element(NCol, Row, Elem),
	%% trace,
	count_numbers_in_row(List, NColumns, NRow, NCol, Elem, Sum, 1),
	%% write('Caling new function'),
	count_equal_rows(List, NRows, NColumns, NRow, NCol, Elem, Count, Sum, 1),
	%% write('Ended function'),
	%% notrace,

	(Count #= Sum) #<=> IsSquare.





iterateBoard(_FlatList, _List, _NRows, _NColumns, FinalIndex, FinalIndex, UpperLeftCount, UpperLeftCount).
iterateBoard(FlatList, List, NRows, NColumns, 1, FinalIndex, UpperLeftCount, TotalCount):- %First row, first col
	write('Index: '), write(Index), nl, 
	check_upper_left_corner(FlatList, NRows, NColumns, Index, IsUpperLeftCorner),
	write('Succeeded'),nl,
	UpperLeftCountNext #= UpperLeftCount + IsUpperLeftCorner,
	NewIndex is Index + 1,
	iterateBoard(FlatList, List, NRows, NColumns, NewIndex, FinalIndex, UpperLeftCountNext, TotalCount).
iterateBoard(FlatList, List, NRows, NColumns, Index, FinalIndex, UpperLeftCount, TotalCount):-
	Index > 1, Index < NColumns, % First row, middle
	Index < FinalIndex,
	write('Index: '), write(Index), nl,
	check_upper_left_corner(FlatList, NRows, NColumns, Index, IsUpperLeftCorner),
	write('Succeeded'),nl,

	element(Index, FlatList, Elem),

	IndexLeft is Index - 1,
	IndexBelow is Index + NColumns,	
	IndexRight is Index + 1,

	element(IndexRight, FlatList, ElemRight),
	element(IndexLeft, FlatList, ElemLeft),
	element(IndexBelow, FlatList, ElemBelow),

	#\IsUpperLeftCorner #=> ((Elem #= ElemBelow) #/\ (Elem #= ElemLeft #\/ Elem #= ElemRight)),
	UpperLeftCountNext #= UpperLeftCount + IsUpperLeftCorner,
	%% check_square(List, Index, NRows, NColumns, IsSquare),

	iterateBoard(FlatList, List, NRows, NColumns, IndexRight, FinalIndex, UpperLeftCountNext, TotalCount).
iterateBoard(FlatList, List, NRows, NColumns, Index, FinalIndex, UpperLeftCount, TotalCount):-
	Index == NColumns, % First row, last
	write('Index: '), write(Index), nl,
	check_upper_left_corner(FlatList, NRows, NColumns, Index, IsUpperLeftCorner),
	write('Succeeded'),nl,

	element(Index, FlatList, Elem),

	IndexLeft is Index - 1,
	IndexBelow is Index + NColumns,	

	element(IndexLeft, FlatList, ElemLeft),
	element(IndexBelow, FlatList, ElemBelow),

	#\IsUpperLeftCorner #=> (Elem #= ElemBelow) #/\ (Elem #= ElemLeft),
	UpperLeftCountNext #= UpperLeftCount + IsUpperLeftCorner,
	NewIndex is Index + 1,
	iterateBoard(FlatList, List, NRows, NColumns, NewIndex, FinalIndex, UpperLeftCountNext, TotalCount).
iterateBoard(FlatList, List, NRows, NColumns, Index, FinalIndex, UpperLeftCount, TotalCount):-
	FirstOfLastCol is FinalIndex - NColumns,
	Index == FirstOfLastCol, %% Last Row, first col
	write('Index: '), write(Index), nl,
	check_upper_left_corner(FlatList, NRows, NColumns, Index, IsUpperLeftCorner),
	write('Succeeded'),nl,

	IndexRight is Index + 1,
	IndexAbove is Index - NColumns,

	element(IndexRight, FlatList, ElemRight),
	element(IndexAbove, FlatList, ElemAbove),
	element(Index, FlatList, Elem),
	#\IsUpperLeftCorner #=> (Elem #= ElemAbove #/\ Elem #= ElemRight),
	UpperLeftCountNext #= UpperLeftCount + IsUpperLeftCorner,
	iterateBoard(FlatList, List, NRows, NColumns, IndexRight, FinalIndex, UpperLeftCountNext, TotalCount).

iterateBoard(FlatList, List, NRows, NColumns, Index, FinalIndex, UpperLeftCount, TotalCount):-
	MaxIndex is FinalIndex -1,
	Index < MaxIndex,
	MinIndex is (NColumns * NRows) - NColumns + 1, % Last row, middle
	Index > MinIndex, 


	write('Index: '), write(Index), nl,
	check_upper_left_corner(FlatList, NRows, NColumns, Index, IsUpperLeftCorner),
	write('Succeeded'),nl,

	IndexLeft is Index - 1,
	IndexRight is Index + 1,
	IndexAbove is Index - NColumns,

	element(IndexRight, FlatList, ElemRight),

	element(IndexLeft, FlatList, ElemLeft),
	element(IndexAbove, FlatList, ElemAbove),
	element(Index, FlatList, Elem),

	#\IsUpperLeftCorner #=> (Elem #= ElemAbove #/\ (Elem #= ElemLeft #\/ Elem #= ElemRight) ),
	UpperLeftCountNext #= UpperLeftCount + IsUpperLeftCorner,
	iterateBoard(FlatList, List, NRows, NColumns, IndexRight, FinalIndex, UpperLeftCountNext, TotalCount).
iterateBoard(FlatList, List, NRows, NColumns, Index, FinalIndex, UpperLeftCount, TotalCount):-
	CheckLastIndex is FinalIndex - 1,
	Index == CheckLastIndex, %% Last Row, LastColumn
	write('Index: '), write(Index), nl,
	check_upper_left_corner(FlatList, NRows, NColumns, Index, IsUpperLeftCorner),
	write('Succeeded'),nl,

	IndexLeft is Index - 1,
	IndexAbove is Index - NColumns,

	element(IndexLeft, FlatList, ElemLeft),
	element(IndexAbove, FlatList, ElemAbove),
	element(Index, FlatList, Elem),
	#\IsUpperLeftCorner #=> (Elem #= ElemAbove #/\ Elem #= ElemLeft),
	UpperLeftCountNext #= UpperLeftCount + IsUpperLeftCorner,
	NewIndex is Index + 1,
	iterateBoard(FlatList, List, NRows, NColumns, NewIndex, FinalIndex, UpperLeftCountNext, TotalCount).
iterateBoard(FlatList, List, NRows, NColumns, Index, FinalIndex, UpperLeftCount, TotalCount):-
	Index < FinalIndex, Index > 1,
	FirstCol is Index mod NColumns, % middle row, first column
	FirstCol == 1,

	write('Index: '), write(Index), nl,
	check_upper_left_corner(FlatList, NRows, NColumns, Index, IsUpperLeftCorner),
	write('Succeeded'),nl,

	IndexRight is Index + 1,
	IndexBelow is Index + NColumns,
	IndexAbove is Index - NColumns,

	element(IndexRight, FlatList, ElemRight),
	element(IndexAbove, FlatList, ElemAbove),
	element(IndexBelow, FlatList, ElemBelow),
	element(Index, FlatList, Elem),
	#\IsUpperLeftCorner #=> (Elem #= ElemRight #/\ (Elem #= ElemBelow #\/ Elem #= ElemAbove)),
	UpperLeftCountNext #= UpperLeftCount + IsUpperLeftCorner,
	iterateBoard(FlatList, List, NRows, NColumns, IndexRight, FinalIndex, UpperLeftCountNext, TotalCount).
iterateBoard(FlatList, List, NRows, NColumns, Index, FinalIndex, UpperLeftCount, TotalCount):-
	CheckLastIndex is FinalIndex - 1,
	Index < CheckLastIndex, 
	LastColumn is Index mod NColumns,  %% middle row, last column
	LastColumn == 0,

	write('Index: '), write(Index), nl,
	check_upper_left_corner(FlatList, NRows, NColumns, Index, IsUpperLeftCorner),
	write('Succeeded'),nl,

	IndexLeft is Index - 1,
	IndexBelow is Index + NColumns,
	IndexAbove is Index - NColumns,

	element(IndexLeft, FlatList, ElemLeft),
	element(IndexAbove, FlatList, ElemAbove),
	element(IndexBelow, FlatList, ElemBelow),
	element(Index, FlatList, Elem),
	#\IsUpperLeftCorner #=> (Elem #= ElemLeft #/\ (Elem #= ElemBelow #\/ Elem #= ElemAbove)),
	UpperLeftCountNext #= UpperLeftCount + IsUpperLeftCorner,
	NewIndex is Index + 1,

	iterateBoard(FlatList, List, NRows, NColumns, NewIndex, FinalIndex, UpperLeftCountNext, TotalCount).

iterateBoard(FlatList, List, NRows, NColumns, Index, FinalIndex, UpperLeftCount, TotalCount):-
	Index > NColumns,
	FirstOfLastCol is FinalIndex - NColumns, 
	Index < FirstOfLastCol,
	Col is Index mod NColumns,  %% middle row, middle column
	Col > 1,

	write('Index: '), write(Index), nl,
	check_upper_left_corner(FlatList, NRows, NColumns, Index, IsUpperLeftCorner),
	write('Succeeded'),nl,

	IndexLeft is Index - 1,
	IndexRight is Index + 1,
	IndexBelow is Index + NColumns,
	IndexAbove is Index - NColumns,
	element(IndexLeft, FlatList, ElemLeft),
	element(IndexRight, FlatList, ElemRight),
	element(IndexAbove, FlatList, ElemAbove),
	element(IndexBelow, FlatList, ElemBelow),
	element(Index, FlatList, Elem),
	#\IsUpperLeftCorner #=> (Elem #= ElemLeft #\/ Elem #= ElemRight) #/\ (Elem #= ElemAbove #\/ Elem #= ElemBelow),
	UpperLeftCountNext #= UpperLeftCount + IsUpperLeftCorner,
	iterateBoard(FlatList, List, NRows, NColumns, IndexRight, FinalIndex, UpperLeftCountNext, TotalCount).

check_appearance(_List, 1, _Element, Res, Res).
check_appearance(List, Index, Element, NeverAppeared, Res):-
	In is Index - 1,
	element(In, List, PreviousElem),
	NeverAppearedNext #<=> NeverAppeared #/\ (PreviousElem #\= Element),
	check_appearance(List, In, Element, NeverAppearedNext, Res).


%% SE NÃO ME ENGANO FAZ SENTIDO O PRIMEIRO ELEMENTO SEMPRE SER UM UPPER LEFT CORNER
% In case the element is the first element, then it logically is an Upper Left Corner
check_upper_left_corner(_List, _NRows, _NColumns, 1, IsUpperLeftCorner) :-
	write('Index, 1st row, 1st col: '),nl,
	IsUpperLeftCorner #= 1. %true

% In case the element is on the first row but not in first column
check_upper_left_corner(List, _NRows, _NColumns, Index, IsUpperLeftCorner) :- %true
	% Verifies Row is 1
	Index > 1,
	element(Index, List, CurrElement),
	check_appearance(List, Index, CurrElement, 1, NeverAppeared),
	NeverAppeared #<=> IsUpperLeftCorner. % If they have different values, then the current element is an Upper Left Corner

%% % In case the element is on the first row but not in first column
%% check_upper_left_corner(List, _NRows, NColumns, Index, IsUpperLeftCorner) :- %true
%% 	% Verifies Row is 1
%% 	Index > 1, Index =< NColumns,
%% 	Column is Index mod NColumns,
%% 	Column \= 1, 
%% 	write('1st row, ~1st col'),nl,
%% 	element(Index, List, CurrElement),
%% 	%% LeftIndex is Index - 1,
%% 	%% element(LeftIndex, List, LeftElement),
%% 	%% RightIndex is Index + 1,
%% 	%% element(RightIndex, List, RightElem),
%% 	%% BottomIndex is Index + NColumns,
%% 	%% element(BottomIndex, List, BottomElem),
%% 	check_appearance(List, Index, CurrElement, 1, NeverAppeared),
%% 	%% (CurrElement #\= LeftElement) #/\

%% 	NeverAppeared #=> IsUpperLeftCorner. % If they have different values, then the current element is an Upper Left Corner

%% % In case the element is not on the first row but is in the first column
%% check_upper_left_corner(List, _NRows, NColumns, Index, IsUpperLeftCorner) :- %true
%% 	Index > NColumns,
%% 	%% Row is (Index // NColumns) + 1,
%% 	%% Row \= 1,
%% 	Column is Index mod NColumns,
%% 	Column == 1, % Or (Index mod NRows) == 1
%% 	%% write('~1st row, 1st col: '), write(Index),nl,
%% 	write('~1st row, 1st col'),nl,


%% 	element(Index, List, CurrElement),
%% 	%% TopIndex is Index - NColumns,
%% 	%% element(TopIndex, List, TopElement),
	
%% 	check_appearance(List, Index, CurrElement, 1, NeverAppeared),
%% 	%% ((CurrElement #\= TopElement) #/\ 
%% 	NeverAppeared #=> IsUpperLeftCorner. % If they have different values, then the current element is an Upper Left Corner

%% % In case the element is neither on the first row nor is it in the first column
%% check_upper_left_corner(List, _NRows, NColumns, Index, IsUpperLeftCorner) :- %true
%% 	Index > NColumns,
%% 	length(List, N),
%% 	Index =< N - NColumns,

%% 	%% Row is (Index // NColumns) + 1,
%% 	%% write('Row: '), write(Row),
%% 	%% Row \= 1,
%% 	Column is Index mod NColumns,
%% 	Column \= 1, % Or (Index mod NRows) == 1
%% 	%% write('Column: '), write(Column),nl,

%% 	%% write('~1st row, ~1st col: '), write(Index),nl,
%% 	write('~1st row, ~1st col'),nl,

%% 	element(Index, List, CurrElement),
%% 	%% TopIndex is Index - NColumns,
%% 	%% element(TopIndex, List, TopElement),
%% 	%% LeftIndex is Index - 1,
%% 	%% element(LeftIndex, List, LeftElement),
%% 	%% RightIndex is Index + 1,
%% 	%% element(RightIndex, List, RightElem),
%% 	%% BottomIndex is Index + NColumns,
%% 	%% element(BottomIndex, List, BottomElem),
	
%% 	check_appearance(List, Index, CurrElement, 1, NeverAppeared),
%% 	%% (((CurrElement #\= TopElement) #/\ (CurrElement #\= LeftElement)) #/\ 
%% 	%% ( #/\ 
%% 	NeverAppeared  #=> IsUpperLeftCorner. % If it is different from both the top and the left, then the current element is an Upper Left Corner


%% % In case the element is in the last Row
%% check_upper_left_corner(List, _NRows, NColumns, Index, IsUpperLeftCorner) :- %true
%% 	length(List, N),
%% 	Index > N - NColumns,
%% 	Index \= N,

%% 	%% Row is (Index // NColumns) + 1,
%% 	%% write('Row: '), write(Row),
%% 	%% Row \= 1,
%% 	Column is Index mod NColumns,
%% 	Column \= 1, % Or (Index mod NRows) == 1
%% 	%% write('Column: '), write(Column),nl,

%% 	%% write('~1st row, ~1st col: '), write(Index),nl,
%% 	write('Last row, ~1st col'),nl,

%% 	element(Index, List, CurrElement),
%% 	%% TopIndex is Index - NColumns,
%% 	%% element(TopIndex, List, TopElement),
%% 	%% LeftIndex is Index - 1,
%% 	%% element(LeftIndex, List, LeftElement),
%% 	%% RightIndex is Index + 1,
%% 	%% element(RightIndex, List, RightElem),
	
%% 	check_appearance(List, Index, CurrElement, 1, NeverAppeared),
%% 	%% ((CurrElement #\= TopElement) #/\ (CurrElement #\= LeftElement) #/\ 
%% 	(NeverAppeared ) #=> IsUpperLeftCorner . % If it is different from both the top and the left, then the current element is an Upper Left Corner

%% % In case the element is in the last Row and Last column
%% check_upper_left_corner(List, _NRows, NColumns, Index, IsUpperLeftCorner) :- %true
%% 	length(List, N),
%% 	Index == N,

%% 	Column is Index mod NColumns,
%% 	Column \= 1, % Or (Index mod NRows) == 1
%% 	write('Last row, Last col'),nl,

%% 	element(Index, List, CurrElement),
%% 	%% TopIndex is Index - NColumns,
%% 	%% element(TopIndex, List, TopElement),
%% 	%% LeftIndex is Index - 1,
%% 	%% element(LeftIndex, List, LeftElement),
	
%% 	check_appearance(List, Index, CurrElement, 1, NeverAppeared),
%% 	%% ((CurrElement #\= TopElement) #/\ (CurrElement #\= LeftElement)) 
%% 	NeverAppeared #=> IsUpperLeftCorner. % If it is different from both the top and the left, then the current element is an Upper Left Corner

setDiamondOrder([]).
setDiamondOrder([_]).
setDiamondOrder([H, H1|T]):-
	H1 #> H,
	setDiamondOrder([H1|T]).

% DiamondIndexList is a list with the index number of each diamond on the original problem board

% Examples to copy & paste:
% solve([1, 4, 7, 18, 33, 42, 43, 47, 49], 7, 7, S).
% solve([1, 3], 2, 4, S).
% solve([1, 18], 3, 6, S).


% Main function that solves puzzle
% solve(+DiamondIndexList, +NumberOfRows, +NumberOfColumns, -SolutionBoard).
solve(DiamondIndexList, NumberOfRows, NumberOfColumns, Vars) :-
	% Draws Problem Board
	draw(1, NumberOfColumns, NumberOfRows, DiamondIndexList),

	% Timer starts
	%% statistics(walltime, [Start,_]),

	% Decision Variables
	length(DiamondIndexList, NumberOfDiamonds), % Gets number of diamonds in problem
	length(SolutionBoard, NumberOfRows),        % Sets numbers of rows to solution
	build_cols(SolutionBoard, NumberOfColumns), % Sets numbers of columns to solution
	append(SolutionBoard, Vars),                % Flattens solution
	domain(Vars, 1, NumberOfDiamonds),          % Sets domain of each cell in solution

	createDiamonds(DiamondIndexList, Vars, DiamondList),
	%% getRest(DiamondIndexList, Vars, 1, Rest),

	%Criar variaveis que representem os numeros

	% Restrictions
	all_distinct(DiamondList),
	setDiamondOrder(DiamondList),
	% trace,
	%% write('Before checking cells'), nl,
	FinalIndex is NumberOfRows * NumberOfColumns + 1,
	% check_cell(Vars, NumberOfRows, NumberOfColumns, 1, FinalIndex),
	% trace,
	iterateBoard(Vars, SolutionBoard, NumberOfRows, NumberOfColumns, 1, FinalIndex, 0, ULCount),

	NumberOfDiamonds = ULCount,
	% notrace,
	%% write('After checking cells'), nl,
	/*V1,V1,T

	nth1(1+ColunmNumber, Vars, V1)*/

	% all_squares(Vars),

	% O número de vezes que uma variavel aparece tem de ser um quadrado perfeito

	% Se aparecer mais que 1 vez então tem de estar todos juntos



	% Labeling
	labeling([], Vars),
	% notrace,
	%% findall(Count, (between(1, NumberOfDiamonds, N), count(Vars, N, Count)), CountList),
	write('Number of UpperLeft: '), write(ULCount), nl,
	%% write(CountList), nl,
	%% write(Vars), nl,

	% Timer ends
	%% statistics(walltime, [End,_]),
	%% Time is End - Start,
	%% format('Duration: ~3d s~n', [Time]),

	
	% % Draws Problem Board
	draw_solve(NumberOfColumns, Vars, NumberOfColumns).
