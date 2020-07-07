#!/bin/bash

echo Running program $0

script=`basename $0`

pushd `dirname $0` > /dev/null

# read config option from ini file
source ${script%.*}.ini

# test input files exist
for f in ${input[@]} ; do
	if [ ! -f $data/$f ] ; then
		echo Error: input table does not exist!
		exit 1
	fi
done

# find latest input
mod_in=0
for f in ${input[@]} ; do
	if [ `date -r $data/$f '+%s'` -gt ${mod_in} ] ; then
		mod_in=`date -r $data/$f '+%s'`
	fi
done

# find oldest output
mod_out=9999999999
for f in ${output[@]} ; do
	if [ -f $data/$f ] ; then
		if [ `date -r $data/$f '+%s'` -lt ${mod_out} ] ; then
			mod_out=`date -r $data/$f '+%s'`
		fi
	else
		mod_out=0
	fi
done

# quit if inputs are not updated
if [ $mod_in -lt $mod_out ] ; then
	echo Info: results are newer than the inputs...
	exit 0
fi

echo -n Execution...
sleep $delay
for f in ${output[@]} ; do
	touch $data/$f
done
echo done!

popd > /dev/null
