
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
            (checkGameState('white', NewBoard), write('\nThanks for playing!\n'));
            (blackPlayerTurn(NewBoard, FinalBoard, Player2),
                  (
                        (checkGameState('black', FinalBoard), write('\nThanks for playing!\n'));
                        (gameLoop(FinalBoard, Player1, Player2))
                  )
           )
      ).
*/

% Gets initial state of the game
% initial(-GameState)
initial([Board, WhiteCubeList, BlackCubeList]) :-
    initialBoard(Board),
    initialWhiteCubes(WhiteCubeList),
    initialBlackCubes(BlackCubeList).

% Gets intermediate state of the game
% intermediate(-GameState)
intermediate([Board, WhiteCubeList, BlackCubeList]) :-
      midBoard(Board),
      midWhiteCubes(WhiteCubeList),
      midBlackCubes(BlackCubeList).

final([Board, WhiteCubeList, BlackCubeList]) :-
      finalBoard(Board),
      finalWhiteCubes(WhiteCubeList),
      finalBlackCubes(BlackCubeList).
