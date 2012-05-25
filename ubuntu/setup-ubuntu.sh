#!/bin/bash

function install_apache {
    apt-get -q -y install apache2 apache2-mpm-prefork
}
function install_php {
    apt-get -q -y install php5 libapache2-mod-php5 php5-cli php5-curl php5-mysql
}

function setup_apache {
    
    sed -i "s/AllowOverride None/AllowOverride All/" /etc/apache2/sites-enabled/000-default
    sed -i "s/ Indexes / /" /etc/apache2/sites-enabled/000-default
    /etc/init.d/apache2 restart
}

function check_sanity {
    # Do some sanity checking.
    if [ $(/usr/bin/id -u) != "0" ]
    then
        die 'Must be run by root user'
    fi

    if [ ! -f /etc/debian_version ]
    then
        die "Distribution is not supported"
    fi
}

function die {
    echo "ERROR: $1" > /dev/null 1>&2
    exit 1
}

function get_domain_name() {
    # Getting rid of the lowest part.
    domain=${1%.*}
    lowest=`expr "$domain" : '.*\.\([a-z][a-z]*\)'`
    case "$lowest" in
    com|net|org|gov|edu|co)
        domain=${domain%.*}
        ;;
    esac
    lowest=`expr "$domain" : '.*\.\([a-z][a-z]*\)'`
    [ -z "$lowest" ] && echo "$domain" || echo "$lowest"
}

function get_password() {
    # Check whether our local salt is present.
    SALT=/var/lib/radom_salt
    if [ ! -f "$SALT" ]
    then
        head -c 512 /dev/urandom > "$SALT"
        chmod 400 "$SALT"
    fi
    password=`(cat "$SALT"; echo $1) | md5sum | base64`
    echo ${password:0:13}
}


function update_upgrade {
    # Run through the apt-get update/upgrade first. This should be done before
    # we try to install any package
    apt-get -q -y update
    apt-get install -q -y rsync
    #apt-get -q -y upgrade
}

function set_timezone_PST {
    ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
}

########################################################################
# START OF PROGRAM
########################################################################
export PATH=/bin:/usr/bin:/sbin:/usr/sbin

check_sanity
case "$1" in
mysql)
    install_mysql
    ;;
php)
    install_php
    ;;
system)
    update_upgrade
    set_timezone_PST
    install_apache
    install_php
    setup_apache
    ;;
*)
    echo 'Usage:' `basename $0` '[option]'
    echo 'Available option:'
    for option in system exim4 mysql nginx php wordpress
    do
        echo '  -' $option
    done
    ;;
esac

