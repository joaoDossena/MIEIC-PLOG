
inputRow(NewRow) :-
    readRow(Row),
    validateRow(Row, NewRow).

inputColumn(Column) :-
    readColumn(Column),
    validateColumn(Column).


readRow(Row) :-
    write('  > Row    '),
    read(Row).

readColumn(Column) :-
    write('  > Column '),
    read(Column).


% Checks if row is valid
validateRow('A', NewRow) :-
    NewRow = 1.
validateRow('B', NewRow) :-
    NewRow = 2.
validateRow('C', NewRow) :-
    NewRow = 3.
validateRow('D', NewRow) :-
    NewRow = 4.
validateRow('E', NewRow) :-
    NewRow = 5.
validateRow(_Row, NewRow) :-
    write('ERROR: That row is not valid!\n\n'),
    readRow(Input),
    validateRow(Input, NewRow).

% Checks if column is valid
validateColumn(1).
validateColumn(2).
validateColumn(3).
validateColumn(4).
validateColumn(5).
validateColumn(_Column) :-
    write('ERROR: That column is not valid!\n\n'),
    readColumn(Input),
    validateColumn(Input).