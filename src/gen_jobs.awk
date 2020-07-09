#!/bin/awk -f

BEGIN {
	FS = "[ \t]+>[ \t]+"
	MIN_DELAY = 3
	MAX_DELAY = 15
	"pwd -P" | getline pwd
	close("pwd -P")
	system("mkdir -p dist/data")
	data = pwd "/dist/data"
}

NF == 3 {
	delay = int(MAX_DELAY * rand())

	# add sorrounding text to input and output
	gsub(/([^ ]+)/, "tab_&.dat", $1)
	gsub(/([^ ]+)/, "tab_&.dat", $3)

	# output variables
	folder = "dist/code/prog_" $2
	ini = folder "/test_" $2 ".ini"
	prog = folder "/test_" $2 ".sh"

	# create output files
	system("mkdir -p " folder)
	print "input=(" $1 ")" > ini
	print "output=(" $3 ")" > ini
	print "delay=" delay > ini
	print "data=" data > ini
	system("cp src/prog_tpl.sh " prog)
}

END {
	# generate dummy data files
	for (i = 0; i < 10; i++) {
		system("touch " data "/tab_0" i ".dat")
	}
	# copy example scripts
	system("cp src/run_all dist/code/")
	system("cp src/data_update dist/code/")
}
