main {
    Int matriz[2][2];
    Int vetor[2];
    Int resultado[2];
    Int i, j, soma;

    print "Insira os valores da matriz\n";
    read matriz[0][0];
    read matriz[0][1];
    read matriz[1][0];
    read matriz[1][1];

    print "Insira os valores do vetor\n";
    read vetor[0];
    read vetor[1];

    i = 0;
    While (i < 2) {
        soma = 0;
        j = 0;
        While (j < 2) {
            soma = soma + matriz[i][j] * vetor[j];
            j = j + 1;
        } 
        resultado[i] = soma;
        i = i + 1;
    }

    print "O resultado é: \n";
    print "[";
    print resultado[0];
    print "]\n";
    print "[";
    print resultado[1];
    print "]";

}