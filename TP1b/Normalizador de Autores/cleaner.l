%{
	#include <string.h>
%}

%option noyywrap
%x SUB

%%
<INITIAL>(?i:author|editor)[ ]*=[ ]*\{[ ]*\},\n		{	;				}

<INITIAL>(?i:author)[ ]*=[ ]*(\{|\"){1,}[ ]*    		{	fprintf(yyout, "author = {");
								BEGIN SUB;			}

<INITIAL>(?i:editor)[ ]*=[ ]*(\{|\"){1,}[ ]*  		{	fprintf(yyout, "editor = {");
								BEGIN SUB;			}

<SUB>[ ]*(\}|\"){1,},   					{	fprintf(yyout, "},");
								BEGIN INITIAL;			}

<SUB>([ ]and){2}					{	fprintf(yyout, " and");		}

<SUB>[ ]*\n[ ]*						{	fprintf(yyout, " "); 		}

<SUB>[ ]+						{	fprintf(yyout, " ");		}


<*>.|\n							{	fprintf(yyout, "%s", yytext);	}
%%

int main(int argc, char** argv) {
	if (argc == 2) {
		yyin = fopen(argv[1], "r");
	}

	yyout = fopen("limpo.txt", "w+");
	yylex();
	fclose(yyout);

	return 0;
}
