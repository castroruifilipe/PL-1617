MAIN {
	INT a,b,c,d;
	
	print "Insira um valor: \n";
    read a;
	print "Insira um valor: \n";
    read b;
    print "Insira um valor: \n";
    read c;
    print "Insira um valor: \n";
    read d;
	
    IF ((a == b) & (b == c) & (c == d)) {
		PRINT "É um Quadrado\n";
	}
	ELSE {
		PRINT "Os lados não correspondem a um quadrado\n";
	}
}