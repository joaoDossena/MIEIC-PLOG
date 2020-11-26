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
    startGame('Person', 'Person'),
    mainMenu.
manageInput(2) :-
    startGame('Person', 'Stupid bot'),
    mainMenu.
manageInput(3) :-
    startGame('Computer', 'Computer'),
    mainMenu.
manageInput(0) :-
    write('\nExiting...\n\n'),
    mainMenu.
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
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                              Joao Dossena                             |'),nl,
    write('|                                                                       |'),nl,
    write('|               -----------------------------------------               |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                          1. Player   vs Player                        |'),nl,
    write('|                                                                       |'),nl,
    write('|                          2. Player   vs Computer                      |'),nl,
    write('|                                                                       |'),nl,
	write('|                          3. Computer vs Computer                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                          0. Exit                                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write(' _______________________________________________________________________ '),nl,nl.

% Asks for menu option
% askMenuOption/0
askMenuOption :-
    write('> Insert your option ').