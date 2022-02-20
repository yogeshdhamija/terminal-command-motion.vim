#!/bin/bash

run_test() {
    local test_folder=$1

    vim \
        -Nu ./.vim/vimrc.local \
        -c '' \
        -s ./test/${test_folder}/when.vim \
        ./test/${test_folder}/given.txt

    if cmp --silent -- ./test/${test_folder}/expected.txt ./test/${test_folder}/actual.txt; then
        echo "PASS"
        return 0
    else
        echo "FAIL"
        return 1
    fi
}

run_test "cm" || exit 1
