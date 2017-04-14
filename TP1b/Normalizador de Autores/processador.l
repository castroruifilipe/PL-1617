%{
	#include <string.h>
	#include <glib.h>
	#include <unistd.h>
	#include <stdio.h>

	GTree * nomesTree;
	char * recebido;
%}

%option noyywrap
%x NOME

%%
	char * nome[20];
	char nomeTodo[128];
	char * nomesLinha[128];
	int i = 0;
	int n = 0;

<INITIAL>author\ =\ \{   {
	BEGIN NOME;
}

<NOME>\ and\    {
	nomeTodo = strdup(nome[0]);
	for (int j = 1; j < i ; j++) {
		strcat(nomeTodo,nome[j]);
	}
	nomesLinha[n] = strdup(nomeTodo);
	n++;
	i = 0;
}

<NOME>\},       {
	nomeTodo = strdup(nome[0]);
	for (int j = 1; j < i; j++) {
		strcat(nomeTodo,nome[j]);
	}
	nomesLinha[n] = strdup(nomeTodo);
	i = 0;
	for (int j = 0; j <= n; j++) {
		if (strcmp(nomesLinha[n],recebido)) {
			for (int k = 0; k < n; k++) {
				if (k != j) {
					g_tree_insert(nomesTree, nomesLinha[k], NULL);
				}
			}
		}
	}
	n = 0;
	BEGIN INITIAL;
}

<NOME>[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç ]+\,   {
	nome[i] = strdup(yytext);
	i++;
}

<NOME>\ [A-Z].    {
	nome[i] = strdup(yytext);
	i++; 
}


<*>.|\n         {   ;   }

<*>ENDFILE      {   fclose(nomes);    }
%%

int main(int argc, char** argv) {
	if (argc == 3) {
		recebido = strdup(argv[2]);
		yyin = fopen(argv[1],"r");
	} else {
		return 1;
	}

	nomesTree = g_tree_new((GCompareFunc)strcmp); 
	yylex();

	return 0;
}