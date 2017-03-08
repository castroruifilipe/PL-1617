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
	geraNEntradasPorData(transacoes);
	print("");
	geraLocaisSaida(transacoes);
	print("");
	valorGastoParques(transacoes);

}

function geraNEntradasPorData(transacoes) {
	for (i in transacoes) {
		entrada = transacoes[i]["DATA_ENTRADA"];
		if (entrada != "null") {
			entradas[entrada]++;
		}
	}
	for (i in entradas) {
		print (i " - " entradas[i]);
	}
}

function geraLocaisSaida(transacoes) {
	for (i in transacoes) {
		saida = transacoes[i]["SAIDA"];
		if (saida != "null") {
			saidas[saida] = 1;
		}
	}
	for (i in saidas) {
		print (i " - " saidas[i]);
	}
}

function valorGasto(transacoes) {
	valor = 0;
	for (i in transacoes) {
		preco = transacoes[i]["IMPORTANCIA"];
		desconto = transacoes[i]["VALOR_DESCONTO"] + 0.0;
		iva = (transacoes[i]["TAXA_IVA"] / 100) + 1;
		valor += (preco - desconto);
	}
	return valor;
}

function valorGastoParques(transacoes) {
	valor = 0;
	for (i in transacoes) {
		tipo = transacoes[i]["TIPO"];
		if (tipo ~ /[Pp]arque/) {
			preco = transacoes[i]["IMPORTANCIA"];
			desconto = transacoes[i]["VALOR_DESCONTO"] + 0.0;
			iva = (transacoes[i]["TAXA_IVA"] / 100) + 1;
			valor = (preco - desconto);
		}
	}
	return valor;
}