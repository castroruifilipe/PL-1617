%{
    #include <string.h>
    #define RED   "\x1B[31m"
    #define RESET "\x1B[0m"

    int duvidas = 0;
%}

%option noyywrap

%%
    char* token;

"i aren't"                      { printf("i am not"); }

"shan't"|"sha'n't"              { printf("shall not"); }
"can't"                         { printf("can not"); }
"won't"                         { printf("will not"); }
"n't"                           { printf(" not"); }       // em todos os outros casos

"'m"                            { printf(" am"); }

"'re"                           { printf(" are"); }

"where'd"                       { printf("where did"); }

"y'all"                         { printf("you all"); }
"y'all'd"                       { printf("you all would"); }

"how'd"                         { printf("how did"); }
"how'd'y"                       { printf("how do you"); }
"'d've"                         { printf(" would have"); }
"'d"                            { printf(" [had,would]"); duvidas++; } // em todos os outros casos
"'ve"                           { printf(" have"); }

"how'll"                        { printf("how will"); }
"'ll"                           { printf(" [shall,will]"); duvidas++; } // em todos os outros casos

"let's"                         { printf("let us"); }
"it's"                          { printf("it [has,is]"); duvidas++; }
"so's"                          { printf("so [as,is]"); }
(?i:(i|you|she|he|it|we|they))\'s { 	token = strtok(yytext,"'");
					printf("%s [has,is,does]", yytext); duvidas++; }

([a-zA-Z]+\'[sS])		{ printf(" [has,is,does,possesive case]"); duvidas++; }

"o'clock"                       { printf("of the clock"); }
%%

int main(int argc, char **argv) {
    if (argc == 2) {
        yyin = fopen(argv[1], "r");
    }
    yylex();
    printf("%s---------------------------------------------------\n", RED);
    printf("\tVerifique casos de dúvida: %d casos\n", duvidas);
    printf("---------------------------------------------------%s\n", RESET);
    return 0;
}
