:- consult('menus.pl').
:- consult('display.pl').
:- consult('input.pl').
:- consult('computer.pl').
:- consult('logic.pl').


nava :-
	mainMenu.

play :- 
	initialBoard(InitialBoard),
	initialWhiteCubes(WhiteCubeList),
	initialBlackCubes(BlackCubeList),
	display_game(GameState, Player).