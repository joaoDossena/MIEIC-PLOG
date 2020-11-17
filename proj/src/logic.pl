
whitePlayerTurn(OldState, NewState, 'Person') :-
  nl,nl,nl,write('\n------------------ PLAYER 1 (WHITE) -------------------\n\n'),
  display_game(OldState, white),
  nl,write('What stack do you want to move?'),nl,
  getCurrentCoords(OldState, white).

blackPlayerTurn(OldState, NewState, 'Person') :-
  nl,nl,nl,write('\n------------------ PLAYER 2 (BLACK)  -------------------\n\n'),
  display_game(OldState, black),
  write('What stack do you want to move?'),nl,
  getCurrentCoords(OldState, black).
      

/*
whitePlayerTurn(Board, NewBoard, 'Computer') :-
  write('\n----------------- COMPUTER (WHITE) ------------------\n\n').  
blackPlayerTurn(Board, NewBoard, 'Computer') :-
  write('\n----------------- COMPUTER (BLACK) ------------------\n\n').
*/

getCurrentCoords(GameState, Player) :-
      inputRow(NewRow),
      inputColumn(NewColumn),
      %% nl,
      ColumnIndex is NewColumn - 1,
      RowIndex is NewRow - 1,
      checkStack(GameState, Player, RowIndex, ColumnIndex).

  
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

searchInRow(Stack, 0, Content) :-
  Content = Stack.

searchInRow([Column|RestOfColumns], ColumnIndex, Content) :-
  NewColumnIndex is ColumnIndex - 1,
  searchInRow(RestOfColumns, NewColumnIndex, Content).

searchInMatrix([Row|RestOfRows], 0, ColumnIndex, Content) :-
  searchInRow(Row, ColumnIndex, Content).

searchInMatrix([Row|RestOfRows], RowIndex, ColumnIndex, Content) :-
  NewRowIndex is RowIndex - 1,
  searchInMatrix(RestOfRows, NewRowIndex, ColumnIndex, Content).

checkStack([Board, _WhiteCubesLeft, _BlackCubesLeft], white, RowIndex, ColumnIndex) :-
  searchInMatrix(Board, RowIndex, ColumnIndex, Stack),
  whiteStack(Stack).
checkStack([Board, _WhiteCubesLeft, _BlackCubesLeft], black, RowIndex, ColumnIndex) :-
  searchInMatrix(Board, RowIndex, ColumnIndex, Stack),
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
