#!/bin/bash

rhost=$1
if [[ "$rhost" == "" ]] ; then
        echo "remote host not provided.";
        exit;
fi

/bin/bash /root/alphawolf/ubuntu/code-sync-ubuntu.sh $1
echo "code synced"

scp -i /root/alphawolf/keys/rsync_rsa /root/alphawolf/ubuntu/htaccess.tmpl root@$1:/var/www/wolfbotx/www/.htaccess
ssh -i /root/alphawolf/keys/rsync_rsa root@$1 'sed -i "s/<YOURIPADDRESS>/'$1'/" /var/www/wolfbotx/www/.htaccess'
ssh -i /root/alphawolf/keys/rsync_rsa root@$1 'mkdir /var/www/wolfbotx/websites'
ssh -i /root/alphawolf/keys/rsync_rsa root@$1 'chmod -R 777 /var/www/wolfbotx/websites'

