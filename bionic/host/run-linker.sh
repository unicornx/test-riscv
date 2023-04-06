#!/bin/bash

# run linker directly

source $ANDROID_BUILD_TOP/test/test-riscv/bionic/host/.envsetup

COMMAND_QEMU="$PATH_LINKER $PATH_EXE --no_isolate --gtest_filter=$GTEST_FILTER"
#COMMAND_QEMU="$PATH_LINKER --list $PATH_EXE"

source $TEST_RISCV/bionic/host/.run.exec

