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

/bin/bash /root/alphawolf/init-ubuntu.sh $1
/bin/bash /root/alphawolf/ubuntu/wolfbot-ubuntu.sh $1

