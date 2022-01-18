#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd -P)

PATH_BIN=$BASE_DIR/../../../../out/target/product/generic_riscv64/symbols/data/nativetest64/bionic-unit-tests-static/bionic-unit-tests-static
#PATH_BIN=/home/u/ws/aosp10-thead/bionic-unit-tests-static

GTEST_FILTER=$1

# we have to use --no_isolate on host due to we lack the same rootfs env as that on target
qemu-riscv64 $PATH_BIN --no_isolate --gtest_filter=$GTEST_FILTER

