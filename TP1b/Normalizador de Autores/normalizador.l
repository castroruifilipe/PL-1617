%{
    #include <string.h>

%}

%option noyywrap
%x SUB

%%
    FILE * aux = fopen("aux.txt","w+");


author\ *=\ *    {   
        fprintf(aux,"author = ");
        BEGIN SUB;
}

editor\ *=\ *    {   
        fprintf(aux,"editor = ");
        BEGIN SUB;
}

<SUB>\{\\'a\}    {   fprintf(aux,"á");   }   
<SUB>\{\\'e\}    {   fprintf(aux,"é");   } 
<SUB>\{\\'i\}    {   fprintf(aux,"í");   } 
<SUB>\{\\'o\}    {   fprintf(aux,"ó");   } 
<SUB>\{\\'u\}    {   fprintf(aux,"ú");   } 

<SUB>\{\\'A\}    {   fprintf(aux,"Á");   }   
<SUB>\{\\'E\}    {   fprintf(aux,"É");   } 
<SUB>\{\\'I\}    {   fprintf(aux,"Í");   } 
<SUB>\{\\'O\}    {   fprintf(aux,"Ó");   } 
<SUB>\{\\'U\}    {   fprintf(aux,"Ú");   } 

<SUB>\{\\~a\}    {   fprintf(aux,"ã");   }   
<SUB>\{\\~o\}    {   fprintf(aux,"õ");   } 

<SUB>\{\\^a\}    {   fprintf(aux,"â");   }   
<SUB>\{\\^e\}    {   fprintf(aux,"ê");   }  
<SUB>\{\\^o\}    {   fprintf(aux,"ô");   }  

<SUB>\{\\^A\}    {   fprintf(aux,"Â");   }   
<SUB>\{\\^E\}    {   fprintf(aux,"Ê");   }  
<SUB>\{\\^O\}    {   fprintf(aux,"Ô");   }  

<SUB>\{\\c\{c\}\}    {   fprintf(aux,"ç");   } 

<SUB>[A-Z]\.\}   {   fprintf(aux,"%s",yytext);   }

<SUB>[A-Z]\.\ *  {   fprintf(aux,"%c. ",yytext[0]);  }

<SUB>\},        {
       fprintf(aux,"%s",yytext);
       BEGIN INITIAL;
}

<SUB>\",        {   
        fprintf(aux,"},");
        BEGIN INITIAL;
 }

<SUB>\"         {   fprintf(aux,"{");   }

<*>.|\n         {   fprintf(aux,"%s",yytext);   }

<*>ENDFILE      {   fclose(aux);    }
%%

int main(int argc, char** argv) {
    if(argc==2)
        yyin = fopen(argv[1],"r");
    yylex();

    return 0;
}