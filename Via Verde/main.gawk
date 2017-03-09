BEGIN { 
	FS = "\n";
	RS = "<TRANSACCAO>";
	r = 0;
}

(NR == 1) {
	split($0, tmp, /<\/?NOME>/);
	dados["NOME"] = tmp[2];
	split($0, tmp, /<\/?NIF>/);
	dados["NIF"] = tmp[2];
	split($0, tmp, /<\/?MORADA>/);
	dados["MORADA"] = tmp[2];
	split($0, tmp, /<\/?CODIGO_POSTAL>/);
	dados["CODIGO_POSTAL"] = tmp[2];
	split($0, tmp, /<\/?MATRICULA>/);
	dados["MATRICULA"] = tmp[2];
}

(NR > 1) {	
	split($0, tmp, /[<>]/);
	for (c = 2; tmp[c] != "/TRANSACCAO"; c += 4) {
		transacoes[r][tmp[c]] = tmp[c + 1];
	}
	r++;
}

END {
	criaHTML(dados, transacoes);

}

function criaHTML(dados, transacoes) {
	title = "Via Verde - Extrato mensal";
	img = "<p><img src = http://www.meiosepublicidade.pt/wp-content/uploads/2015/10/ViaVerde_V_c-assin.jpg align=""right"" width=""708"" height=""414"" ></p>";
	enc = "<html> <head> <meta charset = 'UTF-8'/>" "<title>" title "</title> </head>";
	print enc > "index.html";
	cabecalho = "<body> <h1>" title "</h1>";
	fmt = "<li> <a href='%s'> %s </a></li>\n";
	
	print cabecalho > "index.html";
	print (img) > "index.html";
	print("<p>________________________________________</p>") > "index.html";
	print("<p><b>Dados do cliente</b></p>") > "index.html";
	for (i in dados) print (i dados[i]) > "index.html";
	print("<p>________________________________________</p>") > "index.html";
	print ("<p><b>Total gasto no mês: </b>" valorGasto(transacoes) " € </p>") > "index.html";
	print ("<p><b>Total gasto em parques: </b>" valorGastoParques(transacoes) " €</p>") > "index.html";
	print("<p>________________________________________</p>") > "index.html";
	printf (fmt, "entradasDia.html", "Entradas em cada dia do mês") > "index.html";
	print("<p></p>") > "index.html";
	printf (fmt, "listaSaidas.html", "Lista de saídas registadas") > "index.html";
	print ("</body></html>") > "index.html";
	print("<p>________________________________________</p>") > "index.html";
	
	print enc > "entradasDia.html";
	print cabecalho > "entradasDia.html";
	print (img) > "entradasDia.html";
	for (i in transacoes) {
		entrada = transacoes[i]["DATA_ENTRADA"];
		if (entrada != "null") {
			entradas[entrada]++;
		}
	}
	print ("<p><b>Data &emsp;&emsp;&emsp;&emsp;&emsp; Número de entradas</b></p>") > "entradasDia.html";
	for (i in entradas) {
		print ("<p>" i "&emsp;&emsp;&emsp;&emsp;&emsp;" entradas[i] "</p>") > "entradasDia.html";
	}
	print ("</body></html>") > "entradasDia.html";

	print enc > "listaSaidas.html";
	print cabecalho > "listaSaidas.html";
	print (img) > "listaSaidas.html";
	for (i in transacoes) {
		saida = transacoes[i]["SAIDA"];
		if (saida != "null") {
			saidas[saida] = 1;
		}
	}
	print ("<p><b>Local de saída</b></p>") > "listaSaidas.html";
	for (i in saidas) {
		print ("<p>" i "</p>") > "listaSaidas.html";
	}
	print ("</body></html>") > "listaSaidas.html";

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