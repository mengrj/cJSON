#!/bin/bash

mkdir -p afl-build || exit 1
cd afl-build || exit 1
#cleanup
rm -r -- *

CC=clang cmake ../.. -DENABLE_FUZZING=On -DENABLE_SANITIZERS=On -DBUILD_SHARED_LIBS=Off  -DCMAKE_C_FLAGS="-g -O0"
make afl-main
