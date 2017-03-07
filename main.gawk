BEGIN { FS = "[<>]";
	typedef struct transacao {
		int dia_entrada, mes_entrada, ano_entrada;
		int hora_entrada, minuto_entrada;
		char *entrada;
		int dia_saida, mes_saida, ano_saida;
		int hora_saida, minuto_saida;
		char *saida;
		double importanica;
		double valor_desconto;
		double taxa_iva;
		char *operador;
		char *tipo;
		int dia_debito, mes_debito, ano_debito;
		char *cartao;
	} Transacao;

	Transacao *transacao_atual;
	i++;
}

$2 == "TRANSACAO>" 					{ transacao_atual = (Transacao *)malloc(sizeof(struct transacao));
							  transacoes[i++] = transacao_atual;
							}

$3 == "DATA_ENTRADA"					{ print $3 }

END							{ }
