%{
	#include <stdio.h>
%}



#include "lex.yy.c"

int yyerror (char *s) {
	printf("%d: %s\n", yylineno, s);
	return 0;
}

int main() {
	yyparse();
	return 0;
}