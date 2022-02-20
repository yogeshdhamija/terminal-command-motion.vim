#!/bin/bash

any_failed=0

RED='\033[0;31m'
GREEN='\033[0;32m'
NO_COLOR='\033[0m'

for test_folder in test/*; do
    programs=( 'vim --not-a-term -N' 'nvim -es' )

    for program in "${programs[@]}"; do
        ${program} -u ./.vim/vimrc.local -c '' -s ./${test_folder}/when.vim ./${test_folder}/given.txt > /dev/null

        program_name=$(echo "${program}" | awk '{print $1}')

        if cmp --silent -- ./${test_folder}/expected.txt ./${test_folder}/actual.txt; then
            echo -e "${GREEN}${test_folder} ${program_name} PASS${NO_COLOR}"
        else
            echo -e "${RED}${test_folder} ${program_name} FAIL${NO_COLOR}"
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
