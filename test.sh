#!/bin/bash

any_failed=0

RED='\033[0;31m'
GREEN='\033[0;32m'
NO_COLOR='\033[0m'

for test_folder in test/*; do
    programs=( 'nvim -nN --headless' 'vim -nN --not-a-term' )

    for program in "${programs[@]}"; do
        rm "./${test_folder}/actual.txt" > /dev/null 2>&1
        ${program} -u ./.vim/vimrc.local -c '' -s ./${test_folder}/when.vim ./${test_folder}/given.txt > /dev/null 2>&1

        program_name=$(echo "${program}" | awk '{print $1}')

        if cmp --silent -- ./${test_folder}/expected.txt ./${test_folder}/actual.txt; then
            echo -e "${GREEN}PASS${NO_COLOR} ${program_name} ${test_folder}"
        else
            echo -e "${RED}FAIL${NO_COLOR} ${program_name} ${test_folder}"
            echo ""
            echo "EXPECTED:"
            cat ./${test_folder}/expected.txt
            echo ""
            echo "ACTUAL:"
            cat ./${test_folder}/actual.txt
            echo ""
            echo ""

            any_failed=1
        fi
    done;
done;

if [ ${any_failed} -eq 1 ]; then 
    exit 1
fi
