#!/bin/bash -x
export HOME=/root   # node-gyp requires that the user's home directory is specified in either of the environmental variables HOME or USERPROFILE

### Ghost ^0.6.4 requires node 0.10.39 - does not support yarn
### BUGFIX: https://github.com/tj/n/pull/470 - node 0.10.39 | Remove existing npm folder before copying activated version
rm -rf /usr/local/lib/node_modules/npm /usr/local/bin/node
/usr/bin/env n 0.10.39

cd /root/github/liatandco.com/ &&
bundle install &&
npm install --production &&
npm list 2>&1 | awk '/missing:/ { print $4 }' | sed 's/,//' | xargs npm install &&
yes | bower install --allow-root &&
npm run production &&
(
if [ ! -f /root/github/liatandco.com/sslcert/san/liatandco.san.crt ]; then
    /root/github/liatandco.com/sslcert/san/generate-san.sh
fi;
) &&
mkdir -p /root/build/ &&
rm    -f /root/build/liatandco.com.tgz &&
cd       /root/github/ &&
tar -czf /root/build/liatandco.com.tgz liatandco.com