#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update -y && apt-get upgrade -y && \
    apt-get install -y make build-essential git wget gcc-7-plugin-dev gnupg lsb-release software-properties-common

# Current recommended LLVM version is 16
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
./llvm.sh 16
rm -f llvm.sh

apt-get install -y libc++-16-dev libc++abi-16-dev

apt-get clean -y


