% Initial configuration of board
initialBoard([
	[[empty], [empty], [empty], [empty], [black, black, black, black, black, black]],
	[[empty], [empty], [empty], [empty], [empty]],
	[[empty], [empty], [empty], [empty], [empty]],
	[[empty], [empty], [empty], [empty], [empty]],
	[[white, white, white, white, white, white], [empty], [empty], [empty], [empty]]
	]).

% Initial configuration of cubes out of the board
initialWhiteCubes([whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube]).
initialBlackCubes([blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube]).


% Example of intermediate configuration of board
midBoard([
    [[black, black],        [empty], [blackCube],    [empty],               [black, black, black, black]],
    [[empty],               [empty], [empty],        [white, white, white], [empty]],
    [[empty],               [empty], [empty],        [empty],               [empty]],
    [[empty],               [empty], [empty],        [empty],               [empty]],
    [[white, white, white], [empty], [empty],        [whiteCube],           [empty]]
    ]).

% Example of intermediate configuration of cubes out of the board
midWhiteCubes([whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube]).
midBlackCubes([blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube]).

% Example of final configuration of board
finalBoard([
    [[blackCube], [white, black, white, black], [blackCube],    [whiteCube],           [white, black, black, black, black]],
    [[whiteCube], [whiteCube],                  [empty],        [white, white],        [white, black]],
    [[empty],     [empty],                      [empty],        [empty],               [empty]],
    [[empty],     [empty],                      [empty],        [empty],               [empty]],
    [[whiteCube], [empty],                      [empty],        [whiteCube],           [empty]]
    ]).

% Example of final configuration of cubes out of the board
finalWhiteCubes([whiteCube, whiteCube, whiteCube, whiteCube]).
finalBlackCubes([blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube]).

% Symbols and what they represent
symbol(empty, '.').
symbol(black, 'B').
symbol(blackCube, 'C').
symbol(white, 'W').
symbol(whiteCube, 'K').

% Row letters
letter(1, 'A').
letter(2, 'B').
letter(3, 'C').
letter(4, 'D').
letter(5, 'E').

% Prints game board X
printBoard(X) :-
    nl,
    write('   | 1 | 2 | 3 | 4 | 5 | \n'),
    write('---|---|---|---|---|---|\n'),
    printMatrix(X, 1).


% Prints matrix
printMatrix([], 5).
printMatrix([Head|Tail], N) :-
    letter(N, L),
    write(' '),
    write(L),
    N1 is N + 1,
    write(' | '),
    printLine(Head),
    write('\n---|---|---|---|---|---|\n'),
    printMatrix(Tail, N1).

% Prints a line
printLine([]).
printLine([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    write(' | '),
    printLine(Tail).