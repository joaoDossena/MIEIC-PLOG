


/*Loop do jogo, em que recebe a jogada de cada jogador e verifica o estado do jogo a seguir.
gameLoop(Board, Player1, Player2) :-
      blackPlayerTurn(Board, NewBoard, Player1),
      (
            (checkGameState('black', NewBoard), write('\nThanks for playing!\n'));
            (whitePlayerTurn(NewBoard, FinalBoard, Player2),
                  (
                        (checkGameState('white', FinalBoard), write('\nThanks for playing!\n'));
                        (gameLoop(FinalBoard, Player1, Player2))
                  )
           )
      ).
*/

startGame(Player1, Player2) :-
      initialBoard(InitialBoard).
      %addPlayers(InitialBoard, NewBoard, Player1, Player2),
      %gameLoop(NewBoard, Player1, Player2).