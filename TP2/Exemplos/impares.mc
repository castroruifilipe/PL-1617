Main {

    Int quantos = 0;
    Int numLido;
   
    print "Insira 1 a 1 a sequência de números\n";
    read numLido;

    while (numLido > 0) {

        if((numLido%2) == 0){ 
            print "O numero ";
            print numLido; 
            print " não é ímpar\n";
        }
        else {
            print "O número ";
            print numLido; 
            print " é ímpar\n";
            quantos = quantos + 1;
        } 
        
        read numLido;
    }

    print "Inseriu ";
    print quantos;
    print " números ímpares"; 
}