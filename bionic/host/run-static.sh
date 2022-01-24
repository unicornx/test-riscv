#!/bin/bash

source ./.envsetup

COMMAND_QEMU="$PATH_EXE_STATIC --no_isolate --gtest_filter=$GTEST_FILTER"

source ./.run.exec



