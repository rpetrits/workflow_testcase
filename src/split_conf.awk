BEGIN {
	"pwd -P" | getline pwd
	close("pwd -P")
	FS = "="
	fname = ""
	n = 1
	system("mkdir -p dist/data")
	data = pwd "/dist/data"
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
		print "data=" data > "dist/" files[i]
		shf = files[i]
		sub(".ini", ".sh", shf)
		system("mkdir -p dist/code/" folder[i])
		system("mv dist/" files[i] " dist/code/" folder[i] "/")
		system("cp src/prog_tpl.sh dist/code/" folder[i] "/" shf)
	}
	for (i = 0; i < 10; i++) {
		system("touch " data "/tab_0" i ".dat")
	}

}

