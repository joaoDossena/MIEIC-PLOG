% Zebra problem
:- use_module(library(clpfd)).


zebra(Zebra, Water) :-
	% Variables and domain
	Solution = [Nation, Animal, Drink, Color, Tobacco],
	Nation = [ENG, SPA, NOR, UKR, POR],
	Animal = [Dog, Fox, Iguana, Horse, Zebra],
	Drink = [OJ, Tea, Coffee, Milk, Water],
	Color = [Red, Yellow, Blue, Green, White],
	Tobacco = [Marlboro, Chesterfields, Winston, LuckyStrike, SGLights],

	List = [ENG, SPA, NOR, UKR, POR, Dog, Fox, Iguana, Horse, Zebra,
		OJ, Tea, Coffee, Milk, Water, Red, Yellow, Blue, Green, White,
		Marlboro, Chesterfields, Winston, LuckyStrike, SGLights],
	domain(List, 1, 5),


	% Restrictions
	all_different(Nation),
	all_different(Animal),
	all_different(Drink),
	all_different(Color),
	all_different(Tobacco),
	
	ENG #= Red,
	SPA #= Dog,
	NOR #= 1,
	Yellow #= Marlboro,
	abs(Chesterfields - Fox) #= 1,
	abs(NOR - Blue) #= 1,
	Winston #= Iguana,
	LuckyStrike #= OJ,
	UKR #= Tea,
	POR #= SGLights,
	abs(Marlboro - Horse) #= 1,
	Green #= Coffee,
	Green #= White + 1,	
	Milk #= 3,


	% Search
	labeling([], List),
	write(Solution),nl.