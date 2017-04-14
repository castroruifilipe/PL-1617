%{
    #include <string.h>

%}

%option noyywrap
%x LINHA COMPRESSAO

%%
    FILE * nomes = fopen("nomes.txt","w+");
    char * token;
    char * nome[128];
    int i=0;
    int c=0;

<INITIAL>author\ =\ \{ | 
editor\ =\ \{    {
        printf("%d\n",c);
        c++;   
        fprintf(nomes,"%s",yytext);
        BEGIN LINHA;
}


<LINHA>[0-9]+\ and\    {
      for(int j=0; j<i ; j++)
        {
            fprintf(nomes,"%s",nome[j]);
        }
        fprintf(nomes,"%s",yytext);
        i=0;
}

<LINHA>[0-9]+\},    {
      for(int j=0; j<i ; j++)
        {
            fprintf(nomes,"%s",nome[j]);
        }
        fprintf(nomes,"%s",yytext);
        i=0;
        BEGIN INITIAL;
}

<LINHA>\ *and\ *  {
        nome[i-1][strlen(nome[i-1])-1] = '\0';
        fprintf(nomes,"%s,",nome[i-1]);
        for(int j=0; j<i-1 ; j++)
        {
            fprintf(nomes," %c.",nome[j][0]);
        }

        fprintf(nomes," and ");
        i=0;
}

<LINHA>et\ al\.\ and\  {
        nome[i-1][strlen(nome[i-1])-1] = '\0';
        fprintf(nomes,"%s,",nome[i-1]);
        for(int j=0; j<i-1 ; j++)
        {
            fprintf(nomes," %c.",nome[j][0]);
        }
        fprintf(nomes," %s",yytext);
        i=0;
}

<LINHA>et\ al\.\},  {
        nome[i-1][strlen(nome[i-1])-1] = '\0';
        fprintf(nomes,"%s,",nome[i-1]);
        for(int j=0; j<i-1 ; j++)
        {
            fprintf(nomes," %c.",nome[j][0]);
        }
        fprintf(nomes," %s",yytext);
        i=0;
        BEGIN INITIAL;
}

<LINHA>[A-Z]\.\   {
        nome[i] = strdup(yytext);
        i++;
}


<LINHA>[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç]+\       {
        nome[i] = strdup(yytext);
        i++;
}

<LINHA>[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç]+\,        {
       for(int j=0; j<i ; j++)
        {
            fprintf(nomes,"%s",nome[j]);
        }
       fprintf(nomes,"%s",yytext);
       BEGIN COMPRESSAO; 
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


<COMPRESSAO>[A-Z]\.   {
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
        i=0;
        BEGIN LINHA;
}

<COMPRESSAO>\},      {
        fprintf(nomes,"%s",yytext);
        i=0;
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