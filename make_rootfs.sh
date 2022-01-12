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
cd $PATH_OUT/rootfs \
   && cp -r $PATH_BUSYBOX_INSTALL/* . \
   && mkdir -p system proc sys dev etc etc/init.d \
   && cp -r ./bin ./system \
   && mkdir -p data/local/tmp \
   && cp -r $PATH_AOSP_OUT_TARGET_PRODUCT_RISCV64_DATA . \
   && mkdir -p tests/bionic \
   && cp $PATH_TEST_BIONIC/run.sh tests/bionic/
cd $PATH_PRJ
touch $PATH_OUT/rootfs/etc/init.d/rcS
cat > $PATH_OUT/rootfs/etc/init.d/rcS <<EOF
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
/sbin/mdev -s
ln -sv /proc/self/fd/0 /dev/stdin
ln -sv /proc/self/fd/1 /dev/stdout
ln -sv /proc/self/fd/2 /dev/stderr
EOF
chmod +x $PATH_OUT/rootfs/etc/init.d/rcS

umount $PATH_OUT/rootfs
rmdir $PATH_OUT/rootfs

echo "$PATH_OUT/rootfs.img is created!"