:- dynamic(played/4).


player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A Player', 16).

game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).

% Pergunta 1
achievedALot(Player) :-
	played(Player, _, _, Percentage),
	Percentage >= 80.

% Pergunta 2
isAgeAppropriate(Name, Game) :-
	player(Name, _, Age),
	game(Game, _, MinAge),
	Age >= MinAge.

% Pergunta 3
timePlayingGames(_Player, [], [], 0).
timePlayingGames(Player, [Game|Games], [Time|Times], NewSum) :-
	timePlayingGame(Player, Games, Times, SumTimes),
	played(Player, Game, Time, _),
	NewSum is SumTimes + Time.
timePlayingGames(Player, [Game|Games], [NewTime|Times], NewSum) :-
	timePlayingGame(Player, Games, Times, SumTimes),
	\+played(Player, Game, _Time, _),
	NewTime is 0,
	NewSum is SumTimes.

% Pergunta 4
listGamesOfCategory(Cat) :-
	game(Game, CL, MinAge),
	member(Cat, CL),
	write(Game), write(' ('), write(MinAge),write(')'),nl,
	fail.
listGamesOfCategory(_).

% Pergunta 5
updatePlayer(Player, Game, Hours, Percentage) :-
	retract(played(Player, Game, OldHours, OldPercentage)),
	NewHours is Hours + OldHours, NewPercentage is Percentage + OldPercentage,
	assert(played(Player, Game, NewHours, NewPercentage)).
updatePlayer(Player, Game, Hours, Percentage) :-
	assert(played(Player, Game, Hours, Percentage)).

% Pergunta 6
fewHours(Player, Games) :-
	fewHours_aux(Player, Games, []).
fewHours_aux(Player, Games, Acc) :-
	played(Player, Game, Time, _), 
	Time < 10,
	\+member(Game, Acc), !, 
	fewHours_aux(Player, Games, [Game|Acc]).
fewHours_aux(_Player, Games, Games).

% Pergunta 7
ageRange(Min, Max, Players) :-
	findall(Name, (player(Name, _, Age), Age =< Max, Age >= Min), Players).
	
% Pergunta 8
sumList([], 0).
sumList([H|T], NewSum) :-
	sumList(T, Sum),
	NewSum is Sum + H.
averageAge(Game, Avg) :-
	findall(Age, (played(Player, Game, _, _), player(_, Player, Age)), List),
	sumList(List, Sum),
	length(List, Length),
	Avg is Sum/Length.

% Pergunta 9
:- use_module(library(lists)).
mostEffectivePlayers(Game, Players) :-
	findall(Eff, (played(Player, Game, Hours, Percentage), Eff is Percentage/Hours), L),
	sort(L, SortedL),
	reverse(SortedL, RevL),
	[BestEff|_Rest] = RevL,
	findall(Player, (played(Player, Game, Hours, Percentage), Eff is Percentage/Hours, Eff == BestEff), Players).

% Pergunta 11
f(I, I, 0).
f(1, 2, 8).
f(1, 3, 8).
f(1, 4, 7).
f(1, 5, 7).
f(2, 3, 2).
f(2, 4, 4).
f(2, 5, 4).
f(3, 4, 3).
f(3, 5, 3).
f(4, 5, 1).
f(I, J, X) :- f(J, I, X).

% Pergunta 12
areClose(Dist, Mat, Pares) :-
	setof(I/J, (nth1(I,Mat,Row), nth1(J,Row,X), X =< Dist), Pares).


% Pergunta 13

[10, [7, [5, [4, [3, australia, [2, [1, staHelena, anguila], georgiaSul]], reinoUnido], [6, servia, franca]], [8, [9, niger, india], irlanda]], brasil]

% Pergunta 14
