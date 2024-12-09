#!/bin/bash

# Check if running as root
if ! [ $(id -u) = 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

# Version Control
apt install -y git

# Building Kernel
apt install -y fakeroot ncurses-dev libssl-dev bc  libelf-dev zstd
apt install -y build-essential flex lzop libncurses-dev bison xz-utils

# QEMU
apt install -y qemu qemu-system-x86

