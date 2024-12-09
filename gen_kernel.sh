#!/bin/bash

HOME_DIR=$(pwd)
KERNEL_VER=5.15.173
KERNEL_URL="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$KERNEL_VER.tar.xz"

mkdir $HOME_DIR/mini_linux

WORK_DIR=$HOME_DIR/mini_linux

# Check root
if ! [ $(id -u) = 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

cd $WORK_DIR || exit 1

wget $KERNEL_URL

tar -xvf linux-$KERNEL_VER.tar.xz

KERNEL_DIR=$WORK_DIR/linux-$KERNEL_VER

cd $KERNEL_DIR || exit 1

if ! [ -f $HOME_DIR/kernel.config ]; then
    echo "Please make sure kernel.config is located in $HOME_DIR"
    exit 1
else
    cp $HOME_DIR/kernel.config .config
fi

make -j 4
