
# Precondition

## Hardware environment

This experiment is based on Ubuntu 18.04 LTS.

```
$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 18.04.6 LTS
Release:        18.04
Codename:       bionic
$ uname -a
Linux u-OptiPlex-7080 5.4.0-91-generic #102~18.04.1-Ubuntu SMP Thu Nov 11 14:46:36 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
```

## software dependencies

```
$ sudo apt install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev \
                 gawk build-essential bison flex texinfo gperf libtool patchutils bc \
                 zlib1g-dev libexpat-dev git \
                 libglib2.0-dev libfdt-dev libpixman-1-dev \
                 libncurses5-dev libncursesw5-dev libssl-dev
```
# compile tools

# qemu

# kernel

Download Android kernel source code:

```
$ git clone https://android.googlesource.com/kernel/common
$ cd common
$ git checkout 5.10-android12-9
```

Download Android kernel configuration:
```
$ git clone https://android.googlesource.com/kernel/configs
$ cd configs
$ git checkout android-12.0.0_r3
```

Merge config and build kernel:
```
$ cd common
$ make ARCH=riscv distclean
$ ARCH=riscv ./scripts/kconfig/merge_config.sh arch/riscv/configs/defconfig ../configs/android-5.10/android-base.config
$ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- -j $(nproc)
```

# rootfs

Download busybox:
```
$ git clone git@github.com:mirror/busybox.git
```

Configure busybox
```
$ cd busybox
$ CROSS_COMPILE=riscv64-unknown-linux-gnu- make menuconfig
```

Open the configuration menu and enter "Settings" on the first line. In the "Build Options" section, select "Build static binary (no shared libs)", and exit to save the configuration after setting.

Build:
```
$ CROSS_COMPILE=riscv64-unknown-linux-gnu- make -j $(nproc)
$ CROSS_COMPILE=riscv64-unknown-linux-gnu- make install
```
At this time, observe that a new `_install` directory appears under the source code directory busybox, and you can see the generated things.
```
$ ls _install
bin  linuxrc  sbin  usr
```

Make a minial rootfs:

Goto test folder for riscv, assume $AOSP points to the AOSP source tree folder.
```
$ cd $AOSP/test/riscv
$ sudo ./mkrootfs.sh
```

rootfs.img will be created under out directory.
```
$ cd $AOSP/test/riscv
$ ls out
rootfs.img
```

Launch the minial system with qemu
```
$ cd $AOSP/test/riscv
$ ./run.sh
```
