#!/bin/awk -f

BEGIN {
	FS = "[ \t]+>[ \t]+";
	OFS = ";"
	MIN_DELAY = 3
	MAX_DELAY = 15
}

NF == 3 {
	delay = int(MAX_DELAY * rand())
	# add sorrounding text
	gsub(/([^ ]+)/, "tab_&.dat", $1)
	gsub(/([^ ]+)/, "tab_&.dat", $3)
	# output
	print "[test_" $2 "]"
	print "folder=prog_" $2
	print "input=(" $1 ")"
	print "output=(" $3 ")"
	print "delay=" delay
	print ""
}
