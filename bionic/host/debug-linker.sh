#!/bin/bash

# debug dynamic linker

source ./.envsetup

COMMAND_QEMU="$PATH_LINKER $PATH_EXE --no_isolate --gtest_filter=$GTEST_FILTER"
#COMMAND_QEMU="$PATH_LINKER --list $PATH_EXE"

DEBUG=yes
COMMAND_GDB="$PATH_LINKER"

source ./.run.exec
