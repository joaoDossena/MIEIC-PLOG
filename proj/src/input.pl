    
inputRow(NewRow) :-
    readRow(Row),
    validateRow(Row, NewRow).

inputColumn(NewColumn) :-
    readColumn(Column),
    validateColumn(Column, NewColumn).


readRow(Row) :-
    write('  > Row    \n'),
    read(Row).

readColumn(Column) :-
    write('  > Column \n'),
    read(Column).


% Checks if row is valid
validateRow('a', NewRow) :-
    NewRow = 1.
validateRow('b', NewRow) :-
    NewRow = 2.
validateRow('c', NewRow) :-
    NewRow = 3.
validateRow('d', NewRow) :-
    NewRow = 4.
validateRow('e', NewRow) :-
    NewRow = 5.
validateRow(_Row, NewRow) :-
    %% Row =!= 'A', Row =!= 'B', Row =!= 'C', Row =!= 'D', Row =!= 'E',
    write('ERROR: That row is not valid!\n\n'),
    readRow(Input),
    validateRow(Input, NewRow).

% Checks if column is valid
validateColumn(1, NewColumn) :-
    NewColumn = 1, !.
validateColumn(2, NewColumn) :-
    NewColumn = 2, !.
validateColumn(3, NewColumn) :-
    NewColumn = 3, !.
validateColumn(4, NewColumn) :-
    NewColumn = 4, !.
validateColumn(5, NewColumn) :-
    NewColumn = 5, !.
validateColumn(_Column, NewColumn) :-
    %% Column =!= 1, Column =!= 2, Column =!= 3, Column =!= 4, Column =!= 5,
    write('ERROR: That column is not valid!\n\n'),
    readColumn(Input),
    validateColumn(Input, NewColumn).