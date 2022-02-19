#!/bin/bash

vim \
    -Nu ./.vim/vimrc.local \
    -c '' \
    -s ./test/when.vim \
    ./test/given.txt

if cmp --silent -- ./test/expected.txt ./test/actual.txt; then
    echo "PASS"
    exit 0
else
    echo "FAIL"
    exit 1
fi
