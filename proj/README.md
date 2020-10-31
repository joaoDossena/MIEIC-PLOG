# Relatório Intercalar
## MIEIC-PLOG

João Pedro Olinto Dossena (UP201800174)  
João Francisco Ribeiro dos Santos (UP201707427)  
Turma: 7  
Grupo: Nava_3  

## Nava

### Descrição do Jogo
#### Início
Estamos a implementar a versão de 2 jogadores de Nava, adaptando o tabuleiro para casas por simplicidade. Um dos jogadores terá peças brancas (o primeiro a jogar), e o outro terá peças pretas. Ambos começam com uma pilha de 6 peças redondas em cantos opostos de um tabuleiro 5x5, e com 9 peças cúbicas fora do tabuleiro.
#### Jogadas
A cada jogada, o jogador deverá retirar um número X de seus discos do topo de uma das suas pilhas, e movê-los em linha reta (sem ser diagonal), colocando essa subpilha a X casas de distância (sendo X limitado pelo número de casas no tabuleiro, e pelo número de peças na pilha).
#### Pilhas
Se um jogador A mover sua pilha para cima de uma pilha de um jogador B, essa pilha agora é controlada pelo jogador A (podendo este dividí-la da maneira que quiser). Ou seja, uma pilha é controlada pelo dono da peça que está no topo. Isso significa que, ao fazer uma subsequente divisão de uma pilha, o jogador A pode acabar por criar uma pilha controlada pelo jogador B.
#### Criação de cubos
Se um jogador remover uma pilha inteira de uma casa, deixando-a vazia, ele deverá colocar um de seus cubos nessa casa.
#### Remoção de cubos
Se um jogador colocar uma pilha numa casa onde há um cubo, ele deverá devolver o cubo para o dono, e colocar sua pilha normalmente (inclusive se o cubo for dele próprio).
#### Término do jogo
Há duas formas de se ganhar: obtendo-se controlo de todas as pilhas adversárias, ou colocando-se no tabuleiro todos os seus 9 cubos. 

##### Mais informações
- [Página oficial do jogo](https://boardgamegeek.com/boardgame/250491/nava)  
- [Livro de regras](./Nava_Final_Rule_Sheet_-_David_Cordell.pdf)

### Representação interna do estado do jogo
No tabuleiro inicial estarão os dois jogadores com as pilhas de 6 discos em cantos opostos. Seus cubos estarão fora do tabuleiro

O predicado initialBoard/1 recebe uma lista (matriz) de listas (linhas) de listas (pilhas). Ele representa a configuração inicial do tabuleiro:

	initialBoard([
		[[empty], [empty], [empty], [empty], [black, black, black, black, black, black]],
		[[empty], [empty], [empty], [empty], [empty]],
		[[empty], [empty], [empty], [empty], [empty]],
		[[empty], [empty], [empty], [empty], [empty]],
		[[white, white, white, white, white, white], [empty], [empty], [empty], [empty]]
	]).

Os predicados initialWhiteCubes/1 e initialBlackCubes/1 representam, respectivamente, os cubos brancos e pretos fora do tabuleiro, ou seja, a configuração inicial dos cubos:

	initialWhiteCubes([whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube, whiteCube]).
	initialBlackCubes([blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube, blackCube]).

### Visualização do estado de jogo

