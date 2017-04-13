V=normalizador
$V: $V.l
	flex $V.l
	gcc -g lex.yy.c -o $V 

P=processador
$P: $P.l
	flex $P.l
	gcc -g lex.yy.c -o $P

normalizar:
	normalizador
	./normalizador exemplo-utf8.bib

 processar: ./processador aux.txt

 all: normalizar processar