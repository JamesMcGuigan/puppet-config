#!/bin/bash

REPO=$1
DIR=$2
REVISION="${3:-default master}"

(
mkdir -p /root/github/
if [ ! -d $DIR ]; then
    cd /root/github/
    git clone --quiet $REPO $DIR
else
    cd $DIR
    if [[ `git remote -v | grep $REPO` ]]; then
        git checkout --quiet $REVISION ./
        git pull
    else
        cd /root/github/
        rm -rf $DIR
        git clone --quiet $REPO $DIR
    fi
fi

# Branch Selection
cd $DIR
git checkout --quiet $REVISION ./
git pull

) 2>&1 > /dev/null
cd $DIR
git log -1 --format=%ct-%h-%f | tr -d '[:space:]'
true
