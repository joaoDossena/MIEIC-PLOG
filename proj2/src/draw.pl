

draw_puzzle(Largura, 0, L):-
    draw_division(Largura, L), nl.

draw_puzzle(Largura, Altura, L):- %L são as coordenadas dos diamantes
    draw_division(Largura, L), nl,
    put_code(9482), draw_line(Largura, L), nl,
    NewAltura is Altura - 1,
    draw_puzzle(Largura, NewAltura, L).


draw_line(0, L).

draw_line(Largura, Altura, [[X, Y]|_]):-
    dif(Largura, X),
    dif(Altura, X),
    draw_cell(0),
    NewLargura is Largura - 1,
    draw_line(NewLargura, L).


draw_cell(0):-
    write('  '), put_code(9482).

draw_division(0, L):- put_code(9480).

draw_division(Largura, L):-
    put_code(9480), put_code(9480), put_code(9480),
    NewLargura is Largura - 1,
    draw_division(NewLargura, L).