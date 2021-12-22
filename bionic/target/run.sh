#!/bin/sh

PATH_TESTBIN=/data/nativetest64/bionic-unit-tests-static/bionic-unit-tests-static

PATTERNS="\
-setjmp_DeathTest.*\
:clang_fortify_test_1_DeathTest.string:clang_fortify_test_2_DeathTest.string\
:fdsan.vfork\
:fdtrack.accept:fdtrack.accept4\
:glob.glob_globbing_rsc\
:ifunc.function:ifunc.hwcap\
:malloc.mallinfo\
:android_mallopt.set_allocation_limit\
:netdb.gethostbyname_r:netdb.gethostbyname2_r:netdb.endhostent_resets:netdb.sethostent_resets\
:pthread.big_enough_signal_stack\
:setjmp.setjmp_smoke:setjmp._setjmp_smoke:setjmp._setjmp_signal_mask:setjmp.setjmp_signal_mask:setjmp.setjmp_fp_registers:setjmp.setjmp_stack:setjmp.bug_152210274\
:stack_unwinding.unwind_through_signal_frame:stack_unwinding.unwind_through_signal_frame_SA_SIGINFO\
:string_nofortify.memcpy:string_nofortify.memset:string_nofortify.memmove:string_nofortify.bcopy:string_nofortify.strcat_overread:string_nofortify.strlcat_overrea\
:stdio_ext.__fpurge\
:stdlib.mkostemp64:stdlib.mkostemp\
:unistd.execve_args:unistd.execl:unistd.execle:unistd.execv:unistd.fexecve_args\
:unistd.exec_argv0_null:unistd.execvpe_ENOEXEC:unistd.getpid_caching_and_pthread_create\
:unistd.clone_fn_and_exit:unistd.gettid_caching_and_clone:unistd.getpid_caching_and_clone\
:unistd.gettid_caching_and_clone_process_settid:unistd.gettid_caching_and_clone_process\
:unistd.getpid_caching_and_clone_process:unistd.getpid_caching_and_vfork\
:string.strchr_multiple:string.memcpy:string.memset:string.memmove:string.memmove_cache_size:string.bcopy:string.strlcat_overread:string.strcat_overread\
:time.timer_settime_0:time.timer_settime_repeats:time.timer_create_multiple:time.timer_disarm_terminates:time.timer_delete_terminates\
:unistd_nofortify.execve_args:unistd_nofortify.execl:unistd_nofortify.execle:unistd_nofortify.execv:unistd_nofortify.fexecve_args\
:unistd_nofortify.exec_argv0_null:unistd_nofortify.execvpe_ENOEXEC:unistd_nofortify.getpid_caching_and_pthread_create\
:unistd_nofortify.clone_fn_and_exit:unistd_nofortify.gettid_caching_and_clone:unistd_nofortify.getpid_caching_and_clone\
:unistd_nofortify.gettid_caching_and_clone_process_settid:unistd_nofortify.gettid_caching_and_clone_process\
:unistd_nofortify.getpid_caching_and_clone_process:unistd_nofortify.getpid_caching_and_vfork\
:elftls.tprel_addend\
:threads.thrd_sleep_signal:threads.thrd_sleep_signal_nullptr\
:stdio_nofortify.fwrite_after_fread_slow_path:stdio_nofortify.fwrite_after_fread_fast_path:stdio_nofortify.lots_of_concurrent_files\
:stdio_nofortify.seek_tell_family_smoke:stdio_nofortify.fseek_fseeko_EINVAL:stdio_nofortify.fopen_append_mode_and_ftell\
:stdio_nofortify.freopen_append_mode_and_ftell:stdio_nofortify.fseek_overflow_32bit\
:stdio.fwrite_after_fread_slow_path:stdio.fwrite_after_fread_fast_path:stdio.lots_of_concurrent_files\
:stdio.seek_tell_family_smoke:stdio.fseek_fseeko_EINVAL:stdio.fopen_append_mode_and_ftell\
:stdio.freopen_append_mode_and_ftell:stdio.fseek_overflow_32bit\
:fenv.*
"

# FIXME:
# disable fenv, due to I found if we run this suite, other suites after it will be run twice
#
# Some cases are ignored just due to they cost too long time, such as:
# string.strchr_multiple:string.memcpy:string.memset:string.memmove:string.memmove_cache_size:string.bcopy:string.strlcat_overread:string.strcat_overread
# string_nofortify.memcpy:string_nofortify.memset:string_nofortify.memmove:string_nofortify.bcopy:string_nofortify.strcat_overread:string_nofortify.strlcat_overrea
#
# following cases will trigger SIGABORT in batch, but not in single run, TBD 
# stdio_nofortify.*, stdio.* in upon PATTERNS

if [ $# -ne 0 ]; then
    PATTERNS=$1
fi
#echo $PATTERNS

$PATH_TESTBIN --no_isolate --gtest_filter=$PATTERNS

