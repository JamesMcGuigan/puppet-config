#!/bin/bash -x
export HOME=/root   # node-gyp requires that the user's home directory is specified in either of the environmental variables HOME or USERPROFILE

mkdir -p /var/www-deploy/ &&
rm -rvf  /var/www-deploy/jamesmcguigan.com
tar -xzf /root/build/jamesmcguigan.com.tgz -C /var/www-deploy/ &&
cd /var/www-deploy/jamesmcguigan.com &&

(cd ./jekyll/; jekyll build;) &&  # needs to be `gem install jekyll` and not `apt-get install jekyll`

(if [ -d /var/www-deploy/jamesmcguigan.com ]; then
    if [ -d /var/www/jamesmcguigan.com ]; then
        mkdir -p /var/www-backup/jamesmcguigan.com
        cd /var/www-backup/jamesmcguigan.com/; ls -1t | tail -n +10 | xargs rm -rvf # remove all but last 10 backups

        mv /var/www/jamesmcguigan.com /var/www-backup/jamesmcguigan.com/`date +'%F_%H%M-%S'`
    fi
    mv /var/www-deploy/jamesmcguigan.com /var/www/
fi)
