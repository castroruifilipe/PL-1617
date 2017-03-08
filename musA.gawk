BEGIN { 
	FS = ":";
	RS = "\n";
	r = 0;
}

$1 == "Singer" {	split($2, tmp,/[;]/);
					for (i in tmp) {
						singers[tmp[i]];
	}
				}

END {
	for (i in singers) {
		print (i);
	}
}