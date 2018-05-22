#!/bin/bash -x
export HOME=/root   # node-gyp requires that the user's home directory is specified in either of the environmental variables HOME or USERPROFILE

mkdir -p /var/www-deploy/ &&
rm -rvf  /var/www-deploy/statistical-learning
tar -xzf /root/build/statistical-learning.tgz -C /var/www-deploy/ &&
cd /var/www-deploy/statistical-learning &&

npm install --no-optional &&  # --no-optional: fixes Not compatible with your operating system or architecture: fsevents@1.0.14
npm list 2>&1 | awk '/missing:/ { print $4 }' | sed 's/,//' | xargs npm install &&
bower install --allow-root &&
compass compile &&

(if [ -d /var/www-deploy/statistical-learning ]; then
    if [ -d /var/www/statistical-learning ]; then
        mkdir -p /var/www-backup/statistical-learning
        cd /var/www-backup/statistical-learning/; ls -1t | tail -n +3 | xargs rm -rvf # remove all but last 3 backups

        mv /var/www/statistical-learning /var/www-backup/statistical-learning/`date +'%F_%H%M-%S'`
    fi
    mv /var/www-deploy/statistical-learning /var/www/
fi)
