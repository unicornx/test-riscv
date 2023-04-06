#!/bin/bash

source $ANDROID_BUILD_TOP/test/test-riscv/bionic/host/.envsetup

COMMAND_QEMU="$PATH_EXE_STATIC --no_isolate --gtest_filter=$GTEST_FILTER"

source $TEST_RISCV/bionic/host/.run.exec



