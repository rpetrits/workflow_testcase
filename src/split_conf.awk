BEGIN {
	"pwd -P" | getline pwd
	close("pwd -P")
	FS = "="
	fname = ""
	n = 1
	system("mkdir -p dist")
}

$0 ~ /^[ \t]*\[/ {
	fname = $0
	sub(/\].*$/, "", fname)
	sub(/^[ \t]*\[/, "", fname)
	fname = fname ".ini"
	files[n++] = fname
}


($0 !~ /^[ \t]*\[/) && (NF > 0) {
	if ($1 == "folder") {
		folder[n-1] = $2
	} else {
		print $0 > "dist/"fname
	}
}

END {
	for (i = 1; i < n; i++) {
		system("mkdir -p dist/" folder[i])
		system("mv dist/" files[i] " dist/" folder[i] "/")
	}
}

