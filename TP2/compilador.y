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

	typedef struct nodo {
		int indice;
		int colunas;
	} *Nodo;

	GTree *variaveis;
	GTree *varGlobais;
	GTree *funcoes;
	char *erro;
	Nodo aux = NULL;
	Nodo e;
	int count;
	int local;
	int countCond = 0;
	char *funcaoAtual;
	int * auxFuncoes;
%}

%union {
	char *valString;
	int valInt;
	InfoVar infoV;
}

%token <valString> MAIN IF ELSE WHILE READ PRINT RETURN FUNCAO INT VALOR DESIGNACAO STRING

%type <valString> Programa MainFunc Funcoes Instrucoes Instrucao Decls Decl DeclsVar DeclVar Init Expr Termo Fator Cond Funcao Return
%type <infoV> Var


%%
Programa : Decls Instrucoes Funcoes MainFunc		{	asprintf(&$$, "pushi 0\n"
																	  "pushi 0\n"
																	  "%s%s%s%s", $1, $2, $4, $3);
														printf("%s", $$);		 	}
	   	 ;


Funcoes : Funcoes Funcao					{	asprintf(&$$, "%s"
															  "%s",$1,$2);	}
	  	|									{	$$ = "";	}
	  	;
	  
Funcao : FUNCAO DESIGNACAO '(' ')'			{	count = 0;
												local = 1;
												funcaoAtual = strdup($2);
												variaveis = g_tree_new((GCompareFunc)strcmp);
												int *func = (int *)malloc(sizeof(int));
												*func = 0;
												g_tree_insert(funcoes,$2,func);
											}
	     '{' Decls Instrucoes Return '}'	{	asprintf(&$$,"func_%s:\n"
															  "nop\n"
															  "%s"
															  "%s"
															  "%s",$2,$7,$8,$9);
		 									}
		| FUNCAO DESIGNACAO '('DESIGNACAO')' {	count = 0;
												local = 1;
												funcaoAtual = strdup($2);
												variaveis = g_tree_new((GCompareFunc)strcmp);
												int *func = (int *)malloc(sizeof(int));
												*func = 1;
												g_tree_insert(funcoes,$2,func);
												Nodo n = (Nodo)malloc(sizeof(struct nodo));
												n->indice = count;
												n->colunas = 0;
												g_tree_insert(variaveis, $4, n);
												count++;
		}
		'{' Decls Instrucoes Return '}'	{	asprintf(&$$,"func_%s:\n"
															  "nop\n"
															  "pushg 1\n"
															  "%s"
															  "%s"
															  "%s",$2,$8,$9,$10);
										}
	   ;

Return : RETURN Expr ';'	{	asprintf(&$$, "%s"
											  "storeg 0\n"
											  "return", $2);
							}
	   ;


MainFunc : MAIN 						{	variaveis = g_tree_new((GCompareFunc)strcmp);
											count = 0;
											local = 1;
											funcaoAtual = strdup("MAIN");
										}

		'{' Decls Instrucoes '}'		{	asprintf(&$$, "start\n"
														  "%s"
														  "%s"
														  "stop\n", $4, $5);
										}
	     ;


Decls :	Decls Decl				{	asprintf(&$$, "%s%s", $1, $2);	}	
		|						{	$$ = "";	}
	  ;

Decl : INT DeclsVar ';'			{	$$ = $2;	}
     ;

DeclsVar : DeclVar						{	$$ = $1;	}                      
	     | DeclVar ',' DeclsVar			{	asprintf(&$$, "%s%s", $1, $3);	}
	     ;

DeclVar : DESIGNACAO Init								{	if (local == 0) { 					// contexto global
																if((aux = (Nodo)g_tree_lookup(varGlobais,$1)) != NULL){
																	asprintf(&erro, "Variável %s já declarada", $1);
																	yyerror(erro);
																} else {
																	Nodo n = (Nodo)malloc(sizeof(struct nodo));
																	n->indice = count;
																	n->colunas = 0;
																	g_tree_insert(varGlobais, $1, n);
																	count++;
																	asprintf(&$$, "%s", $2);
																}
															} else {
																if (g_tree_lookup(variaveis, $1) != NULL) {
																	asprintf(&erro, "Variável %s já declarada na função %s", $1, funcaoAtual);
																	yyerror(erro);
																} else {
																	Nodo n = (Nodo)malloc(sizeof(struct nodo));
																	n->indice = count;
																	n->colunas = 0;
																	g_tree_insert(variaveis, $1, n);
																	count++;
																	asprintf(&$$, "%s", $2);
																}
															}
														}
	    | DESIGNACAO '[' VALOR ']'						{	if (local == 0) { 					// contexto Global
																if((aux = (Nodo)g_tree_lookup(varGlobais,$1)) != NULL){
																	asprintf(&erro, "Variável %s já declarada", $1);
																	yyerror(erro);
																} else {
																	if (atoi($3) < 1) {
																		asprintf(&erro, "Dimensão %s do array %s inválida", $3, $1);
																		yyerror(erro);	
																	} else {
																		Nodo n = (Nodo)malloc(sizeof(struct nodo));
																		n->indice = count;
																		n->colunas = 0;
																		g_tree_insert(varGlobais, $1, n); 
																		count += atoi($3);
																		asprintf(&$$, "pushn %s\n", $3);
																	}
																}
															} else {						// Está numa função
																if (g_tree_lookup(variaveis, $1) != NULL) {
																	asprintf(&erro, "Variável %s já declarada na função %s", $1, funcaoAtual);
																	yyerror(erro);
																} else {
																	Nodo n = (Nodo)malloc(sizeof(struct nodo));
																	n->indice = count;
																	n->colunas = 0;
																	g_tree_insert(variaveis, $1, n);
																	count += atoi($3);
																	asprintf(&$$, "pushn %s\n", $3);
																}
															}
														}

	    | DESIGNACAO '[' VALOR ']' '[' VALOR ']'		{	if (local == 0) { 					// Contexto Global
																if((aux = (Nodo)g_tree_lookup(varGlobais,$1)) != NULL){
																	asprintf(&erro, "Variável %s já declarada", $1);
																	yyerror(erro);
																} else {
																	if (atoi($3) < 1 || atoi($6) < 1) {
																		asprintf(&erro, "Dimensões do array bidimensional %s inválidas", $1);
																		yyerror(erro);	
																	} else {
																		Nodo n = (Nodo)malloc(sizeof(struct nodo));
																		n->indice = count;
																		n -> colunas =  atoi($6);
																		g_tree_insert(varGlobais, $1, n);
																		count += (atoi($3) * atoi($6));
																		asprintf(&$$, "pushn %d\n", atoi($3) * atoi($6));
																	}
																}
															} else {						// Está numa função
																if (g_tree_lookup(variaveis, $1) != NULL) {
																	asprintf(&erro, "Variável %s já declarada na função %s", $1, funcaoAtual);
																	yyerror(erro);
																} else {
																	Nodo n = (Nodo)malloc(sizeof(struct nodo));
																		n->indice = count;
																		n -> colunas =  atoi($6);
																		g_tree_insert(variaveis, $1, n); 
																		count += (atoi($3) * atoi($6));
																		asprintf(&$$, "pushn %d\n", atoi($3) * atoi($6));
																}
															}
														}
	    ;

Init : '=' Expr			{	$$ = $2;	}
     |					{	$$ = "pushi 0\n";	}
     ;


Instrucoes : Instrucoes Instrucao						{	asprintf(&$$, "%s%s", $1, $2);	}
	       |											{	$$ = "";	}
	       ;

Instrucao : Var '=' Expr ';'												{	asprintf(&$$, "%s%s%s", $1.prep_atribuicoes, $3, $1.atribuicoes);	}
	      | IF '(' Cond ')' '{' Instrucoes '}'								{	asprintf(&$$, "%s"
		  																					  "jz fim_if_%d\n"
																							  "%s"
																							  "fim_if_%d: \n", $3, countCond, $6, countCond);
																				countCond++;
																			}
	      | IF '(' Cond ')' '{' Instrucoes '}' ELSE '{' Instrucoes '}'		{	asprintf(&$$, "%s"
		  																					  "jz else_%d\n"
																							  "%s"
																							  "jump fim_if_%d: \n"
																							  "else_%d:\n"
																							  "%s"
																							  "fim_if_%d: \n", $3, countCond, $6, countCond, countCond, $10, countCond);
																				countCond++;
																			}
	      | WHILE '(' Cond ')' '{' Instrucoes '}'							{	asprintf(&$$, "while_%d: \n"
		  																					  "%s"
																							  "jz fim_while_%d\n"
		  																					  "%s"
																							  "jump while_%d\n"
																							  "fim_while_%d: \n", countCond, $3, countCond, $6, countCond, countCond);
																				countCond++;
																			}
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
	      | DESIGNACAO '(' ')' ';'											{	if((auxFuncoes = (int *)g_tree_lookup(funcoes,$1)) != NULL){
			  																		if(*auxFuncoes == 0){
			  																			asprintf(&$$, "pusha func_%s\n"
		  																							  "call\n"
																									  "nop\n", $1);
																					  }
																					  else {
																						  asprintf(&erro, "Número de argumentos da função %s inválido", $1);
																						  yyerror(erro);
																					  }
		  																		} else {
																					asprintf(&erro, "Função %s não declarada", $1);
																					yyerror(erro);
									 											}
																			}

		 | DESIGNACAO '(' Expr ')' ';'										{	if((auxFuncoes = (int *)g_tree_lookup(funcoes,$1)) != NULL){
			  																		if(*auxFuncoes == 1){
			  																			asprintf(&$$, "%s"
																						  			  "storeg 1\n"
																						  			  "pusha func_%s\n"
		  																							  "call\n"
																									  "nop\n", $3, $1);
																					  }
																					  else {
																						  asprintf(&erro, "Número de argumentos da função %s inválido", $1);
																						  yyerror(erro);
																					  }
		  																		} else {
																					asprintf(&erro, "Função %s não declarada", $1);
																					yyerror(erro);
									 											}
																		 }					
	      ;

Cond : Expr '>' '=' Expr		{	asprintf(&$$, "%s%ssupeq\n", $1, $4);	}
     | Expr '<' '=' Expr		{	asprintf(&$$, "%s%sinfeq\n", $1, $4);	}
     | Expr '=' '=' Expr		{	asprintf(&$$, "%s%sequal\n", $1, $4);	}
     | Expr '!' '=' Expr		{	asprintf(&$$, "%s%sequal\nnot\n", $1, $4);	}
     | Expr '<' Expr			{	asprintf(&$$, "%s%sinf\n", $1, $3);	}
     | Expr '>' Expr			{	asprintf(&$$, "%s%ssup\n", $1, $3);	}
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
	  | DESIGNACAO '(' ')'		{	if((auxFuncoes = (int *)g_tree_lookup(funcoes,$1)) != NULL){
			  							if(*auxFuncoes == 0){
											asprintf(&$$,"pusha func_%s\n"
														 "call\n"
														 "nop\n"
														 "pushg 0\n",$1);
										}
										else {
											asprintf(&erro, "Argumento da função %s não é válido", $1);
											yyerror(erro);
										}
	  								} else {
										asprintf(&erro, "Função %s não declarada", $1);
										yyerror(erro);
									  }
								}
	  | DESIGNACAO '(' Expr ')' {	if((auxFuncoes = (int *)g_tree_lookup(funcoes,$1)) != NULL){
			  							if(*auxFuncoes == 1){
											asprintf(&$$,"%s"
             											 "storeg 1\n"
														 "pusha func_%s\n"
														 "call\n"
														 "nop\n"
														 "pushg 0\n",$3,$1);
										}
										else {
											asprintf(&erro, "Argumento da função %s não é válido", $1);
											yyerror(erro);
										}
	  								} else {
										asprintf(&erro, "Função %s não declarada", $1);
										yyerror(erro);
									  }

	  							}
	  ;

Var : DESIGNACAO								{	if(local == 0) {					// contexto Global
														if ((aux = (Nodo)g_tree_lookup(varGlobais, $1)) == NULL){
															asprintf(&erro, "Variável %s não declarada", $1);
															yyerror(erro);
														}
														else {
															asprintf(&$$.instrucoes, "pushg %d\n", aux->indice);
															asprintf(&$$.atribuicoes, "storeg %d\n", aux->indice);
															$$.prep_atribuicoes = "";
														}
													}
													else {					// contexto local
														if ((aux = (Nodo)g_tree_lookup(variaveis, $1)) != NULL){
															asprintf(&$$.instrucoes, "pushl %d\n", aux->indice);
															asprintf(&$$.atribuicoes, "storel %d\n", aux->indice);
															$$.prep_atribuicoes = "";
														} else {
															if((aux = (Nodo)g_tree_lookup(varGlobais, $1)) != NULL){
																asprintf(&$$.instrucoes, "pushg %d\n", aux->indice);
																asprintf(&$$.atribuicoes, "storeg %d\n", aux->indice);
																$$.prep_atribuicoes = "";
															} else {
																asprintf(&erro, "Variável %s não declarada", $1);
																yyerror(erro);
															}
														}	
													}
												}

    | DESIGNACAO '[' Expr ']'					{	if(local == 0) {
														if ((aux = (Nodo)g_tree_lookup(varGlobais, $1)) == NULL){
															asprintf(&erro, "Variável %s não declarada", $1);
															yyerror(erro);
														}
														else {
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
														}
													}
													else {
														if ((aux = (Nodo)g_tree_lookup(variaveis, $1)) != NULL){
															asprintf(&$$.instrucoes,"pushfp\n"
																					   "pushi %d\n"
																					   "padd\n"
																					   "%s"
																					   "loadn\n" , aux->indice, $3);
                                                            asprintf(&$$.atribuicoes,"storen\n");
															asprintf(&$$.prep_atribuicoes,"pushfp\n"
                                                                                         "pushi %d\n"
                                                                                         "padd\n"
                                                                                         "%s" , aux->indice, $3);
														} else {
															if((aux = (Nodo)g_tree_lookup(varGlobais, $1)) != NULL){
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
																asprintf(&erro, "Variável %s não declarada", $1);
																yyerror(erro);
															}
														}
													}
												}

    | DESIGNACAO '[' Expr ']' '[' Expr ']'		{	if(local == 0) {
														if ((aux = (Nodo)g_tree_lookup(varGlobais, $1)) == NULL){
															asprintf(&erro, "Variável %s não declarada", $1);
															yyerror(erro);
														}
														else {
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
														}
													}
													else {
														if ((aux = (Nodo)g_tree_lookup(variaveis, $1)) != NULL){
															asprintf(&$$.instrucoes, "pushfp\n"
																					 "pushi %d\n"
																					 "padd\n"
																					 "%s"
																					 "pushi %d\n"
																					 "mul\n"
																					 "%s"
																					 "add\n"
																					 "loadn\n", aux->indice, $3, aux->colunas, $6);
															asprintf(&$$.atribuicoes, "storen\n");
															asprintf(&$$.prep_atribuicoes, "pushfp\n"
																					       "pushi %d\n"
																					       "padd\n"
																					       "%s"
																					       "pushi %d\n"
																					       "mul\n"
																					       "%s"
																					       "add\n", aux->indice, $3, aux->colunas, $6);
														} else {
															if((aux = (Nodo)g_tree_lookup(varGlobais, $1)) != NULL){
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
																asprintf(&erro, "Variável %s não declarada", $1);
																yyerror(erro);
															}
														}
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
	funcaoAtual = strdup("GLOBAL");
	local = 0;
	count = 2;
	varGlobais = g_tree_new((GCompareFunc)strcmp);
	funcoes = g_tree_new((GCompareFunc)strcmp);
	yyparse();
	return 0;
}