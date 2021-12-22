#!/bin/bash

GTEST_FILTER=$1

qemu-riscv64 -g 1234 /home/u/ws/dev-aosp12/out/soong/.intermediates/bionic/tests/bionic-unit-tests-static/android_riscv64/unstripped/bionic-unit-tests-static --no_isolate --gtest_filter=$GTEST_FILTER &
riscv64-unknown-linux-gnu-gdb /home/u/ws/dev-aosp12/out/soong/.intermediates/bionic/tests/bionic-unit-tests-static/android_riscv64/unstripped/bionic-unit-tests-static -x ./gdbinit

