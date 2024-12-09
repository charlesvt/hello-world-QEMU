#!/bin/bash

HOME_DIR=$(pwd)
WORK_DIR=$HOME_DIR/mini_linux
KERNEL_DIR=$WORK_DIR/linux-5.15.173
BUSYBOX_VER=1.37.0
BUSYBOX_URL="https://www.busybox.net/downloads/busybox-$BUSYBOX_VER.tar.bz2"

# Check if running as root
if ! [ $(id -u) = 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

cd $WORK_DIR || exit 1

wget $BUSYBOX_URL

tar -xvf busybox-$BUSYBOX_VER.tar.bz2

BUSYBOX_DIR=$WORK_DIR/busybox-$BUSYBOX_VER
cd $BUSYBOX_DIR || exit 1

if ! [ -f $HOME_DIR/busybox.config ]; then
    echo "Please make sure busybox.config is located in $HOME_DIR"
    exit 1
else
    cp $HOME_DIR/busybox.config .config
fi

make -j 4

make install

cd $WORK_DIR || exit 1

mkdir $WORK_DIR/rootfs 
INITRAMFS_DIR=$WORK_DIR/rootfs

cd $INITRAMFS_DIR

mkdir -p $INITRAMFS_DIR/etc $INITRAMFS_DIR/proc $INITRAMFS_DIR/sys $INITRAMFS_DIR/dev
cp -a $BUSYBOX_DIR/_install/* .

touch init

chmod -R a+rw $WORK_DIR

cat << EOF >> init
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
cat <<!
hello world
!
exec /bin/sh
EOF

chmod -R a+rw $WORK_DIR

chmod a+x init

find . -print0 | cpio --null -ov --format=newc | gzip -9 > initramfs.cpio.gz
