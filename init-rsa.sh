#!/bin/bash

rhost=$1
user=$2

if [[ "$rhost" == "" ]] ; then
	echo "remote host not provided.";
	exit;
fi
if [[ "$user" == "" ]] ; then
	user="root"
fi

/usr/bin/ssh-keygen -R $1
ssh-copy-id -i /root/alphawolf/keys/rsync_rsa.pub $user@$1

