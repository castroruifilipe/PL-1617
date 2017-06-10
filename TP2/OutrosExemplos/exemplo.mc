INT global[3];

MAIN {
    INT local[3];
    INT somaG = 0, somaL = 0;
    INT i;
    i=0;
    
    WHILE (i<3) {
        print "Valor de global indice ";
        print i;
        read global[i];
        somaG = somaG + global[i];


        print "Valor de local indice ";
        print i;
        read local[i];
        somaL = somaL + local[i];

        i = i + 1; 
    }

    print "Soma do global = ";
    print somaG;
    print "Soma do local = ";
    print somaL;

}
