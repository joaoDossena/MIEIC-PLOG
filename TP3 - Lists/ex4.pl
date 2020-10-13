

inverterAppend([], []).
inverterAppend([H|T], InvList) :- 
	append([H], InvList),
	inverterAppend(T, InvList).