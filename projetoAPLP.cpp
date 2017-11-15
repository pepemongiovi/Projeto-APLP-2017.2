#include <bits/stdc++.h>

using namespace std;

const int ALTURA = 6, LARGURA = 11, MAX_SHIFT = 3, MIN_SHIFT = -3;

const int REDE = 0, TRAVE_CIMA = -1, TRAVE_LADO = -2, CABECA = 1, BRACO_ESQUERDO = 2, BRACO_DIREITO = 3, 
			CORPO = 4, PERNA_ESQUERDA = 5, PERNA_DIREITA = 6, BOLA = 7;
			
const int ESQUERDA_CIMA = 1, ESQUERDA_BAIXO = 2, MEIO_CIMA = 3, 
		MEIO_BAIXO = 4, DIREITA_CIMA = 5, DIREITA_BAIXO = 6;
		  
map<int, char> chars;

void buildMap()
{
	chars[BOLA] = 'X';
	chars[TRAVE_CIMA] = '_';
	chars[TRAVE_LADO] = '|';
	chars[REDE] = ' ';
	chars[CABECA] = 'O';
	chars[BRACO_ESQUERDO] = '\\';
	chars[BRACO_DIREITO] = '/';
	chars[CORPO] = '|';
	chars[PERNA_ESQUERDA] = '/';
	chars[PERNA_DIREITA] = '\\';
}
 
int trave[ALTURA][LARGURA] = {0};

void montarTrave(int shift)
{	
	for (int i = 0; i<LARGURA; i++)
	{
		trave[0][i] = TRAVE_CIMA;
	}
	
	for (int i = 1; i<ALTURA; i++)
	{
		trave[i][0] = TRAVE_LADO;
		trave[i][LARGURA-1] = TRAVE_LADO;
	}
	
	trave[1][5 + shift] = CABECA;
	trave[2][4 + shift] = BRACO_ESQUERDO;
	trave[2][5 + shift] = CORPO;
	trave[2][6 + shift] = BRACO_DIREITO;
	trave[3][5 + shift] = CORPO;
	trave[4][5 + shift] = CORPO;
	trave[5][4 + shift] = PERNA_ESQUERDA;
	trave[5][6 + shift] = PERNA_DIREITA;
}

void exibirTrave()
{
	for(int i = 0; i<ALTURA; i++)
	{
		cout<<"     ";
		for(int  j = 0; j<LARGURA; j++)
		{
			cout<<chars[trave[i][j]];
		}
		cout<<endl;
	}
	cout<<"-----------------------"<<endl;
	memset(trave, REDE, sizeof trave);
}

void exibirPlacar(int p1, int p2)
{
	cout<<"Jogador 1: "<<p1<<" gol(s)."<<endl;
	cout<<"Jogador 2: "<<p2<<" gol(s).\n"<<endl;
}

void exibirOpcoes()
{
	cout<<"1 - Esquerda cima"<<endl;
	cout<<"2 - Esquerda baixo"<<endl;
	cout<<"3 - Meio cima"<<endl;
	cout<<"4 - Meio baixo"<<endl;
	cout<<"5 - Direita cima"<<endl;
	cout<<"6 - Direita baixo\n"<<endl;
}

bool isGol(int localDoChute)
{	
	int i, j, min_i, max_i, min_j, max_j;
	
	if (localDoChute == ESQUERDA_CIMA) 
	{
		min_i = 0; max_i = 2; min_j = 0; max_j = 3;
	}
	else if (localDoChute == ESQUERDA_BAIXO) 
	{
		min_i = 3; max_i = 5; min_j = 0; max_j = 3;
	}
	else if (localDoChute == MEIO_CIMA) 
	{
		min_i = 0; max_i = 2; min_j = 4; max_j = 6;
	}
	else if (localDoChute == MEIO_BAIXO) 
	{
		min_i = 3; max_i = 5; min_j = 4; max_j = 6;
	}
	else if (localDoChute == DIREITA_CIMA) 
	{
		min_i = 0; max_i = 2; min_j = 7; max_j = 10;
	}
	else if (localDoChute == DIREITA_BAIXO)
	{
		min_i = 3; max_i = 5; min_j = 7; max_j = 10;
	}
	
	srand(time(NULL));
	i = min_i + (rand() % static_cast<int>(max_i - min_i + 1));
	j = min_j + (rand() % static_cast<int>(max_j - min_j + 1));
	
	if(trave[i][j]==REDE)
	{
		trave[i][j] = BOLA;
		return true;
	}
	else
	{
		trave[i][j] = BOLA;
		return false;
	}
}

void realizarJogada(int &p, int jogador)
{
	cout<<"JOGADOR "<<jogador<<endl;
	cout<<"=========="<<endl;
	montarTrave(0);
	exibirTrave();
	exibirOpcoes();
	
	int localDoChute;
	
	cout<<"Insira o numero correspondente ao local em que deseja chutar: ";
	cin >> localDoChute; cout<<endl;
	
	while(localDoChute<1 or localDoChute>6)
	{
		cout<<"Numero invalido!! Insira o numero correspondente ao local em que deseja chutar: ";
		cin >> localDoChute; cout<<endl;
	}
	
	srand(time(NULL));
	int shift = MIN_SHIFT + (rand() % static_cast<int>(MAX_SHIFT - MIN_SHIFT + 1));
	montarTrave(shift);
	
	if(isGol(localDoChute))
	{
		exibirTrave();
		cout<<"GOLL!!\n"<<endl;
		p++;
	}
	else
	{
		exibirTrave();
		cout<<"ERROU!!\n"<<endl;
	}	
}

int main()
{	
	buildMap();
	
	int p1 =0 , p2 = 0, rodadas = 0;
	
	while((rodadas<5 and abs(p1-p2<3)) or (rodadas>=5 and p1==p2))
	{
		cout<<"############"<<endl;
		cout<<"#RODADA "<<rodadas+1<<"!!#"<<endl;
		cout<<"############\n"<<endl;
		
		exibirPlacar(p1,p2);
		realizarJogada(p1, 1);
		realizarJogada(p2, 2);
		rodadas++;	
	}
	
	cout<< "FINAL DE PARTIDA!!\n"<<endl;
	exibirPlacar(p1,p2);
	if(p1>p2)
	{
		cout<< "O VENCEDOR FOI O JOGADOR 1!"<<endl;
	}
	else
	{
		cout<< "O VENCEDOR FOI O JOGADOR 2!"<<endl;
	}
}
