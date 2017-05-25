INT a;

FUNCAO power() {
    INT d = a * a;
    return d;
}

MAIN {
    int b;
    print "Valor de a: \n";
    read a;
    print "a^2 = ";
    b = power();
    print b;
}