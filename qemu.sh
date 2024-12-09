#!/bin/bash

HOME_DIR=$(pwd)
WORK_DIR=$HOME_DIR/mini_linux
KERNEL_DIR=$WORK_DIR/linux-5.15.173
INITRAMFS_DIR=$WORK_DIR/rootfs

# Check if running as root
if ! [ $(id -u) = 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

qemu-system-x86_64 \
    -kernel $KERNEL_DIR/arch/x86_64/boot/bzImage \
    -initrd $INITRAMFS_DIR/initramfs.cpio.gz \
    -append "init=/bin/sh console=ttyS0" \
    -nographic
