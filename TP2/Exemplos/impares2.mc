Main {
    Int impares[10];
    Int quantos = 0, i;
    Int numLido;
   
    print "Insira 1 a 1 a sequência de números\n";
    read numLido;

    while ((numLido > 0) & (quantos < 10)) {

        if((numLido%2) == 0){ }
        else {
            impares[quantos] = numLido;
            quantos = quantos + 1;
        } 
        read numLido;
    }

    print "Inseriu ";
    print quantos;
    print " numeros impares\n";
    
    print impares[0];
    i = 1;

    while (i < quantos) {
        print "   :   ";
        print impares[i];
        i = i + 1;
    }   
}