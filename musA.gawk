BEGIN { 
	FS = ":";
	RS = "\n";
	r = 0;
}

$1 == "singer" {	split($2, tmp,/[;]/);
					for (i in tmp) {
						singers[tmp[i]];
	}
				}

END {
	for (i in singers) {
		print (i);
	}
}