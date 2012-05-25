#!/bin/bash

cmd=$1

for i in `cat serverlistubuntu`
do
	if [[ "$i" == *#* ]] ; then continue; fi
echo " "
echo $i
echo "-------------------------------------------------------------------------------------------"
if [[ $1 != "" ]] ; then
	ssh -i ./keys/rsync_rsa root@$i "$1"
fi
done
