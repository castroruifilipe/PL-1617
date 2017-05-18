%{
	#include <stdio.h>
	#include <unistd.h>
	#include <string.h>
	#include <glib.h>
	#include <stdlib.h>

	typedef struct infovar {
		char *instrucoes;
		char *atribuicoes;
		char *prep_atribuicoes;
	} InfoVar;

	typedef struct endereco {
		int indice;
		int colunas;
	} *Endereco;

	GTree *designacoes;
	char *erro;
	Endereco aux = NULL;
	Endereco e;
	int count = 1;
	int local = 0;

	

%}

%union {
	char *valString;
	int valInt;
	InfoVar infoV;
}

%token <valString> MAIN IF ELSE WHILE READ PRINT RETURN FUNCAO INT VALOR DESIGNACAO STRING

%type <valString> Programa MainFunc Funcoes Instrucoes Instrucao Decls Decl DeclsVar DeclVar Expr Termo Fator Cond
%type <valInt> Init
%type <infoV> Var


%%
Programa : Funcoes MainFunc				{	asprintf(&$$, "%s%s", $2, $1);
											printf("%s", $$);			 	}
	   	 ;


Funcoes : Funcoes Funcao
	  	|								{	$$ = "";	}
	  	;
	  
Funcao : FUNCAO DESIGNACAO '(' ')'
	     '{' Decls Instrucoes Return '}'
	   ;

Return : RETURN Expr ';'
	   ;


MainFunc : MAIN '{' Decls Instrucoes '}'		{	asprintf(&$$, "pushi 0\n"
																  "%s"
																  "start\n"
																  "%s"
																  "stop\n", $3, $4);	}
	     ;


Decls : Decls Decl				{	asprintf(&$$, "%s%s", $1, $2);	}
	  |							{	$$ = "";	}
	  ;

Decl : INT DeclsVar ';'			{	$$ = $2;	}
     ;

DeclsVar : DeclVar						{	$$ = $1;	}                      
	     | DeclVar ',' DeclsVar			{	asprintf(&$$, "%s%s", $1, $3);	}
	     ;

DeclVar : DESIGNACAO Init								{	if (g_tree_lookup(designacoes, $1) != NULL) {
																asprintf(&erro, "Variável %s já declarada", $1);
																yyerror(erro);
															} else {
																e = (Endereco)malloc(sizeof(struct endereco));
																e -> indice = count;
																e -> colunas = 0;
																g_tree_insert(designacoes, $1, e);
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
																	e = (Endereco)malloc(sizeof(struct endereco));
																	e -> indice = count;
																	e -> colunas = 0;
																	g_tree_insert(designacoes, $1, e);
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
																	e = (Endereco)malloc(sizeof(struct endereco));
																	e -> indice = count;
																	e -> colunas =  atoi($6);
																	g_tree_insert(designacoes, $1, e);
																	count += (atoi($3) * atoi($6));
																	asprintf(&$$, "pushn %d\n", atoi($3) * atoi($6));
																}
															}
														}
	    ;

Init : '=' Expr			{	$$ = atoi($2);	}
     |					{	$$ = 0;	}
     ;


Instrucoes : Instrucoes Instrucao						{	asprintf(&$$, "%s%s", $1, $2);	}
	       |											{	$$ = "";	}
	       ;

Instrucao : Var '=' Expr ';'												{	asprintf(&$$, "%s%s%s", $1.prep_atribuicoes, $3, $1.atribuicoes);	}
	      | IF '(' Cond ')' '{' Instrucoes '}'
	      | IF '(' Cond ')' '{' Instrucoes '}' ELSE '{' Instrucoes '}'
	      | WHILE '(' Cond ')' '{' Instrucoes '}'
	      | PRINT Expr ';'													{	asprintf(&$$, "%s"
		  																					  "writei\n", $2);
																			}								
	      | PRINT STRING ';'												{	asprintf(&$$, "pushs %s\n"
		  																					  "writes\n", $2);
																			}
	      | READ Var ';'													{	asprintf(&$$, "%s"
		  																					  "read\n"
																							  "atoi\n"
																							  "%s", $2.prep_atribuicoes, $2.atribuicoes);
																			}
	      | DESIGNACAO '(' ')' ';'
	      ;

Cond : Expr '>' '=' Expr		{	asprintf(&$$, "%s%ssupeq\n", $1, $4);	}
     | Expr '<' '=' Expr		{	asprintf(&$$, "%s%sinfeq\n", $1, $4);	}
     | Expr '=' '=' Expr		{	asprintf(&$$, "%s%sequal\n", $1, $4);	}
     | Expr '!' '=' Expr		{	asprintf(&$$, "%s%sequal\nnot\n", $1, $4);	}
     | Expr '<' Expr			{	asprintf(&$$, "%s%ssup\n", $1, $3);	}
     | Expr '>' Expr			{	asprintf(&$$, "%s%sinf\n", $1, $3);	}
     | Expr
     ;

Expr : Termo					{	$$ = $1;	}
	 | Expr '+' Termo			{	asprintf(&$$, "%s%sadd\n", $1, $3);	}
     | Expr '-' Termo			{	asprintf(&$$, "%s%ssub\n", $1, $3);	}
     | Expr '|' Termo			{	asprintf(&$$, "%s%sadd\n", $1, $3);	}
     ;

Termo : Fator					{	$$ = $1;	}
	  | Termo '*' Fator			{	asprintf(&$$, "%s%smul\n", $1, $3);	}	
	  | Termo '/' Fator			{	asprintf(&$$, "%s%sdiv\n", $1, $3);	}	
	  | Termo '%' Fator			{	asprintf(&$$, "%s%smod\n", $1, $3);	}	
	  | Termo '&' Fator			{	asprintf(&$$, "%s%smul\n", $1, $3);	}	
	  ;

Fator : VALOR					{	asprintf(&$$, "pushi %s\n", $1);	}
	  | Var						{	$$ = $1.instrucoes;	}
	  | '(' Cond ')'			{	$$ = $2;	}
	  | DESIGNACAO '(' ')'
	  ;

Var : DESIGNACAO								{	if ((aux = (Endereco)g_tree_lookup(designacoes, $1)) != NULL) {
														if (local == 0) {
															asprintf(&$$.instrucoes, "pushg %d\n", aux->indice);
															asprintf(&$$.atribuicoes, "storeg %d\n", aux->indice);
															$$.prep_atribuicoes = "";
														} else {
															// ????????????????????????????????????????????????????
														}
													} else {
														asprintf(&erro, "Variável %s não declarada", $1);
														yyerror(erro);
													}
												}
    | DESIGNACAO '[' Expr ']'					{	if ((aux = (Endereco)g_tree_lookup(designacoes, $1)) != NULL) {
														if (local == 0) {
															asprintf(&$$.instrucoes, "pushgp\n"
																					 "pushi %d\n"
																					 "padd\n"
																					 "%s"
																					 "loadn\n", aux->indice, $3);
															asprintf(&$$.atribuicoes, "storen\n");
															asprintf(&$$.prep_atribuicoes, "pushgp\n"
																					       "pushi %d\n"
																					       "padd\n"
																					       "%s", aux->indice, $3);
														} else {
															// ????????????????????????????????????????????????????
														}
													} else {
														asprintf(&erro, "Array %s não declarado", $1);
														yyerror(erro);
													}
												}
    | DESIGNACAO '[' Expr ']' '[' Expr ']'		{	if ((aux = (Endereco)g_tree_lookup(designacoes, $1)) != NULL) {
														if (local == 0) {
															asprintf(&$$.instrucoes, "pushgp\n"
																					 "pushi %d\n"
																					 "padd\n"
																					 "%s"
																					 "pushi %d\n"
																					 "mul\n"
																					 "%s"
																					 "add\n"
																					 "loadn\n", aux->indice, $3, aux->colunas, $6);
															asprintf(&$$.atribuicoes, "storen\n");
															asprintf(&$$.prep_atribuicoes, "pushgp\n"
																					       "pushi %d\n"
																					       "padd\n"
																					       "%s"
																					       "pushi %d\n"
																					       "mul\n"
																					       "%s"
																					       "add\n", aux->indice, $3, aux->colunas, $6);
														} else {
															// ????????????????????????????????????????????????????
														}
													} else {
														asprintf(&erro, "Array bidimensional %s não declarado", $1);
														yyerror(erro);
													}
												}
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