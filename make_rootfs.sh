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

PATH_TEST_BIONIC=$PATH_PRJ/bionic/target

mkdir -p $PATH_OUT

rm -f $PATH_OUT/rootfs.img
echo "$PATH_OUT/rootfs.img is removed!"
echo ""

qemu-img create $PATH_OUT/rootfs.img 1g
chmod 666 $PATH_OUT/rootfs.img
mkfs.ext4 $PATH_OUT/rootfs.img
mkdir -p $PATH_OUT/rootfs
mount -o loop $PATH_OUT/rootfs.img  $PATH_OUT/rootfs

# rootfs layout
# ├── apex <--- copied from aosp out/target/product/generic_riscv64/apex/
# ├── bin -> /system/bin
# ├── data <- mounted as data partition, now created as folder
# ├── dev
# ├── etc -> /system/etc
# ├── init -> /system/bin/init (TBD)
# ├── linkerconfig/ld.config.txt <- create a dummy empty file
# ├── proc <-- new created
# ├── sbin <--- copied from busybox/_install/sbin
# ├── sys  <-- new created
# ├── system <-- copied from aosp out/target/product/generic_riscv64/system
# |   ├── apex
# |   ├── bin <--- copy files from busybox/_install/bin
# |   ├── etc
# |   ├── lib64
# |   ├── product
# |   ├── system_ext
# |   └── usr
# ├── tests <-- new created
# └── usr <--- copied from busybox/_install/usr

mkdir -p $PATH_OUT/rootfs
cd $PATH_OUT/rootfs \
    && cp -r $PATH_AOSP_OUT_TARGET_PRODUCT_RISCV64_APEX . \
    \
    && ln -s /system/bin bin \
    \
    && cp -r $PATH_AOSP_OUT_TARGET_PRODUCT_RISCV64_DATA . \
    && mkdir -p data/local/tmp \
    \
    && mkdir -p dev \
    \
    && ln -s /system/etc etc \
    \
    && mkdir -p proc \
    \
    && cp -r $PATH_BUSYBOX_INSTALL/sbin . \
    \
    && mkdir -p sys \
    \
    && cp -r $PATH_AOSP_OUT_TARGET_PRODUCT_RISCV64_SYSTEM . \
    && cp -r $PATH_BUSYBOX_INSTALL/bin ./system/ \
    && mkdir -p ./system/etc/init.d \
    \
    && mkdir -p tests/bionic \
    && cp $PATH_TEST_BIONIC/*.sh tests/bionic/ \
    \
    && cp -r $PATH_BUSYBOX_INSTALL/usr . \
    \
    && cp -r $PATH_BUSYBOX_INSTALL/linuxrc . \
    \
    && mkdir -p linkerconfig \
    && touch ./linkerconfig/ld.config.txt

cd $PATH_PRJ
touch $PATH_OUT/rootfs/system/etc/init.d/rcS
cat > $PATH_OUT/rootfs/system/etc/init.d/rcS <<EOF
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
/sbin/mdev -s
ln -sv /proc/self/fd/0 /dev/stdin
ln -sv /proc/self/fd/1 /dev/stdout
ln -sv /proc/self/fd/2 /dev/stderr
EOF
chmod +x $PATH_OUT/rootfs/system/etc/init.d/rcS

umount $PATH_OUT/rootfs
rmdir $PATH_OUT/rootfs

echo "$PATH_OUT/rootfs.img is created!"
