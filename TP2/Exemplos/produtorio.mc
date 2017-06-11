Int n = 5;

Main {
    Int resultado, numLido;
    Int i = 0;

    resultado = 1;

    print "Insira 1 a 1 os numeros que quer multiplicar\n";

    while (i < n) {
        read numLido;
        resultado = resultado * numLido;
        i = i + 1;
    }

    print "O produtorio é: ";
    print resultado;
    
}