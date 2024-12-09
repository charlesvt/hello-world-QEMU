#!/bin/bash

WORK_DIR=$(pwd)
KERNEL_DIR=$WORK_DIR/kernel
BUSYBOX_VER=1.37.0
BUSYBOX_URL="https://www.busybox.net/downloads/busybox-$BUSYBOX_VER.tar.bz2"

# Check if running as root
if ! [ $(id -u) = 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

cd $KERNEL_DIR

wget $BUSYBOX_URL

tar -xvf busybox-$BUSYBOX_VER.tar.bz2

cd busybox-$BUSYBOX_VER


