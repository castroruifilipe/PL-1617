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
	criaHTML(transacoes);
	geraNEntradasPorData(transacoes);
	print("");
	geraLocaisSaida(transacoes);
	print("");
	valorGastoParques(transacoes);

}

function criaHTML(transacoes) {
	title = "Via Verde - Extrato mensal";
	img = "<body background = ""http://eidupont.scene7.com/is/image/eidupont/DBI_Corian_Color%20Chip_Whipped%20Cream-690x345"" bgproperties=""fixed"">";
	enc = "<html> <head> <meta charset = 'UTF-8'/>" img "<title>" title "</title> </head>";
	print enc > "index.html";
	cabecalho = "<body> <h1>" title "</h1>";
	print cabecalho > "index.html";
	fmt = "<li> <a href='%s'> %s </a></li>\n";
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