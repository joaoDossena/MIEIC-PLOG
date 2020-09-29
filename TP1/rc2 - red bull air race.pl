

pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(macLean).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

team(lamb, breitling).
team(besenyei, redBull).
team(chambliss, redBull).
team(macLean, medRacingTeam).
team(mangold, cobra).
team(jones, matador).
team(bonhomme, matador).

plane(lamb, mx2).
plane(besenyei, edge540).
plane(chambliss, edge540).
plane(macLean, edge540).
plane(mangold, edge540).
plane(jones, edge540).
plane(bonhomme, edge540).

circuit(istanbul).
circuit(budapest).
circuit(porto).

won(jones, porto).
won(mangold, budapest).
won(mangold, istanbul).

gates(istanbul, 9).
gates(budapest, 6).
gates(porto, 5).

teamWins(TEAM, RACE) :-
	won(PILOT, RACE),
	team(PILOT, TEAM).

% 2a) won(X, porto).
% 2b) teamWins(X, porto).
% 2c) 
% 2d) 
% 2e) 

