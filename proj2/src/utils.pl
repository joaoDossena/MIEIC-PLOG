

build_cols([],_).
build_cols([Line|Ls],N):-
	length(Line,N),
	build_cols(Ls,N).

draw(Y,_NumberColumns, NumberRows,_):-
	Y > NumberRows.
draw(Y,NumberColumns, NumberRows,Vars):-
	Y =< NumberRows,
	draw_line(Y,1,NumberColumns,Vars),nl,
	Y1 is Y + 1,
	draw(Y1,NumberColumns, NumberRows, Vars).
	
draw_line(_,X,N,_):-
	X > N.
draw_line(Y,X,N,Vars):-
	X =< N,
	K is (Y - 1)*N + X,
	draw_cell(K,Vars),write(' '),
	X1 is X + 1,
	draw_line(Y,X1,N,Vars).
	
draw_cell(K,Vars):-
	member(K,Vars),!,
	write('*').
draw_cell(_,_):-
	write('.').

draw_solve(_, [], _).

draw_solve(Ncolumn, [Elem|T], Current):-
	Current =< 1,
	write(Elem), nl,
	draw_solve(Ncolumn, T, Ncolumn).

draw_solve(Ncolumn, [Elem|T], Current):-
	Current > 1,
	write(Elem), write(' '),
	NewCurrent is Current - 1,
	draw_solve(Ncolumn, T, NewCurrent).





nth11(Y,X,LL,Elem):-
	nth1(Y,LL,L),
	nth1(X,L,Elem).


%% % Counts number of 1's in a binary list with 0's and 1's (aka counts diamonds on the board)
%% % count_diamonds(+List, -NumberOfDiamondsInList).
%% count_diamonds([], 0).
%% count_diamonds([1|Tail], OneMoreDiamond) :-
%% 	count_diamonds(Tail, N),
%% 	OneMoreDiamond is N + 1.
%% count_diamonds([0|Tail], NumberOfDiamonds) :-
%% 	count_diamonds(Tail, NumberOfDiamonds).

puzzle :-
	generate_random_puzzle(5, 10,10, [L, NRows, NCols]),
	draw(1, NCols, NRows, L).


generate_random_puzzle(NumDiamonds, MaxRows, MaxCols, [L, NRows, NCols]) :-
	random(2, MaxRows, NRows),
	random(2, MaxCols, NCols),
	MaxIndex is NRows * NCols,
	generate_random_diamonds(0, NumDiamonds, MaxIndex, [], L).



generate_random_diamonds(NumDiamonds, NumDiamonds, _MaxIndex, Acc, Acc).
generate_random_diamonds(Index, NumDiamonds, MaxIndex, Acc, List) :-
	random(1, MaxIndex, NewDiamond),
	append([NewDiamond], Acc, NewAcc),
	NewIndex is Index + 1,
	generate_random_diamonds(NewIndex, NumDiamonds, MaxIndex, NewAcc, List).