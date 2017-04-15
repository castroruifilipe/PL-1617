%{
	#include <string.h>
%}

%option noyywrap
%x SUB

%%
<INITIAL>(author|editor)[ ]=[ ]\{		{	fprintf(yyout, "%s", yytext);
											BEGIN SUB;						}
	
<SUB>\{?\\'a\}?							{	fprintf(yyout, "á");			}   
<SUB>\{?\\'e\}?							{	fprintf(yyout, "é");			} 
<SUB>\{?\\'i\}?							{	fprintf(yyout, "í");			} 
<SUB>\{?\\'o\}?							{	fprintf(yyout, "ó");			} 
<SUB>\{?\\'u\}?							{	fprintf(yyout, "ú");			} 

<SUB>\{?\\'A\}?							{	fprintf(yyout,"Á");				}   
<SUB>\{?\\'E\}?							{	fprintf(yyout,"É");				} 
<SUB>\{?\\'I\}?							{	fprintf(yyout,"Í");				} 
<SUB>\{?\\'O\}?							{	fprintf(yyout,"Ó");				} 
<SUB>\{?\\'U\}?							{	fprintf(yyout,"Ú");				} 

<SUB>\{?\\~a\}?							{	fprintf(yyout,"ã");				}   
<SUB>\{?\\~o\}?							{	fprintf(yyout,"õ");				} 

<SUB>\{?\\^a\}?							{	fprintf(yyout,"â");				}   
<SUB>\{?\\^e\}?							{	fprintf(yyout,"ê");				}  
<SUB>\{?\\^o\}?							{	fprintf(yyout,"ô");				}  

<SUB>\{?\\^A\}?							{	fprintf(yyout,"Â");				}   
<SUB>\{?\\^E\}?							{	fprintf(yyout,"Ê");				}  
<SUB>\{?\\^O\}?							{	fprintf(yyout,"Ô");				}  

<SUB>\{?\\c\{c\}\}?						{	fprintf(yyout,"ç");				}

<SUB>[A-Z]\.\},							{	fprintf(yyout,"%c.},",yytext[0]);
											BEGIN INITIAL;					}

<SUB>[A-Z]\.[ ]*						{	fprintf(yyout,"%c. ",yytext[0]);}

<SUB>\},        						{	fprintf(yyout, "%s", yytext);
	   										BEGIN INITIAL;					}

<SUB>[ ](do|da|de|das|dos)[ ]			{	fprintf(yyout, " ");			}

<*>.|\n         						{	fprintf(yyout, "%s", yytext);	}
%%

int main(int argc, char** argv) {
	if (argc == 2) {
		yyin = fopen(argv[1], "r");
	}

	yyout = fopen("formatado.txt", "w+");
	yylex();
	fclose(yyout);

	return 0;
}