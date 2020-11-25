
whitePlayerTurn([OldBoard, OldWhites, OldBlacks], NewState, 'Person') :-
  nl,nl,nl,write('\n------------------ PLAYER 1 (WHITE) -------------------\n\n'),
  display_game([OldBoard, OldWhites, OldBlacks], white),
  write('What stack do you want to move?'),nl,
  getCoords(Row, Column),
  checkStack(OldBoard, white, Row/Column),
  write('Where to?'),nl,
  getCoords(NewRow, NewColumn),
  valid_moves([OldBoard, OldWhites, OldBlacks], white, ListOfValidMoves),
  member([Row/Column, NewRow/NewColumn], ListOfValidMoves),
  move([OldBoard, OldWhites, OldBlacks], [white, Row/Column, NewRow/NewColumn], NewState).

blackPlayerTurn([OldBoard, OldWhites, OldBlacks], NewState, 'Person') :-
  nl,nl,nl,write('\n------------------ PLAYER 2 (BLACK)  -------------------\n\n'),
  display_game([OldBoard, OldWhites, OldBlacks], black),
  write('What stack do you want to move?'),nl,
  getCoords(Row, Column),
  checkStack(OldBoard, black, Row/Column),
  write('Where to?'),nl,
  getCoords(NewRow, NewColumn),
  valid_moves([OldBoard, OldWhites, OldBlacks], black, ListOfValidMoves),
  member([Row/Column, NewRow/NewColumn], ListOfValidMoves),
  %% write('Before move, so far so good'),nl,
  move([OldBoard, OldWhites, OldBlacks], [black, Row/Column, NewRow/NewColumn], NewState).

      


/*
whitePlayerTurn(Board, NewBoard, 'Computer') :-
  write('\n----------------- COMPUTER (WHITE) ------------------\n\n').  
blackPlayerTurn(Board, NewBoard, 'Computer') :-
  write('\n----------------- COMPUTER (BLACK) ------------------\n\n').
*/

% move(+GameState, +Move, -NewGameState)
move([Board, OldWhites, OldBlacks], [Player, FromRow/FromColumn, ToRow/ToColumn], [NewestBoard, NewestWhites, NewestBlacks]) :-
  % Gets distance, which is the number of pieces to split from stack
  getDist([FromRow/FromColumn, ToRow/ToColumn], Dist),
  % Splits stack into leftover (bottom) and Dist # of pieces (top)
  splitStack(Board, FromRow/FromColumn, Dist, TopSubstack, BottomSubstack),
  % Replaces the original stack with the leftover stack
  replaceStack(Board, FromRow/FromColumn, BottomSubstack, NewBoard),
  getStackFromBoard(NewBoard, ToRow/ToColumn, NewStack),
  % Checks if there's a cube on future coords
  checkForCube([NewBoard, OldWhites, OldBlacks], NewStack, YetANewerStack, [YetANewerBoard, NewWhites, NewBlacks]),
  % Moves top stack to the top of ToRow/ToColumn
  append(TopSubstack, YetANewerStack, NewestStack),
  replaceStack(YetANewerBoard, ToRow/ToColumn, NewestStack, YetAnotherNewerBoard),
  % If old coords are empty, leave a cube there
  addCube([YetAnotherNewerBoard, NewWhites, NewBlacks], Player, FromRow/FromColumn, [NewestBoard, NewestWhites, NewestBlacks]).

% initial([Bo, W, B]),addCube([Bo, W, B], black, 1/1, [NBo, NW, NB]), display_game([NBo, NW, NB], white).

addCube([Board, WhiteCubes, BlackCubes], _Player, Row/Column, [Board, WhiteCubes, BlackCubes]) :-
  getStackFromBoard(Board, Row/Column, S),
  S \= [].

addCube([Board, WhiteCubes, _BC], white, Row/Column, [NewBoard, NewWhiteCubes, _BC]) :-
  getStackFromBoard(Board, Row/Column, []),
  replaceStack(Board, Row/Column, [whiteCube], NewBoard),
  NewWhiteCubes is WhiteCubes - 1.
addCube([Board, _WC, BlackCubes], black, Row/Column, [NewBoard, _WC, NewBlackCubes]) :-
  getStackFromBoard(Board, Row/Column, []),
  replaceStack(Board, Row/Column, [blackCube], NewBoard),
  NewBlackCubes is BlackCubes - 1.

checkForCube([Board, OldWhites, OldBlacks], [whiteCube], [], [Board, NewWhites, OldBlacks]) :-
  NewWhites is OldWhites + 1.
checkForCube([Board, OldWhites, OldBlacks], [blackCube], [], [Board, OldWhites, NewBlacks]) :-
  NewBlacks is OldBlacks + 1.
checkForCube([Board, OldWhites, OldBlacks], Stack, Stack, [Board, OldWhites, OldBlacks]).


% replaceElem(NewElem, IndexOfElemToReplace, WhereToReplace).
replaceElem(_, _, [], []).
replaceElem(Elem, 1, [_|T], [Elem|T1]):-
    replaceElem(_, 0, T, T1).
replaceElem(Elem, N, [H|T], [H|T1]):-
    N1 is N - 1,
    replaceElem(Elem, N1, T, T1).

% replaceStack
replaceStack(Board, RowNumber/ColumnNumber, Elem, NewBoard):-
    nth1(RowNumber, Board, Row),
    replaceElem(Elem, ColumnNumber, Row, NewRow),
    replaceElem(NewRow, RowNumber, Board, NewBoard).


splitStack(Board, Row/Column, NumPieces, TopSubstack, BottomSubstack) :-
  getStackFromBoard(Board, Row/Column, Stack),
  getNTopPieces(Stack, NumPieces, TopSubstack),
  removeNTopPieces(Stack, NumPieces, BottomSubstack).

getNTopPieces(Stack, N, Substack):-
  length(Stack, Length), Length >=  N,
  getNTopPiecesAux(Stack, N, Substack, []).

getNTopPiecesAux(_Stack, 0, Substack, Substack).
getNTopPiecesAux([H|T], N, Substack, Acc):-
  N1 is N - 1,
  getNTopPiecesAux(T, N1, Substack, [H|Acc]).

removeNTopPieces(Stack, N, Substack):-
  length(Stack, Length), Length >=  N,
  removeNTopPiecesAux(Stack, N, Substack).

removeNTopPiecesAux(Stack, 0, Stack).
removeNTopPiecesAux([_H|T], N, Substack):-
  N1 is N - 1,
  removeNTopPiecesAux(T, N1, Substack).


getDist([Row/Column, Row/NewColumn], Dist) :-
  Dist is abs(NewColumn - Column),
  Dist > 0.
getDist([Row/Column, NewRow/Column], Dist) :-
  Dist is abs(NewRow - Row),
  Dist > 0.


% Gets all valid moves possible, given a state and a player
% valid_moves(+GameState, +Player, -ListOfMoves)
valid_moves(GameState, Player, ListOfMoves) :-
  findall([Row/Column, NewRow/NewColumn], (between(1, 5, Row), between(1, 5, Column), between(1, 5, NewRow), between(1, 5, NewColumn),validMove(GameState, Player, Row/Column, NewRow/NewColumn)), ListOfMoves).


validMove([Board, _WhiteCubesLeft, _BlackCubesLeft], Player, Row/Column, NewRow/NewColumn) :-
  Row >= 1, Row =< 5, NewRow >= 1, NewRow =< 5, Column >= 1, Column =< 5, NewColumn >= 1, NewColumn =< 5,
  checkStack(Board, Player, Row/Column, Stack),
  getDist([Row/Column, NewRow/NewColumn], Dist),
  length(Stack, Length),
  Dist =< Length.

getCoords(RowIndex, ColumnIndex) :-
  inputRow(RowIndex),
  inputColumn(ColumnIndex).

%Loop do jogo, em que recebe a jogada de cada jogador e verifica o estado do jogo a seguir.
gameLoop(OldState, Player1, Player2) :-
  whitePlayerTurn(OldState, NewState, Player1),
  (
    (checkForWinner(NewState, white), write('\nWHITE PLAYER WINS\nThanks for playing!\n'));
    (blackPlayerTurn(NewState, YetANewerState, Player2),
      (
        (checkForWinner(YetANewerState, black), write('\nBLACK PLAYER WINS\nThanks for playing!\n'));
        (gameLoop(YetANewerState, Player1, Player2))
      )
    )
  ).

getStackFromBoard(Board, RowIndex/ColumnIndex, Stack) :-
  nth1(RowIndex, Board, Row),
  nth1(ColumnIndex, Row, Stack).

% Checks if the stack is in control of the player, returns the stack
% checkStack(+Board, +Player, +RowIndex/+ColumnIndex, -Stack)
checkStack(Board, white, RowIndex/ColumnIndex, Stack) :-
  getStackFromBoard(Board, RowIndex/ColumnIndex, Stack),
  whiteStack(Stack).
checkStack(Board, black, RowIndex/ColumnIndex, Stack) :-
  getStackFromBoard(Board, RowIndex/ColumnIndex, Stack),
  blackStack(Stack).

% Checks if the stack is in control of the player, doesn't return the stack
% checkStack(+Board, +Player, +RowIndex/+ColumnIndex)
checkStack(Board, white, RowIndex/ColumnIndex) :-
  getStackFromBoard(Board, RowIndex/ColumnIndex, Stack),
  whiteStack(Stack).
checkStack(Board, black, RowIndex/ColumnIndex) :-
  getStackFromBoard(Board, RowIndex/ColumnIndex, Stack),
  blackStack(Stack).

% Checks if top of stack is white
% whiteStack(+Stack)
whiteStack([TopOfStack|_RestOfStack]) :-
  TopOfStack == white.

% Checks if top of stack is black
% blackStack(+Stack)
blackStack([TopOfStack|_RestOfStack]) :-
  TopOfStack == black.

% Checks if player won the game
% checkForWinner(+GameState, +Player)
checkForWinner([_Board, 0, _BlackCubesLeft], white).
checkForWinner([Board, _WhiteCubesLeft, _BlackCubesLeft], white) :-
  valid_moves([Board, _WhiteCubesLeft, _BlackCubesLeft], black, []).
checkForWinner([_Board, _WhiteCubesLeft, 0], black).
checkForWinner([Board, _WhiteCubesLeft, _BlackCubesLeft], black) :-
  valid_moves([Board, _WhiteCubesLeft, _BlackCubesLeft], white, []).
  


% Gets initial state of the game
% initial(-GameState)
initial([Board, WhiteCubesLeft, BlackCubesLeft]) :-
  initialBoard(Board),
  initialWhiteCubes(WhiteCubesLeft),
  initialBlackCubes(BlackCubesLeft).

% Gets specific intermediate state of the game
% intermediate(-GameState)
intermediate([Board, WhiteCubesLeft, BlackCubesLeft]) :-
  midBoard(Board),
  midWhiteCubes(WhiteCubesLeft),
  midBlackCubes(BlackCubesLeft).

% Gets specific final state of the game
% final(-GameState)
final([Board, WhiteCubesLeft, BlackCubesLeft]) :-
  finalBoard(Board),
  finalWhiteCubes(WhiteCubesLeft),
  finalBlackCubes(BlackCubesLeft).
