#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd -P)

PATH_SYSROOT=$BASE_DIR/../../../../out/target/product/generic_riscv64/symbols
PATH_BIN=$BASE_DIR/../../../../out/target/product/generic_riscv64/symbols/data/nativetest64/bionic-unit-tests/bionic-unit-tests

GTEST_FILTER=$1

LD_LIBRARY_PATH=. qemu-riscv64 -L $PATH_SYSROOT $PATH_BIN --no_isolate --gtest_filter=$GTEST_FILTER
