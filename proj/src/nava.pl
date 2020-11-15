:- consult('menus.pl').
:- consult('display.pl').
:- consult('input.pl').
:- consult('computer.pl').
:- consult('logic.pl').


nava :-
  	mainMenu.

% Initial function to start game
% play/0
play :- 
	initial(GameState),
	display_game(GameState, white),
	checkForWinner(GameState, white).