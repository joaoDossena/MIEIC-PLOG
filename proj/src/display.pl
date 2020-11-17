
% Initial configuration of board
% initialBoard(+Board)
initialBoard([
	[[], [], [], [], [black, black, black, black, black, black]],
	[[], [], [], [], []],
	[[], [], [], [], []],
	[[], [], [], [], []],
	[[white, white, white, white, white, white], [], [], [], []]
	]).

% Initial configuration of cubes out of the board
% initialWhiteCubes(+Number)
initialWhiteCubes(9).
% initialBlackCubes(+Number)
initialBlackCubes(9).


% Example of intermediate configuration of board
% midBoard(+Board)
midBoard([
    [[black, black],        [], [blackCube],    [],               [black, black, black, black]],
    [[],               [], [],        [white, white, white], []],
    [[],               [], [],        [],               []],
    [[],               [], [],        [],               []],
    [[white, white, white], [], [],        [whiteCube],           []]
    ]).

% Example of intermediate configuration of cubes out of the board
% midWhiteCubes(+Number)
midWhiteCubes(8).
% midBlackCubes(+Number)
midBlackCubes(8).

% Example of final configuration of board
% finalBoard(+Board)
finalBoard([
    [[blackCube], [white, black, white, black], [blackCube],    [whiteCube],           [white, black, black, black, black]],
    [[whiteCube], [whiteCube],                  [],        [white, white],        [white, black]],
    [[],     [],                      [],        [],               []],
    [[],     [],                      [],        [],               []],
    [[whiteCube], [],                      [],        [whiteCube],           []]
    ]).

% Example of final configuration of cubes out of the board
% finalWhiteCubes(+Number)
finalWhiteCubes(4).
% finalBlackCubes(+Number)
finalBlackCubes(7).

% Symbols and what they represent
% symbol(+Alias, +Character)
symbol([], '.').
symbol(black, 'B').
symbol(blackCube, 'C').
symbol(white, 'W').
symbol(whiteCube, 'K').

% Row letters
% letter(+Number, +Character)
letter(1, 'a').
letter(2, 'b').
letter(3, 'c').
letter(4, 'd').
letter(5, 'e').

% Displays a certain game state
% display_game(+GameState, +Player)
display_game([Board, WhiteCubeLeft, BlackCubeLeft], Player) :-
    write('Turn: '), write(Player),
    printBoard(Board),
    printCubes(WhiteCubeLeft, BlackCubeLeft).


% Prints game board Board
% printBoard(+Board)
printBoard(Board) :-
    nl,
    write('            |      1     |      2     |      3     |      4     |      5     | \n'),
    write('------------|------------|------------|------------|------------|------------|\n'),
    printMatrix(Board, 1).


% Prints matrix
% printMatrix(+Matrix, +NLine)
printMatrix([], 6).
printMatrix([Head|Tail], N) :-
    letter(N, L),
    format('~t~s~t~12||', [L]),
    %% write('    '),
    %% write(L),
    N1 is N + 1,
    %% write('       | '),
    printLine(Head),
    write('\n------------|------------|------------|------------|------------|------------|\n'),
    printMatrix(Tail, N1).

% Prints a line
% printLine(+Line)
printLine([]).
printLine([Stack|RestOfLine]) :-
    convertStackIntoString(Stack, String),
    %% printStack(Stack),
    format('~12+~t~s~t~12+|', [String]),
    printLine(RestOfLine).

% Prints the stack
% printStack(+Stack)
printStack([]).
printStack([TopOfStack|RestOfStack]) :-
    symbol(TopOfStack, S),
    write(S),
    printStack(RestOfStack).

convertStackIntoString(Stack, String):-
    convertStackIntoString(Stack, '', String).
convertStackIntoString([], String, String).
convertStackIntoString([H|T], Acc, String) :-
    symbol(H, S),
    atom_concat(S, Acc, Acc1),
    convertStackIntoString(T, Acc1, String).

% Prints number of non-used cubes
% printCubes(+WhiteCubesLeft, +BlackCubesLeft)
printCubes(WhiteCubesLeft, BlackCubesLeft) :-
    write('White cubes left: '),
    write(WhiteCubesLeft),nl,
    write('Black cubes left: '),
    write(BlackCubesLeft),nl.


% Prints a list of symbols
% printList(+List)
printList([]).
printList([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    printList(Tail).

