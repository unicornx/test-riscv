#!/bin/bash

# debug dynamic linker

BASE_DIR=$(cd $(dirname $0); pwd -P)
#echo $BASE_DIR


PATH_BIN=$BASE_DIR/../../../../out/target/product/generic_riscv64/symbols/system/bin/bootstrap/linker64

qemu-riscv64 -g 1234 $PATH_BIN &
riscv64-unknown-linux-gnu-gdb $PATH_BIN -x ./gdbinit

