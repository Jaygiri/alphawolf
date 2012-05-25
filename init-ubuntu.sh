#!/bin/bash

/bin/bash /root/alphawolf/init-rsa.sh $1

#remember you are on cheap VPS
#they don't cofigure everything for you
if grep -iq "8.8.8.8" /etc/resolv.conf; then
	scp -i /root/alphawolf/keys/rsync_rsa /root/alphawolf/ubuntu/ubuntu-resolv.conf root@$1:/etc/resolv.conf
	ssh -i /root/alphawolf/keys/rsync_rsa root@$1 "/etc/init.d/networking restart"
fi


#setup wolfnet
ssh -i ./keys/rsync_rsa root@$1 "mkdir /root/wolfnet"
scp -i ./keys/rsync_rsa /root/alphawolf/ubuntu/setup-ubuntu.sh root@$1:/root/wolfnet/
scp -i ./keys/rsync_rsa /root/alphawolf/ubuntu/ubuntu-sources.list root@$1:/etc/apt/sources.list
ssh -i ./keys/rsync_rsa root@$1 "/bin/bash /root/wolfnet/setup-ubuntu.sh system"

echo "Server: " $1 " succeefully setup"
