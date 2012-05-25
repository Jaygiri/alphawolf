#!/bin/bash

cmd=$1

for i in `cat serverlist`
do
	if [[ "$i" == *#* ]] ; then continue; fi
echo $i
if [[ $1 != "" ]] ; then
	ssh -i ./keys/rsync_rsa root@$i "$1"
fi
done
