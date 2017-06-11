INT n;

MAIN {
    INT numLido, menor;

    print "Insira quantos quer ler: \n";
    read n;

    print "De seguida insira os valores\n";
    read numLido;
    menor = numLido;

    WHILE (n > 1) {
        read numLido;
        if(numLido < menor) {
            menor = numLido;
        }
        n = n - 1;
    }

    print "O menor numero introduzido foi: ";
    print menor;
}