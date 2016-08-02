#!/bin/bash -x
export HOME=/root   # node-gyp requires that the user's home directory is specified in either of the environmental variables HOME or USERPROFILE

mkdir -p /var/www-deploy/ &&
rm -rvf  /var/www-deploy/liatandco.com
tar -xzf /root/build/liatandco.com.tgz -C /var/www-deploy/ &&
cd /var/www-deploy/liatandco.com &&
npm cache clean &&
npm install --production &&
npm list 2>&1 | awk '/missing:/ { print $4 }' | sed 's/,//' | xargs npm install &&
bower install --allow-root &&
compass compile &&

(if [ -d /var/www-deploy/liatandco.com ]; then
    if [ -d /var/www/liatandco.com ]; then
        mkdir -p /var/www-backup/liatandco.com
        cd /var/www-backup/liatandco.com/; ls -1t | tail -n +10 | xargs rm -rvf # remove all but last 10 backups

        mv /var/www/liatandco.com /var/www-backup/liatandco.com/`date +'%F_%H%M-%S'`
    fi
    mv /var/www-deploy/liatandco.com /var/www/
fi)