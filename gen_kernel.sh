#!/bin/bash

KERNEL_VER=5.15.173
KERNEL_URL="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$KERNEL_VER.tar.xz"

# Check root
if ! [ $(id -u) = 0 ]; then
    echo "Please run this script as root for disk image creation."
    exit 1
fi

# Download kernel
if ! [ -f linux-$KERNEL_VER.tar.xz ]; then
    echo "linux-$KERNEL_VER.tar.xz not detected. Initiating download..."
    wget $KERNEL_URL
    echo "Downloaded linux-$KERNEL_VER.tar.xz"
else
    echo "linux-$KERNEL_VER.tar.xz already detected. No need to download"
fi

tar xvf linux-$KERNEL_VER.tar.xz

cd linux-$KERNEL_VER || exit

cp -v /boot/config-$(uname -r) .config

scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
scripts/config --disable CONFIG_DEBUG_INFO_BTF

echo -ne "\n" | make -j4

