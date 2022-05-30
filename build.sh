#!/bin/bash

source build/envsetup.sh
lunch aosp_riscv64-eng
mmm bionic
mmm external/icu
mmm system/netd/client