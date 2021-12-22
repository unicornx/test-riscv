#!/bin/bash

if [ ! -f ./envsetup ]; then
    echo "Please double-check your working path."
    exit 1
fi
source ./envsetup

PATH_ROOTFS=$PATH_OUT/rootfs.img

if [ ! -f $PATH_ROOTFS ]; then
   echo "rootfs.img does not exist! Please run mkrootfs.sh first to create it before running."
   exit 1
fi

qemu-system-riscv64 -M virt -m 512M -nographic \
    -kernel ${PATH_KERNEL} \
    -drive file=${PATH_ROOTFS},format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0 \
    -append "root=/dev/vda rw console=ttyS0"
