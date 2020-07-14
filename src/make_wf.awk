#!/bin/awk -f

BEGIN {
	FS = "[ \t]*=[ \t]*"
}

FNR == 1 {
	n = split(FILENAME, h, "/");
	basename = h[n]
	sub(/\.ini/, "", basename)
}

$1 == "input" {
	line = $2
	sub(/^\(/, "", line)
	sub(/\)$/, "", line)
	n = split(line, h, " ");
	for (i = 1; i <= n; i++) {
		input[h[i],in_ct[h[i]]++] = basename
		#print "in:", basename, h[i], in_ct[h[i]]
	}
}

$1 == "output" {
	line = $2
	sub(/^\(/, "", line)
	sub(/\)$/, "", line)
	n = split(line, h, " ");
	for (i = 1; i <= n; i++) {
		if (h[i] in output) {
			print h[i] " is defined as output multiple times!"
		} else {
			output[h[i]] = basename
		}
		#print "out:", basename, h[i]
	}
}

END {
	for (k in output) {
		if (k in in_ct) {
			for (i = 0; i < in_ct[k]; i++ ) {
				print output[k] " -> " input[k,i]
			}
		}
	}
}
