#!/bin/sh

PATH_TESTBIN=/data/nativetest64/bionic-unit-tests/bionic-unit-tests

# we ignore those cases which will make running blocked/long-running-time
# but leave those cases may fail running or crash
PATTERNS="\
-\
:string_nofortify.memcpy:string_nofortify.memset:string_nofortify.memmove:string_nofortify.bcopy:string_nofortify.strlcat_overread:string_nofortify.strcat_overread\
:string.memcpy:string.memset:string.memmove:string.bcopy:string.strlcat_overread:string.strcat_overread\
"

# FIXME:
# refer to ./bionic-unit-tests-static.sh for details for PATTERNS


if [ $# -ne 0 ]; then
    PATTERNS=$1
fi

# we use an empty ld.config.txt, but we use LD_LIBRARY_PATH to help linker
# to serach for the .so files
# search /apex/com.android.i18n/lib64/ for libicu.so
LD_LIBRARY_PATH=/system/lib64/bootstrap:/apex/com.android.i18n/lib64 \
$PATH_TESTBIN --gtest_filter=$PATTERNS

