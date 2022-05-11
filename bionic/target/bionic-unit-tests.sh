#!/bin/sh

PATH_TESTBIN=/data/nativetest64/bionic-unit-tests/bionic-unit-tests

# we use an empty ld.config.txt, but we use LD_LIBRARY_PATH to help linker
# to serach for the .so files
# search /apex/com.android.i18n/lib64/ for libicu.so
export LD_LIBRARY_PATH=/system/lib64/bootstrap:/apex/com.android.i18n/lib64
if [ $# -ne 0 ]; then
    $PATH_TESTBIN --gtest_filter=$1
else
    $PATH_TESTBIN
fi


