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
    print "Insira 1 a 1 os 5 numeros que pretende ordenar";

    while (i < 5) {
        read array[i];
        i = i + 1;
    }

    ordena();
    i = 0;
    while (i < 5) {
        print array[i];
        print " -> ";
        i = i + 1;
    }  
}