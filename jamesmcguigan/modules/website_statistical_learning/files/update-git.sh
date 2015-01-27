#!/bin/bash -x

mkdir -p /root/github/
if [ ! -d /root/github/statistical-learning ]; then
    git clone https://github.com/JamesMcGuigan/statistical-learning.git /root/github/statistical-learning
else
    cd /root/github/statistical-learning
    if [[ `git remote -v | grep JamesMcGuigan/statistical-learning.git` ]]; then
        git checkout -- ./
        git pull
    else
        rm -vf /root/github/statistical-learning
        git clone git@github.com:JamesMcGuigan/statistical-learning.git /root/github/statistical-learning
    fi

    # Branch Selection
    git checkout master
    git checkout -- ./
    git pull
fi
