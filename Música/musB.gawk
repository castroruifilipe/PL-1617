BEGIN { 
	FS = ":";
	RS = "\n";
	r = 0;
}

$1 == "author" {	split($2, tmp,/[;||,]/);
					for (i in tmp) {
						authors[tmp[i]]++;
					}
				}

END {
	for (i in authors) {
		print authors[i] " - " i;
	}
}