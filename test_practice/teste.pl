%% :-use_module(library(lists)).

%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).


% Pergunta 1
madeItThrough(Part):-
performance(Part,Times),
member(120, Times).

% Pergunta 2
nth1(1, [H|_], H).
nth1(Ix, [_H|T], Elem) :-
NewIx is Ix - 1,
nth1(NewIx, T, Elem).

juriTimes(L, JuriMember, Times, Total):-
	juriTimes(L, JuriMember, Times, Total, 0).

juriTimes([], _JuriMember, [], T, T) .
juriTimes([H|T], JuriMember, [Time|Times], Total, Acc) :-
performance(H, LTimes),
nth1(JuriMember, LTimes, Time),
NewTotal is Acc + Time,
juriTimes(T, JuriMember, Times, Total, NewTotal).

%Pergunta 3

aux(JuriMember, Part) :-
	madeItThrough(Part),
	juriTimes([Part], JuriMember, [Time], _Total),
	Time == 120.

patientJuri(JuriMember) :-
	aux(JuriMember, Part1),
	aux(JuriMember, Part2),
	Part1 \= Part2.

% Pergunta 4
somaValores([], Acc, Acc).
somaValores([H|T], Acc, Soma) :-
	NewAcc is Acc + H,
	somaValores(T, NewAcc, Soma).

bestParticipant(P1, P2, P1) :-
	performance(P1, L1),
	somaValores(L1, 0, S1),
	performance(P2, L2),
	somaValores(L2, 0, S2),
	S1 > S2.
bestParticipant(P1, P2, P2) :-
	performance(P1, L1),
	somaValores(L1, 0, S1),
	performance(P2, L2),
	somaValores(L2, 0, S2),
	S1 < S2.

bestParticipant(P1, P2, P2) :-
	performance(P1, L1),
	somaValores(L1, 0, S1),
	performance(P2, L2),
	somaValores(L2, 0, S2),
	S1 == S2, fail.

%Pergunta 5
allPerfs :-
	!,
	participant(P, _Number, Name),
	performance(P, Times),
	write(P),write(':'), write(Name), write(':'), write(Times),nl, 
	fail.

%Pergunta 6
nSuccessfulParticipants(T) :-
	findall(P, performance(P, [120,120,120,120]), L),
	length(L, T). 

%Pergunta 7

juriFans(P, L1):-
	findall(J, (performance(P, L),nth1(J, L, 120)), L1).


juriFans(L):-
	findall(P-List, juriFans(P, List), L).

