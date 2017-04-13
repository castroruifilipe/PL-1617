%{
    #include <string.h>

%}

%option noyywrap
%x LINHA COMPRESSAO

%%
    FILE * nomes = fopen("nomes.txt","w+");
    char * token;
    char * nomeNoN[20];
    char * nomeN[20];
    char nomeTodo[128];
    int i=0;
    int k=0;
    int n=0;

author\ =\ \{ |
editor\ =\ \{    {   
        fprintf(nomes,"%s",yytext);
        BEGIN LINHA;
}

        //Este deixava assim
<LINHA>[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç ]+\,        {
       fprintf(nomes,"%s",yytext);
       nomeN[k] = strdup(yytext);
       BEGIN COMPRESSAO; 
}

        //Aqui punha um que só apanhava a palavra (como temos na ultima ER da LINHA) e 
        // começava o estado NOME
<LINHA>[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç]+\ and\  {
        token = strtok(yytext," ");
        nomeNoN[i] = strdup(token);
        fprintf(nomes,"%s,",nomeNoN[i]);
        nomeTodo = strdup(token);
        for(int j=0; j<i ; j++)
        {
            fprintf(nomes," %c.",nomeNoN[j][0]);
            nomeNoN[j][1] = ".";
            nomeNoN[j][2] = "\0";
            strcat(nomeTodo," ");
            strcat(nomeTodo,nomeNoN[j]);
        }

        fprintf(nomes," and ");
        i=0;
}
        //Este já não ia ter
<LINHA>[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç]+\},  {
        token = strtok(yytext,"}");
        nomeNoN[i] = strdup(token);
        fprintf(nomes,"%s,",nomeNoN[i]);
        for(int j=0; j<i ; j++)
        {
            fprintf(nomes," %c.",nomeNoN[j][0]);
        }

        fprintf(nomes,"},");
        i=0;

        BEGIN INITIAL;
}

        //No estado nome tem uma ER igual a esta que também só copia para o array
        //o yytext. Depois se no Estado Nome encontrarmos a ER / and/ fazíamos o tratamento 
        //do array de strings e íamos para o Estado LINHA
        //Se no estado NOME encontrássemos a ER \} então fazíamos o tratamento do array de 
        //Strings e íamos para o estado INITIAL 
<LINHA>[a-zA-Zá-úãõÁ-ÚâêôÂÊÔç]+\       {
        nomeNoN[i] = strdup(yytext);
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