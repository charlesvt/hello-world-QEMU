#!/bin/bash

WORK_DIR=$(pwd)
BUSYBOX_VER=1.37.0
BUSYBOX_URL="https://www.busybox.net/downloads/busybox-$BUSYBOX_VER.tar.bz2"

# Check if running as root
if ! [ $(id -u) = 0 ]; then
    echo "Please run this script as root for disk image creation."
    exit 1
fi

wget $BUSYBOX_URL
