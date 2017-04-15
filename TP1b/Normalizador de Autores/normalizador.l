%{
    #include <string.h>

%}

%option noyywrap
%x LINHA COMPRESSAO

%%
    char * token;
    char * nome[128];
    int i=0;

<INITIAL>author\ =\ \{ | 
editor\ =\ \{    { 
        fprintf(yyout,"%s",yytext);
        BEGIN LINHA;
}


<LINHA>[0-9]+\ and\    {
      for(int j=0; j<i ; j++)
        {
            fprintf(yyout,"%s",nome[j]);
        }
        fprintf(yyout,"%s",yytext);
        i=0;
}

<LINHA>[0-9]+\},    {
      for(int j=0; j<i ; j++)
        {
            fprintf(yyout,"%s",nome[j]);
        }
        fprintf(yyout,"%s",yytext);
        i=0;
        BEGIN INITIAL;
}

<LINHA>\ *and\ *  {
        nome[i-1][strlen(nome[i-1])-1] = '\0';
        fprintf(yyout,"%s,",nome[i-1]);
        for(int j=0; j<i-1 ; j++)
        {
            fprintf(yyout," %c.",nome[j][0]);
        }

        fprintf(yyout," and ");
        i=0;
}

<LINHA>et\ al\.\ and\  {
        nome[i-1][strlen(nome[i-1])-1] = '\0';
        fprintf(yyout,"%s,",nome[i-1]);
        for(int j=0; j<i-1 ; j++)
        {
            fprintf(yyout," %c.",nome[j][0]);
        }
        fprintf(yyout," %s",yytext);
        i=0;
}

<LINHA>et\ al\.\},  {
        nome[i-1][strlen(nome[i-1])-1] = '\0';
        fprintf(yyout,"%s,",nome[i-1]);
        for(int j=0; j<i-1 ; j++)
        {
            fprintf(yyout," %c.",nome[j][0]);
        }
        fprintf(yyout," %s",yytext);
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
            fprintf(yyout,"%s",nome[j]);
        }
       fprintf(yyout,"%s",yytext);
       BEGIN COMPRESSAO; 
}

<LINHA>[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç]+\},  {
        token = strtok(yytext,"}");
        nome[i] = strdup(token);
        fprintf(yyout,"%s,",nome[i]);
        for(int j=0; j<i ; j++)
        {
            fprintf(yyout," %c.",nome[j][0]);
        }

        fprintf(yyout,"},");
        i=0;

        BEGIN INITIAL;
}  


<COMPRESSAO>[A-Z]\.   {
        fprintf(yyout,"%c.",yytext[0]);
}

<COMPRESSAO>Á[a-z]+     {
        fprintf(yyout,"A.");
}

<COMPRESSAO>É[a-z]+     {
        fprintf(yyout,"A.");
}

<COMPRESSAO>Í[a-z]+     {
        fprintf(yyout,"A.");
}

<COMPRESSAO>Ó[a-z]+     {
        fprintf(yyout,"A.");
}

<COMPRESSAO>Ú[a-z]+     {
        fprintf(yyout,"A.");
}

<COMPRESSAO>Â[a-z]+     {
        fprintf(yyout,"A.");
}

<COMPRESSAO>Ê[a-z]+     {
        fprintf(yyout,"A.");
}

<COMPRESSAO>Û[a-z]+     {
        fprintf(yyout,"A.");
}

<COMPRESSAO>[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç]+   {
        fprintf(yyout,"%c.",yytext[0]);
}

<COMPRESSAO>\ and\       {
        fprintf(yyout,"%s",yytext);
        i=0;
        BEGIN LINHA;
}

<COMPRESSAO>\},      {
        fprintf(yyout,"%s",yytext);
        i=0;
        BEGIN INITIAL;
}

<*>.|\n         {   fprintf(yyout,"%s",yytext);   }
%%

int main(int argc, char** argv) {
    if(argc==2) {
        yyin = fopen(argv[1],"r");
    }

    yyout = fopen("normalizado.txt","w+");
    yylex();
    fclose(yyout);

    return 0;
}