#!/bin/bash

# Check if running as root
if ! [ $(id -u) = 0 ]; then
    echo "Please run this script as root for disk image creation."
    exit 1
fi

# Version Control
apt remove -y git

# Building Kernel
apt remove -y fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison
