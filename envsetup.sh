#!/bin/bash

if [[ -z "${ANDROID_BUILD_TOP}" ]]; then
  echo "AOSP env has not been setup, which is required for riscv test!!!"
  exit 1
else
  echo "ANDROID_BUILD_TOP:${ANDROID_BUILD_TOP}"
fi

PATH_BASE=$ANDROID_BUILD_TOP/test/test-riscv
export PATH_BASE

PATH_QEMU_BIN=/home/u/bin/qemu/bin
if [[ -z "${PATH_QEMU_BIN}" ]]; then
  echo "PATH_QEMU_BIN has not been setup, which is required for riscv test!!!"
  exit 1
else
  export PATH_QEMU_BIN
fi

PATH_GNUTOOLS_BIN=/home/u/bin/riscv/bin
if [[ -z "${PATH_GNUTOOLS_BIN}" ]]; then
  echo "PATH_GNUTOOLS_BIN has not been setup, which is required for riscv test!!!"
  exit 1
else
  export PATH_GNUTOOLS_BIN
fi

export PATH="$PATH_QEMU_BIN:$PATH"

