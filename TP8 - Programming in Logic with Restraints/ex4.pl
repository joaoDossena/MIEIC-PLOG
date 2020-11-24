% CRYPTOGRAMS problem

send(Vars) :-
	% Variables and domain
	Vars = [S, E, N, D, M, O, R, Y],
	domain(Vars, 0, 9),


	% Restrictions
	all_different(Vars),
	S #\= 0, M #\= 0,
		  1000*S + 100*E + 10*N + D
+		  1000*M + 100*O + 10*R + E #=
10000*M + 1000*O + 100*N + 10*E + Y,

	% Search
	labeling([], Vars).


sendBetter(Vars) :-
	% Variables and domain
	Vars = [S, E, N, D, M, O, R, Y],
	domain(Vars, 0, 9),
	domain([C1, C2, C3, C4], 0, 1),

	% Restrictions
	all_different(Vars),
	S #\= 0, M #\= 0,
	D + E #= Y + C1*10,
	N + R + C1 #= E + C2*10,
	E + O + C2 #= N + C3*10,
	S + M + C3 #= O + C4*10,
	M #= C4,

	% Search
	labeling([], Vars).

