.PHONY: all clean

all: musicaA musicaV musicaC viaVerde

musicaA: ./Musica/musA.awk
	$gawk -f ./Musica/musA.awk ./Musica/musica/*

musicaB: ./Musica/musB.awk
	$gawk -f ./Musica/musB.awk ./Musica/musica/*

musicaC: ./Musica/musC.awk
	$gawk -f ./Musica/musC.awk ./Musica/musica/*

viaVerde: ./Via\ Verde/main.awk
	$gawk -f ./Via\ Verde/main.awk ./Via\ Verde/viaverde.xml

clean:
	$(RM) *.html