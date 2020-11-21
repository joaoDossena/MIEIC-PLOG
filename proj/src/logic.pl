
whitePlayerTurn([OldBoard, OldWhites, OldBlacks], _NewState, 'Person') :-
  nl,nl,nl,write('\n------------------ PLAYER 1 (WHITE) -------------------\n\n'),
  display_game([OldBoard, OldWhites, OldBlacks], white),
  nl,write('What stack do you want to move?'),nl,
  getCoords(Row, Column),
  checkStack(OldBoard, white, Row, Column),
  nl,write('Where to?'),nl,
  getCoords(NewRow, NewColumn),
  valid_moves([OldBoard, OldWhites, OldBlacks], white, ListOfValidMoves),
  member([Row/Column, NewRow/NewColumn], ListOfValidMoves).


blackPlayerTurn([OldBoard, OldWhites, OldBlacks], _NewState, 'Person') :-
  nl,nl,nl,write('\n------------------ PLAYER 2 (BLACK)  -------------------\n\n'),
  display_game([OldBoard, OldWhites, OldBlacks], black),
  write('What stack do you want to move?'),nl,
  getCoords(Row, Column),
  checkStack(OldBoard, black, Row, Column),
  nl,write('Where to?'),nl,
  getCoords(NewRow, NewColumn),
  valid_moves([OldBoard, OldWhites, OldBlacks], white, ListOfValidMoves),
  member([Row/Column, NewRow/NewColumn], ListOfValidMoves).

      
/*
whitePlayerTurn(Board, NewBoard, 'Computer') :-
  write('\n----------------- COMPUTER (WHITE) ------------------\n\n').  
blackPlayerTurn(Board, NewBoard, 'Computer') :-
  write('\n----------------- COMPUTER (BLACK) ------------------\n\n').
*/

% Gets all valid moves possible, given a state and a player
% valid_moves(+GameState, +Player, -ListOfMoves)
valid_moves(GameState, Player, ListOfMoves) :-
  between(1, 5, Row), between(1, 5, Column), between(1, 5, NewRow), between(1, 5, NewColumn),
  bagof([Row/Column, NewRow/NewColumn], validMove(GameState, Player, Row/Column, NewRow/NewColumn), ListOfMoves).

validMove([Board, _WhiteCubesLeft, _BlackCubesLeft], Player, Row/Column, NewRow/NewColumn) :-
  Row >= 1, Row =< 5, NewRow >= 1, NewRow =< 5, Column >= 1, Column =< 5, NewColumn >= 1, NewColumn =< 5,
  checkStack(Board, Player, Row, Column, Stack),
  Dist is abs(NewRow - Row),
  Dist > 0,
  NewColumn == Column,
  length(Stack, Length),
  Dist =< Length.

validMove([Board, _WhiteCubesLeft, _BlackCubesLeft], Player, Row/Column, NewRow/NewColumn) :-
  Row >= 1, Row =< 5, NewRow >= 1, NewRow =< 5, Column >= 1, Column =< 5, NewColumn >= 1, NewColumn =< 5,
  checkStack(Board, Player, Row, Column, Stack),
  NewRow == Row,
  Dist is abs(NewColumn - Column),
  Dist > 0,
  length(Stack, Length),
  Dist =< Length.

getCoords(RowIndex, ColumnIndex) :-
  inputRow(RowIndex),
  inputColumn(ColumnIndex).

%Loop do jogo, em que recebe a jogada de cada jogador e verifica o estado do jogo a seguir.
gameLoop(OldState, Player1, Player2) :-
  whitePlayerTurn(OldState, NewState, Player1),
  (
    (checkForWinner(NewState, white), write('\nThanks for playing!\n'));
    (blackPlayerTurn(NewState, YetANewerState, Player2),
      (
        (checkForWinner(YetANewerState, black), write('\nThanks for playing!\n'));
        (gameLoop(YetANewerState, Player1, Player2))
      )
   )
  ).

getStackFromBoard(Board, RowIndex, ColumnIndex, Stack) :-
  A is RowIndex,
  B is ColumnIndex,
  nth1(A, Board, Row),
  nth1(B, Row, Stack).

% Checks if the stack is in control of the player, returns the stack
checkStack(Board, white, RowIndex, ColumnIndex, Stack) :-
  getStackFromBoard(Board, RowIndex, ColumnIndex, Stack),
  whiteStack(Stack).
checkStack(Board, black, RowIndex, ColumnIndex, Stack) :-
  getStackFromBoard(Board, RowIndex, ColumnIndex, Stack),
  blackStack(Stack).

% Checks if the stack is in control of the player, doesn't return the stack
checkStack(Board, white, RowIndex, ColumnIndex) :-
  getStackFromBoard(Board, RowIndex, ColumnIndex, Stack),
  whiteStack(Stack).
checkStack(Board, black, RowIndex, ColumnIndex) :-
  getStackFromBoard(Board, RowIndex, ColumnIndex, Stack),
  blackStack(Stack).


whiteStack([TopOfStack|_RestOfStack]) :-
  TopOfStack == white.

blackStack([TopOfStack|_RestOfStack]) :-
  TopOfStack == black.

notWhiteStack([]).
notWhiteStack([TopOfStack|_RestOfStack]) :- 
  TopOfStack == black.

noWhiteStacksOnRow([]).
noWhiteStacksOnRow([H|T]) :-
  notWhiteStack(H),
  noWhiteStacksOnRow(T).

noWhiteStacksOnBoard([]).
noWhiteStacksOnBoard([Row|Rest]) :- 
  noWhiteStacksOnRow(Row),
  noWhiteStacksOnBoard(Rest).
  

notBlackStack([]).
notBlackStack([TopOfStack|_RestOfStack]) :- 
  TopOfStack == white.

noBlackStacksOnRow([]).
noBlackStacksOnRow([H|T]) :-
  notBlackStack(H),
  noBlackStacksOnRow(T).

noBlackStacksOnBoard([]).
noBlackStacksOnBoard([Row|Rest]) :-
  noBlackStacksOnRow(Row),
  noBlackStacksOnBoard(Rest).


checkForWinner([_Board, 0, _BlackCubesLeft], white).
checkForWinner([Board, _WhiteCubesLeft, _BlackCubesLeft], white) :-
  noBlackStacksOnBoard(Board).

checkForWinner([_Board, _WhiteCubesLeft, 0], black).
checkForWinner([Board, _WhiteCubesLeft, _BlackCubesLeft], black) :-
  noWhiteStacksOnBoard(Board).
  


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
