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


alunoDe(ALUNO, PROF) :- 
	aluno(ALUNO, CADEIRA),
	professor(PROF, CADEIRA),
	frequenta(ALUNO, UNI),
	funcionario(PROF, UNI).

frequentaUniversidade(PESSOA, UNI) :-
	frequenta(PESSOA, X).
frequentaUniversidade(PESSOA, UNI) :-
	funcionario(PESSOA, X).

colega(X, Y) :-
	aluno(X, CADEIRA),
	aluno(Y, CADEIRA),
	X \= Y.
colega(X, Y) :-
	frequenta(X, UNI),
	frequenta(Y, UNI),
	X \= Y.
colega(X, Y) :-
	funcionario(X, UNI),
	funcionario(Y, UNI),
	X \= Y.

	

% 9a) alunoDe(ALUNO, PROF).
% 9b) 
% 9c) colega(X, Y).