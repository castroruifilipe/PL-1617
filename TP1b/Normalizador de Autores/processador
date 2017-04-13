%{
    #include <string.h>

%}

%option noyywrap
%x 

%%
    


<*>.|\n         {   fprintf(nomes,"%s",yytext);   }

<*>ENDFILE      {   fclose(nomes);    }
%%

int main(int argc, char** argv) {
    if(argc==2)
        yyin = fopen(argv[1],"r");
    yylex();
    return 0;
}