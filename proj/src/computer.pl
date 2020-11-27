% Chooses computer move.
% choose_move(+GameState, +Player, +Level, -Move).
choose_move([Board, WhiteCubesLeft, BlackCubesLeft], Player, 'Stupid bot', Move) :-
	valid_moves([Board, WhiteCubesLeft, BlackCubesLeft], Player, ListOfValidMoves),
	%% trace,
	length(ListOfValidMoves, Length),
	NewLength is Length + 1,
	random(1, NewLength, RandomIndex),
	nth1(RandomIndex, ListOfValidMoves, Move).
%% choose_move([Board, WhiteCubesLeft, BlackCubesLeft], Player, 'Smarter bot', Move) :-
	%% valid_moves([Board, WhiteCubesLeft, BlackCubesLeft], Player, ListOfValidMoves),
	%% length(ListOfValidMoves, Length),
	%% NewLength is Length + 1,
	%% random(1, NewLength, RandomIndex),
	%% nth1(RandomIndex, ListOfValidMoves, Move).

% Evaluates GameState to check value of a move
% value(+GameState, +Player, -Value).
value([Board, WhiteCubesLeft, BlackCubesLeft], white, Value) :-
  countPlayerFreePieces(Board, white, OwnMoveablePieces),
  countPlayerFreePieces(Board, black, EnemyMoveablePieces),
  Value is (BlackCubesLeft * OwnMoveablePieces * OwnMoveablePieces)
  		  /(WhiteCubesLeft * EnemyMoveablePieces * EnemyMoveablePieces + 1).
value([Board, WhiteCubesLeft, BlackCubesLeft], black, Value) :-
  countPlayerFreePieces(Board, black, OwnMoveablePieces),
  countPlayerFreePieces(Board, white, EnemyMoveablePieces),
  Value is (BlackCubesLeft * OwnMoveablePieces * OwnMoveablePieces)
  		  /(WhiteCubesLeft * EnemyMoveablePieces * EnemyMoveablePieces + 1).