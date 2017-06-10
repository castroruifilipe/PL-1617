Int n = 5;
Int array[5];


FUNCAO inverte() {
    int i = 0;
    int j = n - 1;
    int tmp;

    WHILE (i < n/2) {
        tmp = array[i];
        array[i] = array[j];
        array[j] = tmp;
        i = i + 1;
        j = j - 1;
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

    inverte();
    i = 0;
    while (i < 5) {
        print array[i];
        print " -> ";
        i = i + 1;
    }  
}