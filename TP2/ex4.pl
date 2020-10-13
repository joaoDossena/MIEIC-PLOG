factorial(0, 1).
factorial(1, 1).

factorial(N, Valor) :-
	N > 0,
	N1 is N-1,
	factorial(N1, V1),
	Valor is N*V1.

factorial2(N, F) :-
	factorial2_aux(N, 1, F).

factorial2_aux(0, F, F).
factorial2_aux(N, Acc, F) :-
	N > 0,
	N1 is N-1,
	Acc1 is N*Acc,
	factorial2_aux(N1, Acc1, F).