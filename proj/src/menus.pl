% Shows main menu 
% mainMenu/0
mainMenu :-
    printMainMenu,
    askMenuOption,
    read(Input),
    manageInput(Input).

% Manages user input: starts game according to user's wishes.
% manageInput(+Input).
manageInput(1) :-
    !,
    initial(GameState),
    gameLoop(GameState, 'Person', 'Person').
manageInput(2) :-
    !,
    initial(GameState),
    gameLoop(GameState, 'Person', 'Stupid bot').
manageInput(3) :-
    !,
    initial(GameState),
    gameLoop(GameState, 'Person', 'Smarter bot').
manageInput(4) :-
    !,
    initial(GameState),
    gameLoop(GameState, 'Stupid bot', 'Stupid bot').
manageInput(5) :-
    !,
    initial(GameState),
    gameLoop(GameState, 'Stupid bot', 'Smarter bot').
manageInput(6) :-
    !,
    initial(GameState),
    gameLoop(GameState, 'Smarter bot', 'Smarter bot').
manageInput(0) :-
    write('\nExiting...\n\n').
manageInput(_Other) :-
    write('\nERROR: that option does not exist.\n\n'),
    askMenuOption,
    read(Input),
    manageInput(Input).

% Prints main menu 
% printMainMenu/0
printMainMenu :-
    nl,nl,
    write(' _______________________________________________________________________ '),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|               *@@@@@@@@m   m@*@@m  *@@*   *@@*  m@*@@m                |'),nl,
    write('|                 @@    @@  @@   @@    @@   m@   @@    @                |'),nl,
    write('|                 @!    @@   m@@@!@     @@ m@     m@@@!@                |'),nl,
    write('|                                        !@!                            |'),nl,
    write('|                                                                       |'),nl,
    write('|                              Joao Dossena                             |'),nl,
    write('|               -----------------------------------------               |'),nl,
    write('|                                                                       |'),nl,
    write('|                          1. Player     vs Player                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                          2. Player     vs Stupid bot                  |'),nl,
    write('|                                                                       |'),nl,
	write('|                          3. Player     vs Smarter bot                 |'),nl,
    write('|                                                                       |'),nl,
    write('|                          4. Stupid bot vs Stupid bot                  |'),nl,
    write('|                                                                       |'),nl,
    write('|                          5. Stupid bot vs Smarter bot                 |'),nl,
    write('|                                                                       |'),nl,
    write('|                          6. Smarter bot vs Smarter bot                |'),nl,
    write('|                                                                       |'),nl,
    write('|                          0. Exit                                      |'),nl,
    write(' _______________________________________________________________________ '),nl,nl.

% Asks for menu option
% askMenuOption/0
askMenuOption :-
    write('> Insert your option'),nl.