#!/bin/bash

if ! [ -x "$(command -v mke2fs)" ]; then
  echo 'Error: mke2fs is not installed.' >&2
  exit 1
fi

if [ ! -f ./envsetup ]; then
    echo "Please double-check your working path."
    exit 1
fi
source ./envsetup

mkdir -p $PATH_OUT
PATH_IMAGE_FILE=$PATH_OUT/rootfs.img
rm -f $PATH_IMAGE_FILE
echo "$PATH_IMAGE_FILE is removed!"
echo ""

PATH_ROOT_DIR=$PATH_OUT/rootfs
mkdir -p $PATH_ROOT_DIR

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

PATH_TEST_BIONIC=$PATH_PRJ/bionic/target

cd $PATH_ROOT_DIR \
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
touch $PATH_ROOT_DIR/system/etc/init.d/rcS
cat > $PATH_ROOT_DIR/system/etc/init.d/rcS <<EOF
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
/sbin/mdev -s
ln -sv /proc/self/fd/0 /dev/stdin
ln -sv /proc/self/fd/1 /dev/stdout
ln -sv /proc/self/fd/2 /dev/stderr
EOF
chmod +x $PATH_ROOT_DIR/system/etc/init.d/rcS

# Create the rootfs image without sudo.
mke2fs \
  -d "$PATH_ROOT_DIR" \
  -t ext4 \
  "$PATH_IMAGE_FILE" \
  1g \
;

rm -rf $PATH_ROOT_DIR

echo "$PATH_IMAGE_FILE is created!"
