#!/bin/bash

any_failed=0

RED='\033[0;31m'
GREEN='\033[0;32m'
NO_COLOR='\033[0m'

for test_folder in test/*; do
    vim \
        -Nu ./.vim/vimrc.local \
        -c '' \
        -s ./${test_folder}/when.vim \
        ./${test_folder}/given.txt

    if cmp --silent -- ./${test_folder}/expected.txt ./${test_folder}/actual.txt; then
        echo -e "${GREEN}${test_folder}: PASS${NO_COLOR}"
    else
        echo -e "${RED}${test_folder}: FAIL${NO_COLOR}"
        any_failed=1
    fi
done;

if [ ${any_failed} -eq 1 ]; then 
    exit 1
fi
