#!/bin/bash

# Check if running as root
if ! [ $(id -u) = 0 ]; then
    echo "Please run this script as root for disk image creation."
    exit 1
fi

# Version Control
apt install -y git

# Building Kernel
apt install -y fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison zstd

# QEMU
apt install -y qemu qemu-utils qemu-sysyem-x86
apt install -y build-essential lzop libncurses-dev
