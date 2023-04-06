#!/bin/bash

# debug bionic-unit-tests

source $ANDROID_BUILD_TOP/test/test-riscv/bionic/host/.envsetup

COMMAND_QEMU="$PATH_EXE --no_isolate --gtest_filter=$GTEST_FILTER"

DEBUG=yes
COMMAND_GDB="$PATH_EXE"

source $TEST_RISCV/bionic/host/.run.exec

