:- initialization main.

executaMenu():-
    write("---------------------"), nl,
    write("Projeto APLP - Prolog"), nl,
    write("---------------------"), nl,
    write("Escolha um modo de jogo:"), nl,
    write("1 - Um jogador"), nl,
    write("2 - Dois jogadores"), nl,
    write("3 - Sair"), nl,
    read(OPCAO),
    opcao(OPCAO).

opcao(1):-
    write("Modo de jogo: Um jogador"), nl,
    umJogador().

opcao(2):-
    write("Modo de jogo: Dois jogadores"), nl,
    doisJogadores().

opcao(3):-
    write("Até  mais!"), nl.

opcao(_):-
    write("Opção inválida. Selecione outra opção: "),
    executaMenu().

opcoesDeChute():-
    write("1 - Esquerda Baixo"), nl,
    write("2 - Esquerda Cima"), nl,
    write("3 - Meio Baixo"), nl,
    write("4 - Meixo Cima"), nl,
    write("5 - Direita Baixo"), nl,
    write("6 - Direita Cima"), nl.

umJogador():-
    write("Um jogador"), nl,
    rodadas1jogador(1,0,0).

doisJogadores():- 
    write("Dois jogadores"), nl,
    rodadas2jogadores(1, 0, 0).

rodadas1jogador(6, PLACAR11, PLACAR12):-
    mostrarPlacar(PLACAR11, PLACAR12, 1),
    resultado(PLACAR11, PLACAR12, 1).

rodadas1jogador(RODADA1, PLACAR11, PLACAR2):-
    imprimirRodada(RODADA1),
    mostrarPlacar(PLACAR11, PLACAR2, 1),
    write("JOGADOR:"), nl,
    opcoesChute(),
    read(CHUTE11),
    incrementa(CHUTE11, LIMITE11),
    random_between(CHUTE11, LIMITE11, DEFESA11),
    chutar(CHUTE11, DEFESA11, FOIGOL11),
    imprimirPuloGoleiro(CHUTE11, FOIGOL11),
    verificaGol(FOIGOL11),
    soma(PLACAR11, FOIGOL11, NOVOPLACAR11),

    write("PC: (jogada aleatóra)"), nl,
    random_between(1, 6, CHUTE12),
    incrementa(CHUTE12, LIMITE12),
    random_between(CHUTE12, LIMITE12, DEFESA12),
    chutar(CHUTE12, DEFESA12, FOIGOL12),
    imprimirPuloGoleiro(CHUTE12, FOIGOL12),
    verificaGol(FOIGOL12),
    soma(PLACAR2, FOIGOL12, NOVOPLACAR12),
    incrementa(RODADA1, NOVARODADA1),

    rodadas1jogador(NOVARODADA1, NOVOPLACAR11, NOVOPLACAR12).

rodadas2jogadores(6, PLACAR1, PLACAR2):-
    mostrarPlacar(PLACAR1, PLACAR2, 2),
    resultado(PLACAR1, PLACAR2, 2).

rodadas2jogadores(RODADA, PLACAR1, PLACAR2):-
    imprimirRodada(RODADA),
    mostrarPlacar(PLACAR1, PLACAR2, 2),
    write("JOGADOR 1:"), nl,
    opcoesChute(),
    read(CHUTE1),
    incrementa(CHUTE1, LIMITE1),
    random_between(CHUTE1, LIMITE1, DEFESA1),
    chutar(CHUTE1, DEFESA1, FOIGOL1),
    imprimirPuloGoleiro(CHUTE1, FOIGOL1),
    verificaGol(FOIGOL1),
    soma(PLACAR1, FOIGOL1, NOVOPLACAR1),

    write("JOGADOR 2:"), nl,
    opcoesChute(),
    read(CHUTE2),
    incrementa(CHUTE2, LIMITE2),
    random_between(CHUTE2, LIMITE2, DEFESA2),
    chutar(CHUTE2, DEFESA2, FOIGOL2),
    imprimirPuloGoleiro(CHUTE2, FOIGOL2),
    verificaGol(FOIGOL2),
    soma(PLACAR2, FOIGOL2, NOVOPLACAR2),
    incrementa(RODADA, NOVARODADA),
    rodadas2jogadores(NOVARODADA, NOVOPLACAR1, NOVOPLACAR2).

incrementa(OLD, NEW):- NEW is OLD + 1.
soma(A, B, C):- C is A + B.

resultado(P1, P2, 2):- P1 > P2, write("Jogador 1 venceu"), nl.
resultado(P1, P2, 2):- P1 < P2, write("Jogador 2 venceu"), nl.
resultado(P1, P2, 1):- P1 > P2, write("Jogador venceu"), nl.
resultado(P1, P2, 1):- P1 < P2, write("PC venceu"), nl.
resultado(P1, P1, _):- write("Empate!!!"), nl.

mostrarPlacar(PLACAR1, PLACAR2, 1):-
    nl, write("Jogador: "),
    write(PLACAR1),
    write(" x "),
    write(PLACAR2),
    write(" :PC"), nl, nl.

mostrarPlacar(PLACAR1, PLACAR2, 2):-
    nl, write("Jogador 1: "),
    write(PLACAR1),
    write(" x "),
    write(PLACAR2),
    write(" :Jogador 2"), nl, nl.


imprimirRodada(1):- write("Primeira Rodada!"), nl.
imprimirRodada(2):- write("Segunda Rodada!"), nl.
imprimirRodada(3):- write("Terceira Rodada!"), nl.
imprimirRodada(4):- write("Quarta Rodada!"), nl.
imprimirRodada(5):- write("Quinta Rodada!"), nl.

chutar(CHUTE, CHUTE, FOIGOL):- FOIGOL = 1.
chutar(CHUTE, _, FOIGOL):- FOIGOL = 0.

verificaGol(0):-
    write("ERROOOOU!!!"), nl.

verificaGol(1):-
    write("GOOOOOOOL!!!"), nl.

opcoesChute():-
    write("Selecione um local de chute:"), nl,
    write("1 - Esquerda Baixo"), nl,
    write("2 - Esquerda Cima"), nl,
    write("3 - Meio Baixo"), nl,
    write("4 - Meio Cima"), nl,
    write("5 - Direita Baixo"), nl,
    write("6 - Direita Cima"), nl.
    
% (Local do chute (opcoes Chute), foi Gol (1 sim 0 não))
imprimirPuloGoleiro(1, 1):- golBaixoEsquerda().
imprimirPuloGoleiro(1, 0):- errouBaixoEsquerda().
imprimirPuloGoleiro(2, 1):- golCimaEsquerda(). 
imprimirPuloGoleiro(2, 0):- errouCimaEsquerda().
imprimirPuloGoleiro(3, 1):- golBaixoMeio(). 
imprimirPuloGoleiro(3, 0):- errouBaixoMeio().
imprimirPuloGoleiro(4, 1):- golCimaMeio(). 
imprimirPuloGoleiro(4, 0):- errouCimaMeio().
imprimirPuloGoleiro(5, 1):- golBaixoDireita(). 
imprimirPuloGoleiro(5, 0):- errouBaixoDireita().
imprimirPuloGoleiro(6, 1):- golCimaDireita(). 
imprimirPuloGoleiro(6, 0):- errouCimaDireita().

golBaixoEsquerda():-
    write("---------------------------"), nl,
    write("|   |  O  |               |"), nl,
    write("|    |_|_|                |"), nl,
    write("|      |                  |"), nl,
    write("|  O  | |                 |"), nl.

errouBaixoEsquerda():-
    write("---------------------------"), nl,
    write("| |  O  |                 |"), nl,
    write("|  |_|_|                  |"), nl,
    write("|    |                    |"), nl,
    write("|   X |                   |"), nl.

golCimaEsquerda():-
    write("---------------------------"), nl,
    write("| O |  O  |               |"), nl,
    write("|    |_|_|                |"), nl,
    write("|      |                  |"), nl,
    write("|     | |                 |"), nl.

errouCimaEsquerda():-
    write("---------------------------"), nl,
    write("|  X O  |                 |"), nl,
    write("|  |_|_|                  |"), nl,
    write("|    |                    |"), nl,
    write("|   | |                   |"), nl.

golBaixoMeio():-
    write("---------------------------"), nl,
    write("|        |  O  |          |"), nl,
    write("|         |_|_|           |"), nl,
    write("|           |             |"), nl,
    write("|          |O|            |"), nl.

errouBaixoMeio():-
    write("---------------------------"), nl,
    write("|        |  O  |          |"), nl,
    write("|         |_|_|           |"), nl,
    write("|           |             |"), nl,
    write("|          X |            |"), nl.

golCimaMeio():-
    write("---------------------------"), nl,
    write("|        O  |  O  |       |"), nl,
    write("|            |_|_|        |"), nl,
    write("|              |          |"), nl,
    write("|             | |         |"), nl.

errouCimaMeio():-
    write("---------------------------"), nl,
    write("|        |  x  |          |"), nl,
    write("|         |_|_|           |"), nl,
    write("|           |             |"), nl,
    write("|          | |            |"), nl.

golBaixoDireita():-
    write("---------------------------"), nl,
    write("|              |  O  |    |"), nl,
    write("|               |_|_|     |"), nl,
    write("|                 |       |"), nl,
    write("|                | |   O  |"), nl.

errouBaixoDireita():-
    write("---------------------------"), nl,
    write("|                |  O  |  |"), nl,
    write("|                 |_|_|   |"), nl,
    write("|                   |     |"), nl,
    write("|                  | X    |"), nl.

golCimaDireita():-
    write("---------------------------"), nl,
    write("|              |  O  |  O |"), nl,
    write("|               |_|_|     |"), nl,
    write("|                 |       |"), nl,
    write("|                | |      |"), nl.

errouCimaDireita():-
    write("---------------------------"), nl,
    write("|                |  O  X  |"), nl,
    write("|                 |_|_|   |"), nl,
    write("|                   |     |"), nl,
    write("|                  | |    |"), nl.

main:-
    executaMenu().
