#!/bin/bash


for test_folder in test/*; do
    vim \
        -Nu ./.vim/vimrc.local \
        -c '' \
        -s ./${test_folder}/when.vim \
        ./${test_folder}/given.txt

    RED='\033[0;31m'
    GREEN='\033[0;32m'
    NO_COLOR='\033[0m'
    if cmp --silent -- ./${test_folder}/expected.txt ./${test_folder}/actual.txt; then
        echo -e "${GREEN}${test_folder}: PASS${NO_COLOR}"
    else
        echo -e "${GREEN}${test_folder}: FAIL${NO_COLOR}"
    fi
done;
