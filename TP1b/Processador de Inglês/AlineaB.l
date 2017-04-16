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
    char * token;
    gpointer aux = NULL;


(to|can|could|shall|should|will|would|may|might)\ [a-zA-Z]+ {
    token = strtok(yytext," ");
    token = strtok(NULL," ,.\n?");
    verb = strdup(token);

    if ((aux = g_tree_lookup(verbos,verb)) != NULL) {
        (*(int *)aux)++;
    }
}

(?i:do|does|did)\ [a-zA-Z]+\ [a-zA-Z]+ {
    token = strtok(yytext," ");
    token = strtok(NULL," ");
    token = strtok(NULL," ,.\n?");
    verb = strdup(token);

    if ((aux = g_tree_lookup(verbos,verb)) != NULL) {
        (*(int *)aux)++;
    }
}

(to|can|could|shall|should|will|would|may|might)(\ not)?\ [a-zA-Z]+ {
    token = strtok(yytext," ");
    token = strtok(NULL," ");
    token = strtok(NULL," ,.\n?");
    verb = strdup(token);

    if ((aux = g_tree_lookup(verbos,verb)) != NULL) {
        (*(int *)aux)++;
    }
}

(to|can|could|shall|should|will|would|may|might)(n)?(\'t)?\ [a-zA-Z]+ {
    token = strtok(yytext," ");
    token = strtok(NULL," ,.\n?");
    verb = strdup(token);

    if ((aux = g_tree_lookup(verbos,verb)) != NULL) {
        (*(int *)aux)++;
    }
}


.|\n { ;}

%%

gboolean print_pair_HTML2(gpointer k, gpointer v, gpointer d) {
    if ((*(int *)v) > 0) {
        fprintf(yyout,"<tr><td>%s</td><td>%d</td></tr>", (char*)k, (*(int *)v));
    }
    return FALSE;
}

void criar_HTML() {
    char *title = "Verbos encontrados";

    fprintf(yyout,"<html> <head> <meta charset = 'UTF-8'/> <center> <title> %s </title> </head>", title);
    fprintf(yyout,"<body> <h1> %s </h1>", title);
    fprintf(yyout,"<body background=\"https://previews.123rf.com/images/etiamos/etiamos1206/etiamos120600134/14180784-Background-made-of-papers-with-colorful-letters-Stock-Vector-school-background-doodle.jpg\">");

    fprintf(yyout, "<table border=\"1\" width=\"500\" height=\"150\" bordercolor=\"green\" align=\"center\">");
    fprintf(yyout, "<tr><th>Verbo</th><th>Número de ocorrências</th></tr>");
    g_tree_foreach(verbos, print_pair_HTML2, NULL);

	fprintf(yyout,"</center></body></html>");

}

int compareInt (gconstpointer a, gconstpointer b) {
    int *aa = (int *)a;
    int *bb = (int *)b;
    int r;
    if (*aa == *bb) {
        return 0;
    } else {
        return (*aa - *bb);
    }
}

int main (int argc, char* argv[]) {
    verbos = g_tree_new((GCompareFunc)compareInt);
    char * verbo;
    char * buffer;
    size_t len;
    
    
    FILE * vrb = fopen("verbos.txt","r");
    int read;
    while((read = getline(&buffer,&len,vrb)) != -1){
            buffer[strlen(buffer) - 1]='\0';
            verbo = strdup(buffer);
            gint* j = g_slice_alloc(sizeof(gint));
            *j = 0;
            g_tree_insert(verbos,verbo,j);
    }

    yyin = fopen(argv[1],"r");
    yylex();

    yyout = fopen("index.html", "w+");
    criar_HTML();
    return 0;
}
