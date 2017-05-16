%{
	#include <stdlib.h>
%}

%option noyywrap
%option yylineno

%%
(?i:main)							{	return MAIN;		}

(?i:if)								{	return IF;			}

(?i:else)							{	return ELSE;		}

(?i:while)							{	return WHILE;		}

(?i:read)							{	return READ;		}

(?i:print)							{	return PRINT;		}

(?i:return)							{	return RETURN;		}

(?i:funcao)							{	return FUNCAO;		}

(?i:var)							{	return VAR;			}

[-]?[0-9]+							{	yylval.valString = strdup(yytext);
										return VALOR;						}

[-*/;\[\]=><!+\(\)\{\}%\|&]			{	return yytext[0];	}

[_a-zA-Z][_A-Za-z0-9]*				{	yylval.valString = strdup(yytext);
										return DESIGNACAO;					}

\"[^"]*\"							{	yylval.valString = strdup(yytext);
										return STRING;						}

(.|\n)								{	;					}
%%