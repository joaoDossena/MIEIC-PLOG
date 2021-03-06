:- use_module(library(between)).

comprou(joao, honda).
ano(honda, 1997).

comprou(joao, uno).
ano(uno, 1998).

valor(honda, 20000).
valor(uno, 7000).


pode_vender(PESSOA, CARRO, ANO_ATUAL) :-
	between(1900, 2100, ANO_ATUAL),
	comprou(PESSOA, CARRO),
	ano(CARRO, ANO_COMPRA),
	(ANO_ATUAL - ANO_COMPRA =< 10),
	valor(CARRO, VALOR),
	VALOR < 10000.