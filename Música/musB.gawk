BEGIN {
	FS = " *: *";
}

{
	gsub(/ $/, "", $0);
}

$1 ~ /[Aa]uthor/ {
	gsub(/ *; */, ", ", $2);
	gsub(/ *, */, ", ", $2);
	gsub(/^\?|an[óo]nimo/, "Desconhecido", $2)
	gsub(/popular.*/, "Popular", $2);
		authors[$2]++;
}

END {
	for (i in authors) {
		print i " - " authors[i];
	}
}