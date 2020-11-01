
% Initial configuration of board
% initialBoard(+Board)
initialBoard([
	[[empty], [empty], [empty], [empty], [black, black, black, black, black, black]],
	[[empty], [empty], [empty], [empty], [empty]],
	[[empty], [empty], [empty], [empty], [empty]],
	[[empty], [empty], [empty], [empty], [empty]],
	[[white, white, white, white, white, white], [empty], [empty], [empty], [empty]]
	]).

% Initial configuration of cubes out of the board
% initialWhiteCubes(+List)
initialWhiteCubes([whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube]).
% initialBlackCubes(+List)
initialBlackCubes([blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube]).


% Example of intermediate configuration of board
% midBoard(+Board)
midBoard([
    [[black, black],        [empty], [blackCube],    [empty],               [black, black, black, black]],
    [[empty],               [empty], [empty],        [white, white, white], [empty]],
    [[empty],               [empty], [empty],        [empty],               [empty]],
    [[empty],               [empty], [empty],        [empty],               [empty]],
    [[white, white, white], [empty], [empty],        [whiteCube],           [empty]]
    ]).

% Example of intermediate configuration of cubes out of the board
% midWhiteCubes(+List)
midWhiteCubes([whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube]).
% midBlackCubes(+List)
midBlackCubes([blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube]).

% Example of final configuration of board
% finalBoard(+Board)
finalBoard([
    [[blackCube], [white, black, white, black], [blackCube],    [whiteCube],           [white, black, black, black, black]],
    [[whiteCube], [whiteCube],                  [empty],        [white, white],        [white, black]],
    [[empty],     [empty],                      [empty],        [empty],               [empty]],
    [[empty],     [empty],                      [empty],        [empty],               [empty]],
    [[whiteCube], [empty],                      [empty],        [whiteCube],           [empty]]
    ]).

% Example of final configuration of cubes out of the board
% finalWhiteCubes(+List)
finalWhiteCubes([whiteCube, whiteCube, whiteCube, whiteCube]).
% finalBlackCubes(+List)
finalBlackCubes([blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube]).

% Symbols and what they represent
% symbol(+Alias, +Character)
symbol(empty, '.').
symbol(black, 'B').
symbol(blackCube, 'C').
symbol(white, 'W').
symbol(whiteCube, 'K').

% Row letters
% letter(+Number, +Character)
letter(1, 'A').
letter(2, 'B').
letter(3, 'C').
letter(4, 'D').
letter(5, 'E').

% Displays a certain game state
% display_game(+GameState, +Player)
display_game([Board, WhiteCubeList, BlackCubeList], Player) :-
    write('Turn: '), write(Player),
    printBoard(Board),
    printCubes(WhiteCubeList, BlackCubeList).


% Prints game board Board
% printBoard(+Board)
printBoard(Board) :-
    nl,
    write('   | 1 | 2 | 3 | 4 | 5 | \n'),
    write('---|---|---|---|---|---|\n'),
    printMatrix(Board, 1).


% Prints matrix
% printMatrix(+Matrix, +NLine)
printMatrix([], 6).
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
% printLine(+Line)
printLine([]).
printLine([Stack|RestOfLine]) :-
    printTop(Stack),
    write(' | '),
    printLine(RestOfLine).

% Prints top of the stack
% printTop(+Stack)
printTop([]).
printTop([TopOfStack|_RestOfStack]) :-
    symbol(TopOfStack, S),
    write(S).

% Prints lists of non-used cubes
% printCubes(+WhiteCubeList, +BlackCubeList)
printCubes(WhiteCubeList, BlackCubeList) :-
    write('White cubes left: '),
    printList(WhiteCubeList),nl,
    write('Black cubes left: '),
    printList(BlackCubeList),nl.


% Prints a list of symbols
% printList(+List)
printList([]).
printList([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    printList(Tail).

