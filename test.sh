#!/bin/bash


for test_folder in test/*; do
    vim \
        -Nu ./.vim/vimrc.local \
        -c '' \
        -s ./${test_folder}/when.vim \
        ./${test_folder}/given.txt

    if cmp --silent -- ./${test_folder}/expected.txt ./${test_folder}/actual.txt; then
        echo "${test_folder}: PASS"
    else
        echo "${test_folder}: FAIL"
    fi
done;
