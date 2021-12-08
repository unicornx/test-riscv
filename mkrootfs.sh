#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Please try again with \"sudo $0\"." 1>&2
   exit 1
fi

PATH_PRJ=`pwd`

source $PATH_PRJ/envsetup

PATH_OUT=$PATH_PRJ/out

mkdir -p $PATH_OUT 

rm -f $PATH_OUT/rootfs.img
qemu-img create $PATH_OUT/rootfs.img 1g
chmod 666 $PATH_OUT/rootfs.img
mkfs.ext4 $PATH_OUT/rootfs.img
mkdir -p $PATH_OUT/rootfs
mount -o loop $PATH_OUT/rootfs.img  $PATH_OUT/rootfs
cd $PATH_OUT/rootfs && cp -r $PATH_BUSYBOX_INSTALL/* . && mkdir -p proc sys dev etc etc/init.d
cd $PATH_PRJ
touch $PATH_OUT/rootfs/etc/init.d/rcS
cat > $PATH_OUT/rootfs/etc/init.d/rcS <<EOF
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
/usr/bin/mdev -s
EOF
chmod +x $PATH_OUT/rootfs/etc/init.d/rcS
umount $PATH_OUT/rootfs
rmdir $PATH_OUT/rootfs
