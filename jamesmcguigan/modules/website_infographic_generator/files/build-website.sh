#!/bin/bash -x
export HOME=/root   # node-gyp requires that the user's home directory is specified in either of the environmental variables HOME or USERPROFILE

cd /root/github/infographic-generator/
bundle install &&
npm cache clean &&
npm install &&
npm list 2>&1 | awk '/missing:/ { print $4 }' | sed 's/,//' | xargs npm install &&
yes | bower install --allow-root &&
npm run production &&
mkdir -p /root/build/ &&
rm    -f /root/build/infographic-generator.tgz &&
cd       /root/github/ &&
tar -czf /root/build/infographic-generator.tgz infographic-generator