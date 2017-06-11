Funcao power(x) {
    int res;

    res = x * x;

    return res;
}

Main {
    int numLido, res;

    print "Insira um número\n";
    read numLido;

    res = power(numLido);

    print "O quadrado do número é:  ";
    print res;
}