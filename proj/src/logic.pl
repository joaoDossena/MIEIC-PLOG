

blackPlayerTurn(Board, NewBoard, 'Person') :-
      write('\n------------------ PLAYER (BLACK)  -------------------\n\n'),
      write('1. Do you want to move a worker? [0(No)/1(Yes)]'),
      manageMoveWorkerBool(MoveWorkerBoolX),
      moveWorker(Board, MoveWorkerBoolX, Board1),
      askCoords(Board1, black, NewBoard, empty),
      printBoard(NewBoard).

/*blackPlayerTurn(Board, NewBoard, 'Computer') :-
      write('\n----------------- COMPUTER (BLACK) ------------------\n\n'),
      computerMoveWorkers(Board, Board1),
      generatePlayerMove(Board1, NewRowIndex, NewColumnIndex),
      replaceInMatrix(Board1,  NewRowIndex, NewColumnIndex, black, NewBoard),
      printComputerMove(NewRowIndex, NewColumnIndex),
      printBoard(NewBoard).
*/
whitePlayerTurn(NewBoard, FinalBoard, 'Person') :-
      write('\n------------------ PLAYER 1 (WHITE) -------------------\n\n'),
      write('1. Do you want to move a worker? [0(No)/1(Yes)]'),
      manageMoveWorkerBool(MoveWorkerBoolO),
      moveWorker(NewBoard, MoveWorkerBoolO, Board1),
      askCoords(Board1, white, FinalBoard, empty),
      printBoard(FinalBoard).

/*whitePlayerTurn(Board, FinalBoard, 'Computer') :-
      write('\n----------------- COMPUTER (WHITE) ------------------\n\n'),
      computerMoveWorkers(Board, Board1),
      generatePlayerMove(Board1, NewRowIndex, NewColumnIndex),
      replaceInMatrix(Board1,  NewRowIndex, NewColumnIndex, white, FinalBoard),
      printComputerMove(NewRowIndex, NewColumnIndex),
      printBoard(FinalBoard).
*/

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

%Começo do jogo, em que recebe os 2 jogadores, gera o tabuleiro inicial, e começa o loop do jogo.
startGame(Player1, Player2) :-
      initialBoard(InitialBoard),
      gameLoop(InitialBoard, Player1, Player2).