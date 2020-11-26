

% Evaluates GameState to check value of a move
% value(+GameState, +Player, -Value).
% value([Board, WhiteCubesLeft, BlackCubesLeft], white, Value) :-
  % conta peças próprias livres: PPL
  % conta peças inimigas livres: PIL
  % Value is (BlackCubesLeft * PPL)/(WhiteCubesLeft * PIL * PIL + 1).
% value([Board, WhiteCubesLeft, BlackCubesLeft], black, Value) :-
  % conta peças próprias livres: PPL
  % conta peças inimigas livres: PIL
  % Value is (WhiteCubesLeft * PPL)/(BlackCubesLeft * PIL * PIL + 1).