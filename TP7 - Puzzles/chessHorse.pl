% 1a)
valid_spot(X/Y) :-
	X >= 1, X =< 8,
	Y >= 1, Y =< 8.

horse_jump(X1/Y1, X2/Y2) :-
	valid_spot(X1/Y1),
	(movement(Distx,Disty); movement(Disty,Distx)),
	X2 is X1+Distx,
	Y2 is Y1+Disty,
	valid_spot(X2/Y2).
	

movement(2,1).
movement(-2,1).
movement(2,-1).
movement(-2,-1).

% 1b)

horse_trajectory([Traj]).
horse_trajectory([Pair1, Pair2|Rest]) :-
	horse_jump(Pair1, Pair2),
	horse_trajectory([Pair2|Rest]).

% 1c)

path([2/1, P2, 5/4, P4x/8]) :-
	horse_trajectory([2/1, P2, 5/4, P4x/8]).

