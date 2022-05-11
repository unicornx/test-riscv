#!/bin/sh

PATH_TESTBIN=/data/nativetest64/bionic-unit-tests-static/bionic-unit-tests-static

if [ $# -ne 0 ]; then
    $PATH_TESTBIN --gtest_filter=$1
else
    $PATH_TESTBIN
fi


