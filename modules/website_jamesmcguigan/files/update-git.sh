#!/bin/bash -x

mkdir -p /root/github/
if [ ! -d /root/github/jamesmcguigan.com ]; then
    git clone https://github.com/JamesMcGuigan/jamesmcguigan.com.git /root/github/jamesmcguigan.com
else
    cd /root/github/jamesmcguigan.com
    if [[ `git remote -v | grep JamesMcGuigan/jamesmcguigan.com.git` ]]; then
        git checkout -- ./
        git pull
    else
        rm -vf /root/github/jamesmcguigan.com
        git clone git@github.com:JamesMcGuigan/jamesmcguigan.com.git /root/github/jamesmcguigan.com
    fi

    # Branch Selection
    git checkout master
    git checkout -- ./
    git pull
fi
