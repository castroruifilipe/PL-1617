%{
    #include <string.h>
    #include <glib.h>
    #include <unistd.h>
    #include <stdio.h>

    GTree * verbos;
    FILE *index2;
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

.|\n {
    ;
}
%%

gboolean print_pair_HTML(gpointer k, gpointer v, gpointer d) {
    FILE *index = (FILE *)index2;
    char *value = (char *)v;
    char *key = (char *)k;
    if (strcmp(value,"true") == 0) {
        fprintf(index,"<p>%s</p>", key);
    }
    return FALSE;
}

void criar_HTML() {
    char *title = "Verbos encontrados";
    FILE *index = fopen("index.html", "w");
    index2 = index;
    fprintf(index,"<html> <head> <meta charset = 'UTF-8'/> <title> %s </title> </head>", title);
    fprintf(index,"<body> <h1> %s </h1>", title);
    fprintf(index,"<p>___________________________________________________________</p>");

    g_tree_foreach(verbos, print_pair_HTML, NULL);

    fprintf(index,"<p>___________________________________________________________</p>");
	fprintf(index,"</body></html>");

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

    criar_HTML();

    return 0;
}