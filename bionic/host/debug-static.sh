#!/bin/bash

# debug bionic-unit-tests-static

BASE_DIR=$(cd $(dirname $0); pwd -P)
#echo $BASE_DIR

#PATH_BIN=$BASE_DIR/../../../../out/soong/.intermediates/bionic/tests/bionic-unit-tests-static/android_riscv64/unstripped/bionic-unit-tests-static
PATH_BIN=$BASE_DIR/../../../../out/target/product/generic_riscv64/symbols/data/nativetest64/bionic-unit-tests-static/bionic-unit-tests-static

GTEST_FILTER=$1

qemu-riscv64 -g 1234  $PATH_BIN --no_isolate --gtest_filter=$GTEST_FILTER &
riscv64-unknown-linux-gnu-gdb $PATH_BIN -x ./gdbinit

