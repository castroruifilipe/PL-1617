all: cleaner formatador normalizador processador grafo

cleaner: cleaner.l
	flex cleaner.l
	gcc -g lex.yy.c -o cleaner
	./cleaner ${FILE}
	rm -r lex.yy.c

formatador: formatador.l
	flex formatador.l
	gcc -g lex.yy.c -o formatador
	./formatador limpo.txt
	rm -r lex.yy.c

normalizador: normalizador.l
	flex normalizador.l
	gcc -g lex.yy.c -o normalizador 
	./normalizador formatado.txt
	rm -r lex.yy.c

processador: processador.l
	flex processador.l
	gcc -g `pkg-config --cflags glib-2.0` lex.yy.c -o processador `pkg-config --libs glib-2.0`
	./processador normalizado.txt ${NOME}
	rm -r lex.yy.c

grafo: 
	dot -Tpng -o grafo.png grafo.dot

clean:
	rm -r cleaner formatador normalizador processador limpo.txt formatado.txt normalizado.txt grafo.dot grafo.png *.dSYM