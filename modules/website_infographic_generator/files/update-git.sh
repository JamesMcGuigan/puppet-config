#!/bin/bash -x

mkdir -p /root/github/
if [ ! -d /root/github/infographic-generator ]; then
    git clone https://github.com/JamesMcGuigan/infographic-generator.git /root/github/infographic-generator
else
    cd /root/github/infographic-generator
    if [[ `git remote -v | grep JamesMcGuigan/infographic-generator.git` ]]; then
        git checkout -- ./
        git pull
    else
        rm -vf /root/github/infographic-generator
        git clone git@github.com:JamesMcGuigan/infographic-generator.git /root/github/infographic-generator
    fi

    # Branch Selection
    git checkout master
    git checkout -- ./
    git pull
fi
