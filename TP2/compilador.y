%{
	#include <stdio.h>
	#include <unistd.h>
	#include <string.h>
	#include <glib.h>
	#include <stdlib.h>

	GTree *designacoes;
	char *erro;
	int *indice;
	int count = 0;
	gpointer aux = NULL;

	typedef struct infovar {
		int indice;
		char *desig;

	}


%}

%union {
	char *valString;
	int valInt;
}

%token <valString> MAIN IF ELSE WHILE READ PRINT RETURN FUNCAO VAR VALOR DESIGNACAO STRING

%type <valString> Programa MainFunc Funcoes Instrucoes Instrucao Decls Decl DeclsVar DeclVar Expr Var Termo Fator
%type <valInt> Init


%%
Programa : Funcoes MainFunc								{	asprintf(&$$, "%s%s", $2, $1);
															printf("%s", $$);			 	}
	   	 ;


Funcoes : Funcoes Funcao
	  	|												{	$$ = "";	}
	  	;
	  
Funcao : FUNCAO DESIGNACAO '(' ')'
	   '{' Decls Instrucoes Return '}'
	   ;

Return : RETURN Expr ';'
	   ;

MainFunc : MAIN '{' Decls Instrucoes '}'				{	asprintf(&$$, "%s%s", $3, $4);	}
	     ;


Decls : Decls Decl										{	asprintf(&$$, "%s%s", $1, $2);	}
	  |													{	$$ = "";	}
	  ;

Decl : VAR DeclsVar ';'									{	$$ = $2;	}
     ;

DeclsVar : DeclVar                                      {	$$ = $1;	}                      
	     | DeclVar ',' DeclsVar							{	asprintf(&$$, "%s%s", $1, $3);	}
	     ;

DeclVar : DESIGNACAO Init								{	if (g_tree_lookup(designacoes, $1) != NULL) {
																asprintf(&erro, "Variável %s já declarada", $1);
																yyerror(erro);
															} else {
																indice = (int *)malloc(sizeof(int));
																*indice = count;
																g_tree_insert(designacoes, $1, indice);
																count++;
																asprintf(&$$, "pushi %d\n", $2);
															}
														}
	    | DESIGNACAO '[' VALOR ']'						{	if (g_tree_lookup(designacoes, $1) != NULL) {
																asprintf(&erro, "Variável %s já declarada", $1);
																yyerror(erro);
															} else {
																if (atoi($3) < 1) {
																	asprintf(&erro, "Dimensão %s do array %s inválida", $3, $1);
																	yyerror(erro);
																} else {
																	indice = (int *)malloc(sizeof(int));
																	*indice = count;
																	g_tree_insert(designacoes, $1, indice);
																	count += atoi($3);
																	asprintf(&$$, "pushn %s\n", $3);
																}
															}
														}
	    | DESIGNACAO '[' VALOR ']' '[' VALOR ']'		{	if (g_tree_lookup(designacoes, $1) != NULL) {
																asprintf(&erro, "Variável %s já declarada", $1);
																yyerror(erro);
															} else {
																if (atoi($3) < 1 || atoi($6) < 1) {
																	asprintf(&erro, "Dimensões do array bidimensional %s inválidas", $1);
																	yyerror(erro);
																} else {
																	indice = (int *)malloc(sizeof(int));
																	*indice = count;
																	g_tree_insert(designacoes, $1, indice);
																	count += (atoi($3) * atoi($6));
																	asprintf(&$$, "pushn %d\n", atoi($3) * atoi($6));
																}
															}
														}
	    ;

Init : '=' Expr											{	$$ = atoi($2);	}
     |													{	$$ = 0;	}
     ;


Instrucoes : Instrucoes Instrucao						{	asprintf(&$$, "start\n%s%sstop\n", $1, $2);	}
	       |											{	$$ = "";	}
	       ;

Instrucao : Var '=' Expr ';'												{	asprintf(&$$, "pushi %s\nstoreg %d\n", $3, (*(int *)aux));	}
	      | IF '(' Cond ')' '{' Instrucoes '}'
	      | IF '(' Cond ')' '{' Instrucoes '}' ELSE '{' Instrucoes '}'
	      | WHILE '(' Cond ')' '{' Instrucoes '}'
	      | PRINT Expr ';'													
	      | PRINT STRING ';'												{	asprintf(&$$, "pushs %s\nwrites\n", $2);	}
	      | READ Var ';'
	      | DESIGNACAO '(' ')' ';'
	      ;

Cond : Expr '>' '=' Expr
     | Expr '<' '=' Expr
     | Expr '=' '=' Expr
     | Expr '!' '=' Expr
     | Expr '<' Expr
     | Expr '>' Expr
     | Expr
     ;

Expr : Termo						{	$$ = $1;	}
	 | Expr '+' Termo				
     | Expr '-' Termo
     | Expr '|' Termo
     ;

Termo : Fator						{	$$ = $1;	}
	  | Termo '*' Fator
	  | Termo '/' Fator
	  | Termo '%' Fator
	  | Termo '&' Fator
	  ;

Fator : VALOR						{	$$ = $1;	}
	  | Var							{	$$ = $1;	}
	  | '(' Cond ')'
	  | DESIGNACAO '(' ')'
	  ;

Var : DESIGNACAO								{	if ((aux = g_tree_lookup(designacoes, $1)) != NULL) {
														asprintf(&$$, "pushg %d\n", (*(int *)aux));
													} else {
														asprintf(&erro, "Variável %s não declarada", $1);
														yyerror(erro);
													}
													
												}
    | DESIGNACAO '[' Expr ']'
    | DESIGNACAO '[' Expr ']' '[' Expr ']'
    ;
%%

#include "lex.yy.c"

int yyerror (char *s) {
	fprintf(stderr,"ERRO SINTÁTICO %s (Linha %d: | yychar: %d)\n", s, yylineno, yychar);
	return 1;
}

int main() {
	indice = (int *)malloc(sizeof(int));
	*indice = 0;
	designacoes = g_tree_new((GCompareFunc)strcmp);
	yyparse();
	return 0;
}