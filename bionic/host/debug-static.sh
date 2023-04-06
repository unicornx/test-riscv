#!/bin/bash

# debug bionic-unit-tests-static

source $ANDROID_BUILD_TOP/test/test-riscv/bionic/host/.envsetup

# we have to use --no_isolate on host due to we lack the same rootfs env as that on target

COMMAND_QEMU="$PATH_EXE_STATIC --no_isolate --gtest_filter=$GTEST_FILTER"

DEBUG=yes
COMMAND_GDB="$PATH_EXE_STATIC"

source $TEST_RISCV/bionic/host/.run.exec
