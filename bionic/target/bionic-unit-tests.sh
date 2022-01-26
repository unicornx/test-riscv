#!/bin/sh

PATH_TESTBIN=/data/nativetest64/bionic-unit-tests/bionic-unit-tests

# we ignore those cases which will make running blocked/long-running-time
# but leave those cases may fail running or crash
PATTERNS="\
-\
:fenv.feenableexcept_fegetexcept\
:string_nofortify.memcpy:string_nofortify.memset:string_nofortify.memmove:string_nofortify.bcopy:string_nofortify.strlcat_overread:string_nofortify.strcat_overread\
:string.memcpy:string.memset:string.memmove:string.bcopy:string.strlcat_overread:string.strcat_overread\
:string.memmove_cache_size:string.strchr_multiple\
"

# FIXME:
# disable fenv.feenableexcept_fegetexcept, due to I found if we run this suite, other suites after it will be run twice
#
# Some cases are ignored just due to they cost too long time, such as:
# [       OK ] string_nofortify.memcpy (23709 ms)
# [       OK ] string_nofortify.memset (26896 ms)
# [       OK ] string_nofortify.memmove (53577 ms)
# [       OK ] string_nofortify.bcopy (51899 ms)
# [       OK ] string_nofortify.strcat_overread (17148 ms)
# upon 5 cases the same for string
# string.memmove_cache_size:string.strchr_multiple only slow for string, but not for string_nofortify, don't know why


if [ $# -ne 0 ]; then
    PATTERNS=$1
fi

# we use an empty ld.config.txt, but we use LD_LIBRARY_PATH to help linker
# to serach for the .so files
# search /apex/com.android.i18n/lib64/ for libicu.so
LD_LIBRARY_PATH=/system/lib64/bootstrap:/apex/com.android.i18n/lib64 \
$PATH_TESTBIN --gtest_filter=$PATTERNS

