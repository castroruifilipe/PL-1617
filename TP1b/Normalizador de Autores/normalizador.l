%{
    #include <string.h>

%}

%option noyywrap
%x LINHA COMPRESSAO

%%
    FILE * nomes = fopen("nomes.txt","w+");
    char * token;
    char * nome[20];
    int i=0;

<INITIAL>author\ =\ \{ |
editor\ =\ \{    {   
        fprintf(nomes,"%s",yytext);
        BEGIN LINHA;
}

<LINHA>[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç ]+\,        {
       fprintf(nomes,"%s",yytext);
       BEGIN COMPRESSAO; 
}

<LINHA>[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç]+\ and\  {
        token = strtok(yytext," ");
        nome[i] = strdup(token);
        fprintf(nomes,"%s,",nome[i]);
        for(int j=0; j<i ; j++)
        {
            fprintf(nomes," %c.",nome[j][0]);
        }

        fprintf(nomes," and ");
        i=0;
}

<LINHA>[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç]+\},  {
        token = strtok(yytext,"}");
        nome[i] = strdup(token);
        fprintf(nomes,"%s,",nome[i]);
        for(int j=0; j<i ; j++)
        {
            fprintf(nomes," %c.",nome[j][0]);
        }

        fprintf(nomes,"},");
        i=0;

        BEGIN INITIAL;
}


<LINHA>[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç]+\       {
        nome[i] = strdup(yytext);
        i++;
}


<COMPRESSAO>[A-Z].   {
        fprintf(nomes,"%c.",yytext[0]);
}

<COMPRESSAO>Á[a-z]+     {
        fprintf(nomes,"A.");
}

<COMPRESSAO>É[a-z]+     {
        fprintf(nomes,"A.");
}

<COMPRESSAO>Í[a-z]+     {
        fprintf(nomes,"A.");
}

<COMPRESSAO>Ó[a-z]+     {
        fprintf(nomes,"A.");
}

<COMPRESSAO>Ú[a-z]+     {
        fprintf(nomes,"A.");
}

<COMPRESSAO>Â[a-z]+     {
        fprintf(nomes,"A.");
}

<COMPRESSAO>Ê[a-z]+     {
        fprintf(nomes,"A.");
}

<COMPRESSAO>Û[a-z]+     {
        fprintf(nomes,"A.");
}

<COMPRESSAO>[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç]+   {
        fprintf(nomes,"%c.",yytext[0]);
}

<COMPRESSAO>\ and\       {
        fprintf(nomes,"%s",yytext);
        BEGIN LINHA;
}

<COMPRESSAO>\},      {
        fprintf(nomes,"%s",yytext);
        BEGIN INITIAL;
}

<*>.|\n         {   fprintf(nomes,"%s",yytext);   }

<*>ENDFILE      {   fclose(nomes);    }
%%

int main(int argc, char** argv) {
    if(argc==2)
        yyin = fopen(argv[1],"r");
    yylex();
    return 0;
}