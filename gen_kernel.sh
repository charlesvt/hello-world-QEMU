#!/bin/bash

WORK_DIR=$(pwd)
KERNEL_VER=5.15.173
KERNEL_URL="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$KERNEL_VER.tar.xz"

# Check root
if ! [ $(id -u) = 0 ]; then
    echo "Please run this script as root for disk image creation."
    exit 1
fi

mkdir $WORK_DIR/kernel
KERNEL_DIR=$WORK_DIR/kernel

cd $KERNEL_DIR || exit 1

# Download kernel
if ! [ -f linux-$KERNEL_VER.tar.xz ]; then
    echo "linux-$KERNEL_VER.tar.xz not detected. Initiating download..."
    wget $KERNEL_URL
    echo "Downloaded linux-$KERNEL_VER.tar.xz"
else
    echo "linux-$KERNEL_VER.tar.xz already detected. No need to download"
fi

tar xvf linux-$KERNEL_VER.tar.xz

cd linux-$KERNEL_VER || exit 1

make allnoconfig
