#!/bin/bash

# the first parameter
CC=$1 # C compiler
C_FLAGS=$2 # C flags

mkdir -p afl-build || exit 1
cd afl-build || exit 1
#cleanup
rm -r -- *


# if C_FLAGS is not empty
if [ -n "$C_FLAGS" ]; then
    CC=${CC} cmake ../.. -DENABLE_FUZZING=On -DENABLE_SANITIZERS=On -DBUILD_SHARED_LIBS=Off -DCMAKE_C_FLAGS="$C_FLAGS"
    make afl-main
    exit 0
else
    CC=${CC} cmake ../.. -DENABLE_FUZZING=On -DENABLE_SANITIZERS=On -DBUILD_SHARED_LIBS=Off
fi
make afl-main
