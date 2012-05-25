#!/bin/bash

rhost=$1

if [[ "$rhost" == "" ]] ; then
        echo "remote host not provided.";
        exit;
fi

rsync -vrtplz  -e "/usr/bin/ssh -i /root/alphawolf/keys/rsync_rsa" --delete --exclude "scraped" --exclude "websites" --exclude ".*" --exclude "*.txt" /var/www/html/wolfbotx/* $1:/var/www/html/wolfbotx
