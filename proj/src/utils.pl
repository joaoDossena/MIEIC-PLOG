
% Returns stack on position Row/Column on Board
% getStackFromBoard(+Board, +RowIndex/+ColumnIndex, -Stack)
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
% whiteStack(+Stack).
whiteStack([TopOfStack|_RestOfStack]) :-
  TopOfStack == white.

% Checks if top of stack is black
% blackStack(+Stack).
blackStack([TopOfStack|_RestOfStack]) :-
  TopOfStack == black.


% Replaces element in a list at IndexOfElemToReplace by NewElem, returns NewList with element replaced.
% replaceElem(NewElem, IndexOfElemToReplace, NewList).
replaceElem(_, _, [], []).
replaceElem(Elem, 1, [_|T], [Elem|T1]):-
    replaceElem(_, 0, T, T1).
replaceElem(Elem, N, [H|T], [H|T1]):-
    N1 is N - 1,
    replaceElem(Elem, N1, T, T1).

% Replaces stack at RowIndex/ColumnIndex by Stack, returns NewBoard with stack replaced.
% replaceStack(+Board, +RowIndex/+ColumnIndex, +Stack, -NewBoard).
replaceStack(Board, RowNumber/ColumnNumber, Elem, NewBoard):-
    nth1(RowNumber, Board, Row),
    replaceElem(Elem, ColumnNumber, Row, NewRow),
    replaceElem(NewRow, RowNumber, Board, NewBoard).

% Splits stack into 2 substacks: the top one, with NumberOfPieces pieces; and the bottom one, with the rest.
% splitStack(+Board, +RowIndex/+ColumnIndex, +NumberOfPieces, -TopSubstack, -BottomSubstack).
splitStack(Board, Row/Column, NumPieces, TopSubstack, BottomSubstack) :-
  getStackFromBoard(Board, Row/Column, Stack),
  getNTopPieces(Stack, NumPieces, TopTemp),
  reverse(TopTemp, TopSubstack),
  removeNTopPieces(Stack, NumPieces, BottomTemp),
  reverse(BottomTemp, BottomSubstack).

% Returns on Substack the N top pieces of Stack.
% getNTopPieces(+Stack, +NumberOfPieces, -Substack).
getNTopPieces(Stack, N, Substack):-
  length(Stack, Length), Length >=  N,
  getNTopPiecesAux(Stack, N, Substack, []).
getNTopPiecesAux(_Stack, 0, Substack, Substack).
getNTopPiecesAux([H|T], N, Substack, Acc):-
  N1 is N - 1,
  getNTopPiecesAux(T, N1, Substack, [H|Acc]).

% Returns on Substack the bottom pieces of Stack after removing N pieces from the top.
% removeNTopPieces(+Stack, +NumberOfPieces, -Substack).
removeNTopPieces(Stack, N, Substack):-
  length(Stack, Length), Length >=  N,
  removeNTopPiecesAux(Stack, N, Substack).
removeNTopPiecesAux(Stack, 0, Stack).
removeNTopPiecesAux([_H|T], N, Substack):-
  N1 is N - 1,
  removeNTopPiecesAux(T, N1, Substack).

% Returns distance played by a certain movement.
% getDist(+Move, -Dist).
getDist([Row/Column, Row/NewColumn], Dist) :-
  Dist is abs(NewColumn - Column),
  Dist > 0.
getDist([Row/Column, NewRow/Column], Dist) :-
  Dist is abs(NewRow - Row),
  Dist > 0.

% Counts Player's free movable pieces.
% countPlayerFreePieces(+Board, +Player, -Amount).
countPlayerFreePieces(Board, Player, Amount) :-
  findall(Length, (checkStack(Board, Player, _RowIndex/_ColumnIndex, Stack), length(Stack, Length)), AllPlayerStackSizes),
  sumList(AllPlayerStackSizes, Amount).

% Sums every value from list and returns the sum.
% sumList(+List, -Sum).
sumList([], 0).
sumList([H|T], Sum) :-
  sumList(T, TempSum),
  Sum is TempSum + H.