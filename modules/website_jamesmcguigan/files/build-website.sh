#!/bin/bash -x
export HOME=/root   # node-gyp requires that the user's home directory is specified in either of the environmental variables HOME or USERPROFILE

cd /root/github/jamesmcguigan.com/
bundle install &&
npm update &&

mkdir -p /root/build/ &&
rm    -f /root/build/jamesmcguigan.com.tgz &&
cd       /root/github/ &&
tar -czf /root/build/jamesmcguigan.com.tgz jamesmcguigan.com
