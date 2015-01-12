#!/bin/bash -x

mkdir -p /root/github/
if [ ! -d /root/github/liatandco.com ]; then
    git clone https://github.com/JamesMcGuigan/liatandco.com.git /root/github/liatandco.com
else
    cd /root/github/liatandco.com
    if [[ `git remote -v | grep JamesMcGuigan/liatandco.com.git` ]]; then
        git checkout -- ./
        git pull
    else
        rm -vf /root/github/liatandco.com
        git clone git@github.com:JamesMcGuigan/liatandco.com.git /root/github/liatandco.com
    fi

    # Branch Selection
    git checkout master
    git checkout -- ./
    git pull
fi
