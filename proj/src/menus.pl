mainMenu :-
    printMainMenu,
    askMenuOption,
    read(Input),
    manageInput(Input).

% Manage Input
manageInput(1) :-
    startGame('Person', 'Person'),  %player vs player
    mainMenu.

manageInput(2) :-
    startGame('Person', 'Computer'),  %player vs computer
    mainMenu.

manageInput(3) :-
    startGame('Computer', 'Computer'),  %computer vs computer
    mainMenu.

manageInput(0) :-
    write('\nExiting...\n\n'),
    mainMenu.

manageInput(_Other) :-
    write('\nERROR: that option does not exist.\n\n'),
    askMenuOption,
    read(Input),
    manageInput(Input).



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
    write('|                              Joao Santos                              |'),nl,
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

askMenuOption :-
    write('> Insert your option ').
                                
