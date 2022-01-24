#!/bin/bash

# run linker directly

source ./.envsetup

COMMAND_QEMU="$PATH_LINKER $PATH_EXE --no_isolate --gtest_filter=$GTEST_FILTER"
#COMMAND_QEMU="$PATH_LINKER --list $PATH_EXE"

source ./.run.exec

