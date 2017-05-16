compilador: lex.yy.c y.tab.c
	gcc -g `pkg-config --cflags --libs glib-2.0` y.tab.c -o compilador

y.tab.c: compilador.y
	yacc -d -v compilador.y

lex.yy.c: compilador.l
	flex compilador.l