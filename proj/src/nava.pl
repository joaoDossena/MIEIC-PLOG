:- consult('menus.pl').
:- consult('display.pl').
:- consult('input.pl').
:- consult('utils.pl').
:- consult('computer.pl').
:- consult('logic.pl').

:- use_module(library(lists)).   % For easier list manipulation
:- use_module(library(between)). % For findall
:- use_module(library(random)).  % For the stupid bot

nava :-
  	mainMenu.

% Initial function to start game
% play/0
play :- 
	initial(GameState),
	gameLoop(GameState, 'Person', 'Stupid bot').