AlineaA: AlineaA.l
	flex AlineaA.l
	gcc -g lex.yy.c -o AlineaA
	rm -r lex.yy.c *.dSYM
	./AlineaA $(FILE)

AlineaB: AlineaB.l
	flex AlineaB.l
	gcc -g `pkg-config --cflags glib-2.0` lex.yy.c -o AlineaB `pkg-config --libs glib-2.0`
	rm -r lex.yy.c
	./AlineaB $(FILE)

clean:
	rm -r *.html AlineaA AlineaB