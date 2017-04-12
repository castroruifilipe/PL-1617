%{
    #include <string.h>
    #include <glib.h>
    #include <unistd.h>
    #include <stdio.h>

    GTree * verbos;
    
%}

%option noyywrap

%%

    char * verb;
    char * encontra = strdup("true");
    char * token;

to\ [a-zA-Z]+ |
can\ [a-zA-Z]+ |
could\ [a-zA-Z]+ |
shall\ [a-zA-Z]+ |
should\ [a-zA-Z]+ |
will\ [a-zA-Z]+ |
would\ [a-zA-Z]+ |
may\ [a-zA-Z]+ |
might\ [a-zA-Z]+ {
    token = strtok(yytext," ");
    token = strtok(NULL," ,.\n?");
    verb = strdup(token);

    if (g_tree_lookup(verbos,verb) != NULL) {
        g_tree_insert(verbos, verb, encontra);
    }
}

do\ [a-zA-Z]+\ [a-zA-Z]+ |
does\ [a-zA-Z]+\ [a-zA-Z]+ |
did\ [a-zA-Z]+\ [a-zA-Z]+ {
    token = strtok(yytext," ");
    token = strtok(NULL," ");
    token = strtok(NULL," ,.\n?");
    verb = strdup(token);

    if (g_tree_lookup(verbos,verb) != NULL) {
        g_tree_insert(verbos, verb, encontra);
    }
}


.|\n {;}

%%

gboolean print_pair(gpointer k, gpointer v, gpointer d) {
    printf("%s: %s\n", k, v);

    return FALSE;
}

void imprime_verbos() {

    g_tree_foreach(verbos, print_pair, NULL);
}

int main (int argc, char* argv[]) {
    
    verbos = g_tree_new((GCompareFunc)strcmp);
    char * verbo;
    char * inicial = strdup("false");
    char * buffer;
    size_t len;
    
    FILE * vrb = fopen("verbos.txt","r");
    int read;
    while((read = getline(&buffer,&len,vrb)) != -1){
            buffer[strlen(buffer) - 1]='\0';
            verbo = strdup(buffer);
            g_tree_insert(verbos,verbo,inicial);
    }
    yyin = fopen(argv[1],"r");
    yylex();
    imprime_verbos();



    return 0;
}

