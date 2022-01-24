#!/bin/bash

# debug bionic-unit-tests

source ./.envsetup

COMMAND_QEMU="$PATH_EXE --no_isolate --gtest_filter=$GTEST_FILTER"

DEBUG=yes
COMMAND_GDB="$PATH_EXE"

source ./.run.exec

