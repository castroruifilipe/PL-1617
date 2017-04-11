%{
    #include <string.h>

    int duvidas = 0;
%}

%option noyywrap

%%
"i aren't"                      { printf("i am not"); }
"aren't"                        { printf("are not"); }      // em todos os outros casos

"shan't"|"sha'n't"              { printf("shall not"); }
"can't"                         { printf("can not"); }
"n't"                           { printf(" not"); }       // em todos os outros casos

"'m"                            { printf(" am"); }

"'re"                           { printf(" are"); }

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
"'s"                            { printf(" [has,is,does]"); duvidas++; }

"o'clock"                       { printf("of the clock"); }
%%

int main() {
    yylex();
    printf("Verifique casos de dúvida: %d casos", duvidas);
    return 1;
}