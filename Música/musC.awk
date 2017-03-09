BEGIN { 
	FS = " *: *";
	i = 0;
}

{
	gsub(/ $/, "", $0);
}

$1 ~ /[Tt]itle/ {
	gsub(/ *[*=] */, "", $2);
	titulos[i] = $2;
}

$1 ~ /[Aa]uthor/ {
	gsub(/^\?/, "Desconhecido", $2);
	authores[i] = $2;
}

ENDFILE {
	i++;
}

END {
	for (j = 0; j < i; j++) {
		musicas[authores[j]][j] = titulos[j];
	}
	for (autor in musicas) {
		print (autor " - " );
		n = 0;
		for (titulo in musicas[autor]) {
			n++;
			if (n < length(musicas[autor])) {
				print ("      " musicas[autor][titulo]",");
			} else {
				print ("      " musicas[autor][titulo]".");
			}
		}
	}
}