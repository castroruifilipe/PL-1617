all: formatador ${FILE} normalizador  processador ${NOME} cleans

formatador: formatador.l
	flex formatador.l
	gcc -g lex.yy.c -o formatador 
	./formatador ${FILE}

normalizador: normalizador.l
	flex normalizador.l
	gcc -g lex.yy.c -o normalizador 
	./normalizador aux.txt

processador: processador.l
	flex processador.l
	gcc -g lex.yy.c -o processador 
	./processador nomes.txt ${NOME}

clean:
	rm -r lex.yy.c formatador *.dSYM normalizador aux.txt nomes.txt

cleans:
	rm -r aux.txt lex.yy.c *.dSYM