#!/bin/bash

GTEST_FILTER=$1


riscv64-unknown-linux-gnu-gdb /home/u/ws/dev-aosp12/out/soong/.intermediates/bionic/tests/bionic-unit-tests-static/android_riscv64/unstripped/bionic-unit-tests-static -x ./test-scripts/gdbinit


