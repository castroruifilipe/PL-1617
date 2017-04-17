%{
	#include <string.h>
	#include <glib.h>
	#include <unistd.h>
	#include <stdio.h>

	GTree * nomesTree;
	char * recebido;
	int counter = 1;
%}

%option noyywrap
%x NOME

%%
	char * nome[20];
	char * nomeTodo;
	char * nomesLinha[128];
	int i = 0;
	int n = 0;
	gpointer aux = NULL;

<INITIAL>author\ =\ \{   {
	BEGIN NOME;
}

<NOME>\ and\     {
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
		if (strcmp(nomesLinha[j],recebido) == 0) {
			for (int k = 0; k <= n; k++) {
				if (k != j) {
					if ((aux = g_tree_lookup(nomesTree,nomesLinha[k])) != NULL) {
        				(*(int *)aux)++;
    				} else {
						int *j = (int *)malloc(sizeof(int));
						*j = 1;
						g_tree_insert(nomesTree, nomesLinha[k], j);
					}
				}
			}
			j = n+1; //Para sair do ciclo
		}
	}
	n = 0;
	BEGIN INITIAL;
}

<NOME>[A-Z][a-zA-Zá-úãõÁ-ÚâêôÂÊÔç ]+\,   {
	nome[i] = strdup(yytext);
	i++;
}


<NOME>\ ?[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç]+\.?	{
	nome[i] = strdup(yytext);
	i++; 
}

<NOME>\ [0-9]+	{
	nome[i] = strdup(yytext);
	i++; 
}

<*>.|\n         {   ;   }

%%

gboolean print_name(gpointer k, gpointer v, gpointer d) {
	fprintf(yyout,"\tColaborador%d [label=\"%s\"];\n",counter,k);
	int vezes = *(int *)v;
	if (vezes > 1) {
		fprintf(yyout,"\tAutor -> Colaborador%d [label=\"Colaborou %d vezes\"];\n", counter, vezes);
	} else {
		fprintf(yyout,"\tAutor -> Colaborador%d [label=\"Colaborou %d vez\"];\n", counter, vezes);
	}
	counter++;
	return FALSE;
}

void geraGrafo() {
	fprintf(yyout,"digraph Colaboradores {\n");
	fprintf(yyout,"\tAutor [shape=polygon,sides=6,peripheries=2,color=lightblue,label=\"%s\"];\n",recebido);
	g_tree_foreach(nomesTree, print_name, NULL);

	fprintf(yyout,"}");
}

int main(int argc, char** argv) {
	if (argc > 2) {
		yyin = fopen(argv[1],"r");
		recebido = strdup(argv[2]);
		for(int i=3; i<argc; i++){
			strcat(recebido," ");
			strcat(recebido,strdup(argv[i]));
		}
	}

	nomesTree = g_tree_new((GCompareFunc)strcmp); 

	yylex();
	yyout = fopen("grafo.dot","w+");
	geraGrafo();

	return 0;
}