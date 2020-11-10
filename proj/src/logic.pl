
/*
blackPlayerTurn(Board, NewBoard, 'Person') :-
  write('\n------------------ PLAYER (BLACK)  -------------------\n\n'),
      

blackPlayerTurn(Board, NewBoard, 'Computer') :-
  write('\n----------------- COMPUTER (BLACK) ------------------\n\n'),
  

whitePlayerTurn(NewBoard, FinalBoard, 'Person') :-
  write('\n------------------ PLAYER 1 (WHITE) -------------------\n\n'),
      

whitePlayerTurn(Board, FinalBoard, 'Computer') :-
  write('\n----------------- COMPUTER (WHITE) ------------------\n\n'),
      
*/

/*
%Loop do jogo, em que recebe a jogada de cada jogador e verifica o estado do jogo a seguir.
gameLoop(Board, Player1, Player2) :-
  whitePlayerTurn(Board, NewBoard, Player1),
  (
    (checkForWinner(white, NewBoard), write('\nThanks for playing!\n'));
    (blackPlayerTurn(NewBoard, FinalBoard, Player2),
      (
        (checkForWinner(black, FinalBoard), write('\nThanks for playing!\n'));
        (gameLoop(FinalBoard, Player1, Player2))
      )
   )
  ).
*/

checkForWinner(white, [_Board, 0, _BlackCubesLeft]).
checkForWinner(black, [_Board, _WhiteCubesLeft, 0]).

  


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
