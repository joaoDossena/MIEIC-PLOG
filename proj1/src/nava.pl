:- consult('menus.pl').
:- consult('display.pl').
:- consult('input.pl').
:- consult('utils.pl').
:- consult('computer.pl').
:- consult('logic.pl').

:- use_module(library(lists)).   % For easier list manipulation
:- use_module(library(between)). % For findall
:- use_module(library(random)).  % For the stupid bot

% Initial function to start game
% play/0
play :- 
	mainMenu.