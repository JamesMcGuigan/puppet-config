#!/bin/bash -x
export HOME=/root   # node-gyp requires that the user's home directory is specified in either of the environmental variables HOME or USERPROFILE

mkdir -p /var/www-deploy/ &&
rm -rvf  /var/www-deploy/infographic-generator
tar -xzf /root/build/infographic-generator.tgz -C /var/www-deploy/ &&
cd /var/www-deploy/infographic-generator &&

npm cache clean &&
npm install --no-optional &&  # --no-optional: fixes Not compatible with your operating system or architecture: fsevents@1.0.14
npm list 2>&1 | awk '/missing:/ { print $4 }' | sed 's/,//' | xargs npm install &&
bower install --allow-root &&
compass compile &&

(if [ -d /var/www-deploy/infographic-generator ]; then
    if [ -d /var/www/infographic-generator ]; then
        mkdir -p /var/www-backup/infographic-generator
        cd /var/www-backup/infographic-generator/; ls -1t | tail -n +3 | xargs rm -rvf # remove all but last 3 backups

        mv /var/www/infographic-generator /var/www-backup/infographic-generator/`date +'%F_%H%M-%S'`
    fi
    mv /var/www-deploy/infographic-generator /var/www/
fi)
