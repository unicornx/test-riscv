#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Please try again with \"sudo $0\"." 1>&2
   exit 1
fi

if [ ! -f ./envsetup ]; then
    echo "Please double-check your working path."
    exit 1
fi
source ./envsetup

mkdir -p $PATH_OUT

if [ ! -f $PATH_OUT/rootfs.img ]; then
    echo "rootfs.img does not exist!"
    exit 1
fi

rm -rf $PATH_OUT/rootfs_dump
mkdir -p $PATH_OUT/rootfs
mount -o loop $PATH_OUT/rootfs.img  $PATH_OUT/rootfs
cp -r $PATH_OUT/rootfs $PATH_OUT/rootfs_dump
umount $PATH_OUT/rootfs
rmdir $PATH_OUT/rootfs
