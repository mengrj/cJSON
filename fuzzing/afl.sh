#!/bin/bash

mkdir -p afl-build || exit 1
cd afl-build || exit 1
#cleanup
rm -r -- *

CC=${FUZZER_PATH}/afl-clang-fast cmake ../.. -DENABLE_FUZZING=On -DENABLE_SANITIZERS=On -DBUILD_SHARED_LIBS=Off -DAFL_FUZZ="${FUZZER_PATH}"/afl-fuzz
make afl-main
