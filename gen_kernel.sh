#!/bin/bash

WORK_DIR=$(pwd)
KERNEL_VER=5.15.173
KERNEL_URL="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$KERNEL_VER.tar.xz"

# Check root
if ! [ $(id -u) = 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

mkdir $WORK_DIR/kernel
KERNEL_DIR=$WORK_DIR/kernel

cd $KERNEL_DIR || exit 1

wget $KERNEL_URL

tar -xvf linux-$KERNEL_VER.tar.xz

cd linux-$KERNEL_VER || exit 1

cp $WORK_DIR/helloWorld.config .config

make -j 4
