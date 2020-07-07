#!/bin/bash

echo Running program $0

data="$DATAPATH"

pushd `dirname $0`

# read config option from ini file
source ``.ini

# test input vs. output files
#if [ ! -f $data/tab_02.txt -o ! -f $data/tab_04.txt ] ; then
#	echo Error: at least one input table does not exist!
#	exit 1
#fi


#if [ $data/tab_12.txt -nt $data/tab_02.txt -a $data/tab_12.txt -nt $data/tab_04.txt ] ; then
#	echo Info: results are new than the inputs...
#	exit 0
#fi

echo -n Execution...
sleep {{ delay }}
#touch $data/tab_12.txt
echo done!

popd

