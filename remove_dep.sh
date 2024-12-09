#!/bin/bash

# Check if running as root
if ! [ $(id -u) = 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

# Version Control
apt remove -y git

# Building Kernel
apt remove -y fakeroot ncurses-dev libssl-dev bc  libelf-dev zstd
apt remove -y build-essential flex lzop libncurses-dev bison xz-utils

# QEMU
apt remove -y qemu qemu-sysyem-x86

