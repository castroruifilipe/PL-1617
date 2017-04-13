all: normalizador ${FILE} processador cleans

normalizador: normalizador.l
	flex normalizador.l
	gcc -g lex.yy.c -o normalizador 
	./normalizador ${FILE}

processador: processador.l
	flex processador.l
	gcc -g lex.yy.c -o processador 
	./processador aux.txt

clean:
	rm -r lex.yy.c normalizador *.dSYM processador aux.txt nomes.txt

cleans:
	rm -r aux.txt lex.yy.c *.dSYM