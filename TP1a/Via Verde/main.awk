BEGIN {
	FS = "\n";
	RS = "<TRANSACCAO>";
	r = 0;
}

$0 ~ /[0-9],[0-9]/ {
	gsub(",", ".", $0);
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

function imprimeDadosCliente(dados, ficheiro) {
	print("<p><b>Dados do cliente</b></p>") > ficheiro;
	print("<p><b>NOME: </b>" dados["NOME"]"</p>") > ficheiro;
	print("<p><b>NIF: </b>" dados["NIF"]"</p>") > ficheiro;
	print("<p><b>MORADA: </b>" dados["MORADA"]) > ficheiro;
	print("<b>CODIGO POSTAL: </b>" dados["CODIGO_POSTAL"]"</p>") > ficheiro;
	print("<p><b>MATRÍCULA: </b>" dados["MATRICULA"]"</p>") > ficheiro;
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
	print("<p>___________________________________________________________</p>") > "index.html";
	imprimeDadosCliente(dados, "index.html");
	print("<p>___________________________________________________________</p>") > "index.html";
	imprimeValorGasto(transacoes, "index.html");
	imprimeValorGastoParques(transacoes, "index.html");
	print("<p>___________________________________________________________</p>") > "index.html";
	printf (fmt, "entradasDia.html", "Entradas em cada dia do mês") > "index.html";
	print("<p></p>") > "index.html";
	printf (fmt, "listaSaidas.html", "Lista de saídas registadas") > "index.html";
	print("<p>___________________________________________________________</p>") > "index.html";
	print ("</body></html>") > "index.html";	
	
	print enc > "entradasDia.html";
	print cabecalho > "entradasDia.html";
	print ("<h2>""Entradas por dia""</h2>") > "entradasDia.html";
	print("<p>___________________________________________________________</p>") > "entradasDia.html";
	print (img) > "entradasDia.html";
	imprimeNEntradasPorData(transacoes, "entradasDia.html");
	print("<p>___________________________________________________________</p>") > "entradasDia.html";
	print ("</body></html>") > "entradasDia.html";

	print enc > "listaSaidas.html";
	print cabecalho > "listaSaidas.html";
	print ("<h2>""Lista de saídas registadas""</h2>") > "listaSaidas.html";
	print("<p>___________________________________________________________</p>") > "listaSaidas.html";
	print (img) > "listaSaidas.html";
	imprimeLocaisSaida(transacoes, "listaSaidas.html");
	print("<p>___________________________________________________________</p>") > "listaSaidas.html";
	print ("</body></html>") > "listaSaidas.html";

}

function imprimeNEntradasPorData(transacoes, ficheiro) {
	title = "Via Verde - Extrato mensal";
	img = "<p><img src = http://www.meiosepublicidade.pt/wp-content/uploads/2015/10/ViaVerde_V_c-assin.jpg align=""right"" width=""708"" height=""414"" ></p>";
	enc = "<html> <head> <meta charset = 'UTF-8'/>" "<title>" title "</title> </head>";
	cabecalho = "<body> <h1>" title "</h1>";
	fmt = "<li> <a href='%s'> %s </a></li>\n";

	for (i in transacoes) {
		entrada = transacoes[i]["DATA_ENTRADA"];
		if (entrada != "null") {
			entradas[entrada]++;
		}
	}

	print ("<p><b>&emsp; Data &emsp;&emsp;&emsp;&emsp;&emsp; Número de entradas &emsp;&emsp;&emsp;&emsp;&emsp; Ver registos</b></p>") > ficheiro;
	for (data in entradas) {
		print("<p>" data "&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;" entradas[data] "&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;") > ficheiro;
		print("<a href='"data".html'> aqui </a></p>") > ficheiro;

		print enc > data".html";
		print cabecalho > data".html";
		print img > data".html";
		print "<h2>Data: " data "</h2>" > data".html";
		print "<p><b>Número total de registos: </b>" entradas[data] "</p>" > data".html";
		print("<p>___________________________________________________________</p>") > data".html";
	}

	for (i in transacoes) {
		imprimeTransacao(transacoes[i], transacoes[i]["DATA_ENTRADA"]".html");
	}
	
	for (data in entradas) {
		print("<p>___________________________________________________________</p>") > data".html";
		print ("</body></html>") > data".html";
	}
	
}

function imprimeTransacao(transacao, ficheiro) {
	for (i in transacao) {
		print("<p><b>" i ": </b>" transacao[i] "</p>") > ficheiro;
	}
	print("<p>----------------------------------------------------------------</p>") > ficheiro;
}

function imprimeLocaisSaida(transacoes, ficheiro) {
	for (i in transacoes) {
		saida = transacoes[i]["SAIDA"];
		if (saida != "null") {
			saidas[saida] = saida;
		}
	}
	print ("<p><b>Local de saída</b></p>") > ficheiro;
	n = asort(saidas);
	for (i = 1; i <= n; i++) {
		print ("<p>" saidas[i] "</p>") > ficheiro;
	}
}

function imprimeValorGasto(transacoes, ficheiro) {
	valor = 0;
	iva2 = 0;
	for (i in transacoes) {
		preco = transacoes[i]["IMPORTANCIA"];
		desconto = transacoes[i]["VALOR_DESCONTO"];
		iva = (transacoes[i]["TAXA_IVA"] / 100) + 1;
		iva2 += preco * (iva - 1);
		valor += (preco - desconto) * iva;
	}
	printf ("<p><b>Total gasto no mês: </b> %0.2f € c/IVA &emsp;&emsp; (Valor de IVA: %0.2f €)</p>", valor, iva2) > ficheiro;
}

function imprimeValorGastoParques(transacoes, ficheiro) {
	valor = 0;
	iva2 = 0;
	for (i in transacoes) {
		tipo = transacoes[i]["TIPO"];
		if (tipo ~ /[Pp]arque/) {
			preco = transacoes[i]["IMPORTANCIA"];
			desconto = transacoes[i]["VALOR_DESCONTO"];
			iva = (transacoes[i]["TAXA_IVA"] / 100) + 1;
			iva2 += preco * (iva - 1);
			valor += (preco - desconto) * iva;
		}
	}
	printf ("<p><b>Total gasto em parques: </b> %0.2f € c/IVA &emsp;&emsp; (Valor de IVA: %0.2f €)</p>", valor, iva2) > ficheiro;
}