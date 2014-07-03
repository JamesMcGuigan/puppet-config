#!/bin/bash
scripts_to_run_dir="$(dirname "$0")/pre-commit.d/"
shopt -s nullglob
for script in "$scripts_to_run_dir"/*
do
    if [[ -x "$script" ]]; then
        "$script"
    fi
done
