initialBoard([
	[empty, empty, empty, empty, white],
	[empty, empty, empty, empty, empty],
	[empty, empty, empty, empty, empty],
	[empty, empty, empty, empty, empty],
	[black, empty, empty, empty, empty]
	]).



symbol(empty, '.').
symbol(black, 'B').
symbol(blackCube, 'C').
symbol(white, 'W').
symbol(whiteCube, 'K').

letter(1, 'A').
letter(2, 'B').
letter(3, 'C').
letter(4, 'D').
letter(5, 'E').


printBoard(X) :-
    nl,
    write('   | 1 | 2 | 3 | 4 | 5 | \n'),
    write('---|---|---|---|---|---|\n'),
    printMatrix(X, 1).

printMatrix([], 6). %Talvez mudemos pra 5

printMatrix([Head|Tail], N) :-
    letter(N, L),
    write(' '),
    write(L),
    N1 is N + 1,
    write(' | '),
    printLine(Head),
    write('\n---|---|---|---|---|---|---|\n'),
    printMatrix(Tail, N1).

printLine([]).

printLine([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    write(' | '),
    printLine(Tail).