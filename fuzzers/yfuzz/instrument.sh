#!/bin/bash
set -e

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
# - env TARGET: path to target work dir
# - env MAGMA: path to Magma support files
# - env OUT: path to directory where artifacts are stored
# - env CFLAGS and CXXFLAGS must be set to link against Magma instrumentation
##

export AFL_PATH="$FUZZER/repo/"
export CC="$FUZZER/repo/afl-clang-fast"
export CXX="$FUZZER/repo/afl-clang-fast++"
export AS="/usr/bin/llvm-as-16"
export AR="/usr/bin/llvm-ar-16"
export RANLIB="/usr/bin/llvm-ranlib-16"

export LIBS="$LIBS $FUZZER/repo/utils/aflpp_driver/libAFLDriver.a"

export AFL_YFUZZ=1
export AFL_USE_ASAN=1

# TODO: enable if that does failed
# php compiles with stdc++ so we must force this :-(
#export CXXFLAGS="$CXXFLAGS -stdlib=libstdc++"
#export CXXFLAGS_REQUIRED=-stdlib=libstdc++

# Build the AFL-only instrumented version
(
    export OUT="$OUT/afl"
    export LDFLAGS="$LDFLAGS -L$OUT"

    "$MAGMA/build.sh"
    "$TARGET/build.sh"
)

# TODO: we can do parallel fuzzing here, see how aflplusplus/instrument.sh does it

# NOTE: We pass $OUT directly to the target build.sh script, since the artifact
#       itself is the fuzz target. In the case of Angora, we might need to
#       replace $OUT by $OUT/fast and $OUT/track, for instance.

