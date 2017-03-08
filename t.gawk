BEGIN { 
	FS = "\n";
	RS = "<TRANSACCAO>";
	r = 0;
}

(NR > 1) {	
	split($0, tmp, /[<>]/);
	for (c = 2; tmp[c] != "/TRANSACCAO"; c += 4) {
		transacoes[r][tmp[c]] = tmp[c + 1];
	}
	r++;
}

END {
	for (i in transacoes) {
		print (i);
		for (j in transacoes[i]) {
			print (j": " transacoes[i][j]);
		}
	}
}