:- consult('menus.pl').
:- consult('display.pl').
:- consult('input.pl').
:- consult('computer.pl').
:- consult('logic.pl').


% nava :-
%  	mainMenu.


play :- 
	initial(GameState),
	display_game(GameState, white).