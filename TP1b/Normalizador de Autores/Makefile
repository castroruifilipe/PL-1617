all: formatador normalizador processador grafo cleans

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
	gcc -g `pkg-config --cflags glib-2.0` lex.yy.c -o processador `pkg-config --libs glib-2.0`
	./processador nomes.txt ${NOME}

grafo: 
	dot -Tpng -o grafo.png grafo.dot
	open grafo.png

clean:
	rm -r formatador normalizador aux.txt nomes.txt processador grafo.dot grafo.png

cleans:
	rm -r lex.yy.c *.dSYM