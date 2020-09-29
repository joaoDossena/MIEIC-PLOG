aluno(joao, paradigmas).
aluno(maria, paradigmas).
aluno(joel, lab2).
aluno(joel, estruturas).

frequenta(joao, feup).
frequenta(maria, feup).
frequenta(joel, ist).

professor(carlos, paradigmas).
professor(ana_paula, estruturas).
professor(pedro, lab2).

funcionario(pedro, ist).
funcionario(ana_paula, feup).
funcionario(carlos, feup).


colega(X, Y) :-
	aluno(X, CADEIRA),
	aluno(Y, CADEIRA),
	X \= Y;

	frequenta(X, UNI),
	frequenta(Y, UNI),
	X \= Y;

	funcionario(X, UNI),
	funcionario(Y, UNI),
	X \= Y.

	

% 9a) aluno(Y, CADEIRA), professor(X, CADEIRA).
% 9b) frequenta(ALUNO, X); funcionario(PROF, X).
% 9c) colega(X, Y).