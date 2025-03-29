#!/bin/bash
set -e

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
##

git clone --no-checkout https://github.com/AFLplusplus/AFLplusplus "$FUZZER/repo"
git -C "$FUZZER/repo" checkout 9cac7ced05eb9f36c1d0b02ad594b3b09cd3938b


# TODO:
#   - set `__afl_sharedmem_fuzzing = 0`
#     - why?
#   - set `static volatile char AFL_PERSISTENT[] = "##SIG_AFL_NOT_PERSISTENT##";`
#     - why?
#   - try to build it first, if failed, examine aflplusplus and FOX artifact aflplusplus_asan_baseline to debug it
