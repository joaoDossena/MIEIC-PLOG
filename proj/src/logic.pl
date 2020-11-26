% Manages the white player's turn: gets present and future coordinates, checks for validity of move, and moves.
% Returns a NewState; Player could be 'Person' or 'Computer'
% whitePlayerTurn(+GameState, -NewState, +Player)
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

% Manages the black player's turn: gets present and future coordinates, checks for validity of move, and moves.
% Returns a NewState; Player could be 'Person' or 'Computer'
% blackPlayerTurn(+GameState, -NewState, +Player)
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
  move([OldBoard, OldWhites, OldBlacks], [black, Row/Column, NewRow/NewColumn], NewState).


/*
whitePlayerTurn(Board, NewBoard, 'Computer') :-
  write('\n----------------- COMPUTER (WHITE) ------------------\n\n').  
blackPlayerTurn(Board, NewBoard, 'Computer') :-
  write('\n----------------- COMPUTER (BLACK) ------------------\n\n').
*/


% Gets distance of the movement, splits the stack, replaces the 2 stacks as needed, and deals with cubes. In other words, performs a movement.
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

% If the stack on Row/Column is empty, puts a cube there and updates the state. If not, returns the same state.
% addCube(+GameState, +Player, +Row/+Column, -NewState).
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

% Checks if Stack is a cube. If it is, the predicate returns an empty list and updates the state. 
% If it is not, the predicate returns the same stack.
% checkForCube(+GameState, +Stack, -NewStack, -NewGameState).
checkForCube([Board, OldWhites, OldBlacks], [whiteCube], [], [Board, NewWhites, OldBlacks]) :-
  NewWhites is OldWhites + 1.
checkForCube([Board, OldWhites, OldBlacks], [blackCube], [], [Board, OldWhites, NewBlacks]) :-
  NewBlacks is OldBlacks + 1.
checkForCube([Board, OldWhites, OldBlacks], Stack, Stack, [Board, OldWhites, OldBlacks]).

% Gets all valid moves possible, given a state and a player
% valid_moves(+GameState, +Player, -ListOfMoves)
valid_moves(GameState, Player, ListOfMoves) :-
  findall([Row/Column, NewRow/NewColumn], (between(1, 5, Row), between(1, 5, Column), between(1, 5, NewRow), between(1, 5, NewColumn),validMove(GameState, Player, Row/Column, NewRow/NewColumn)), ListOfMoves).

% Checks if a move from OldRow/OldColumn to NewRow/NewColumn is valid for player Player in a certain GameState.
% validMove(+GameState, +Player, +OldRow/+OldColumn, +NewRow/NewColumn).
validMove([Board, _WhiteCubesLeft, _BlackCubesLeft], Player, Row/Column, NewRow/NewColumn) :-
  Row >= 1, Row =< 5, NewRow >= 1, NewRow =< 5, Column >= 1, Column =< 5, NewColumn >= 1, NewColumn =< 5,
  checkStack(Board, Player, Row/Column, Stack),
  getDist([Row/Column, NewRow/NewColumn], Dist),
  length(Stack, Length),
  Dist =< Length.


% Alternates between white and black player turns, while no one wins.
% gameLoop(+GameState, +Player1, +Player2).
gameLoop(OldState, Player1, Player2) :-
  whitePlayerTurn(OldState, NewState, Player1),
  (
    (game_over(NewState, Victor),nl,write(Victor), write(' PLAYER WINS\nThanks for playing!\n'));
    (blackPlayerTurn(NewState, YetANewerState, Player2),
      (
        (game_over(YetANewerState, Victor),nl,write(Victor), write(' PLAYER WINS\nThanks for playing!\n'));
        (gameLoop(YetANewerState, Player1, Player2))
      )
    )
  ).

% Checks if game is over and returns winner
% game_over(+GameState, -Winner)
game_over(GameState, white) :-
  checkForWinner(GameState, white).
game_over(GameState, black) :-
  checkForWinner(GameState, black).

% Checks if player won the game
% checkForWinner(+GameState, +Player).
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
