%{
	#include <stdio.h>
	#include <unistd.h>
	#include <string.h>
	#include <glib.h>

	GTree *designacoes;
	char *erro;
%}

%union {
	char *valString;
	int valInt;
}

%token <valString> MAIN IF ELSE WHILE READ PRINT RETURN FUNCAO VAR VALOR DESIGNACAO STRING

%type <valString> Decl DeclsVar DeclVar Expr
%type <valInt> Init


%%
Programa : Funcoes MainFunc
	   	 ;


Funcoes : Funcoes Funcao
	  	|
	  	;
	  
Funcao : FUNCAO DESIGNACAO '(' ')'
	   '{' Decls Instrucoes Return '}'
	   ;

Return : RETURN Expr ';'
	   ;

MainFunc : MAIN '{' Decls Instrucoes '}'
	     ;


Decls : Decls Decl
	  |
	  ;

Decl : VAR DeclsVar ';'									{	$$ = $2;	}
     ;

DeclsVar : DeclVar                                                            
	     | DeclVar ',' DeclsVar
	     ;

DeclVar : DESIGNACAO Init								{	if (g_tree_lookup(designacoes, $1) != NULL) {
																asprintf(&erro, "Variável %s já declarada", $1);
																yyerror(erro);
															} else {
																g_tree_insert(designacoes, $1, NULL);
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
																	g_tree_insert(designacoes, $1, NULL);
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
																	g_tree_insert(designacoes, $1, NULL);
																	asprintf(&$$, "pushn %d\n", atoi($3) * atoi($6));
																}
															}
														}
	    ;

Init : '=' Expr											{	$$ = atoi($2);	}
     |													{	$$ = 0;	}
     ;


Instrucoes : Instrucoes Instrucao
	       |
	       ;

Instrucao : Var '=' Expr ';'
	      | IF '(' Cond ')' '{' Instrucoes '}'
	      | IF '(' Cond ')' '{' Instrucoes '}' ELSE '{' Instrucoes '}'
	      | WHILE '(' Cond ')' '{' Instrucoes '}'
	      | PRINT Expr ';'
	      | PRINT STRING ';'
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

Expr : Termo
     | Expr '+' Termo
     | Expr '-' Termo
     | Expr '|' Termo
     ;

Termo : Fator
	  | Termo '*' Fator
	  | Termo '/' Fator
	  | Termo '%' Fator
	  | Termo '&' Fator
	  ;

Fator : VALOR
	  | Var
	  | '(' Cond ')'
	  | DESIGNACAO '(' ')'
	  ;

Var : DESIGNACAO
    | DESIGNACAO '[' VALOR ']'
    | DESIGNACAO '[' VALOR ']' '[' VALOR ']'
    ;
%%

#include "lex.yy.c"

int yyerror (char *s) {
	fprintf(stderr,"ERRO SINTÁTICO %s (Linha %d: | yychar: %d)\n", s, yylineno, yychar);
	return 1;
}

int main() {
	designacoes = g_tree_new((GCompareFunc)strcmp);
	yyparse();
	return 0;
}