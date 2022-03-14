#!/bin/sh

PATH_TESTBIN=/data/nativetest64/bionic-unit-tests-static/bionic-unit-tests-static

# we ignore those cases which will make running blocked/long-running-time
# but leave those cases may fail running or crash
PATTERNS="\
-\
:string_nofortify.memcpy:string_nofortify.memset:string_nofortify.memmove:string_nofortify.bcopy:string_nofortify.strlcat_overread:string_nofortify.strcat_overread\
:string.memcpy:string.memset:string.memmove:string.bcopy:string.strlcat_overread:string.strcat_overread\
"

# FIXME:
#
# Some cases are ignored just due to they cost too long time, such as:
# [  SLOW    ] string_nofortify.memcpy (27730 ms, exceeded 2000 ms)
# [  SLOW    ] string_nofortify.memset (31369 ms, exceeded 2000 ms)
# [  SLOW    ] string_nofortify.memmove (63412 ms, exceeded 2000 ms)
# [  SLOW    ] string_nofortify.bcopy (61589 ms, exceeded 2000 ms)
# [  SLOW    ] string_nofortify.strlcat_overread (18611 ms, exceeded 2000 ms)
# [  SLOW    ] string_nofortify.strcat_overread (17586 ms, exceeded 2000 ms)
#
# [  SLOW    ] string.memcpy (27700 ms, exceeded 2000 ms)
# [  SLOW    ] string.memset (31375 ms, exceeded 2000 ms)
# [  SLOW    ] string.memmove (63300 ms, exceeded 2000 ms)
# [  SLOW    ] string.bcopy (61312 ms, exceeded 2000 ms)
# [  SLOW    ] string.strcat_overread (18072 ms, exceeded 2000 ms)
# [  SLOW    ] string.strlcat_overread (18635 ms, exceeded 2000 ms)


if [ $# -ne 0 ]; then
    PATTERNS=$1
fi

$PATH_TESTBIN --gtest_filter=$PATTERNS

