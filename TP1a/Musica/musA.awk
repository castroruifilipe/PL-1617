BEGIN { 
	FS = " *: *| *; *| *, *";
}

{
	gsub(/ $/, "", $0);
}

$1 ~ /[Ss]inger/ {
	gsub(/^\?/, "Desconhecido", $2);
	gsub(/&/, "e", $2);
	for (i = 2; i <= NF; i++) {
		singers[$i] = $i;
	}
}

END {
	n = asort(singers);
	for (i = 1; i <= n; i++) {
		print (singers[i]);
	}
	print("Total de cantores: " n);
}