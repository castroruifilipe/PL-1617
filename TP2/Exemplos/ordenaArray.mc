Int array[5];


FUNCAO ordena() {
    int i = 0;
    int j, menor, tmp;
    WHILE (i < 4) {
        j = i + 1;
        menor = i;
        WHILE (j < 5) {
            if (array[j] < array[menor]) {
                menor = j;
            }
            j = j + 1;
        }
        tmp = array[i];
        array[i] = array[menor];
        array[menor] = tmp;
        i = i + 1;
    }
    return 0;
}

Main {
    Int i = 0;
    print "Insira 1 a 1 os 5 numeros que pretende ordenar\n";

    while (i < 5) {
        read array[i];
        i = i + 1;
    }

    ordena();
    print array[0];
    i = 1;
    while (i < 5) {
        print "   ->   ";
        print array[i];
        i = i + 1;
    }  
}