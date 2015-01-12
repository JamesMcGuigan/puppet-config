#!/bin/bash -x
export HOME=/root   # node-gyp requires that the user's home directory is specified in either of the environmental variables HOME or USERPROFILE

cd /root/github/liatandco.com/
npm cache clean
npm install
yes | bower install --allow-root
npm run production

if [ ! -f /root/github/liatandco.com/sslcert/san/liatandco.san.crt ]; then
    /root/github/liatandco.com/sslcert/san/generate-san.sh
fi;

mkdir -p /root/build/
rm    -f /root/build/liatandco.com.tgz
cd       /root/github/
tar -czf /root/build/liatandco.com.tgz liatandco.com

