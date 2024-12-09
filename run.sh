#!/bin/bash

HOME_DIR=$(pwd)
KERNEL_VER=5.15.173
KERNEL_URL="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$KERNEL_VER.tar.xz"
BUSYBOX_VER=1.37.0
BUSYBOX_URL="https://www.busybox.net/downloads/busybox-$BUSYBOX_VER.tar.bz2"

# Check if running as root
if ! [ $(id -u) = 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

mkdir $HOME_DIR/mini_linux

WORK_DIR=$HOME_DIR/mini_linux

# Version Control
apt install -y git

# Building Kernel
apt install -y fakeroot ncurses-dev libssl-dev bc  libelf-dev zstd
apt install -y build-essential flex lzop libncurses-dev bison xz-utils

# QEMU
apt install -y qemu qemu-system-x86

# Check root
if ! [ $(id -u) = 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

# Download and Build Kernel
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

# Download Busybox
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

# Creating initramfs disk
cd $WORK_DIR || exit 1

mkdir $WORK_DIR/rootfs 
INITRAMFS_DIR=$WORK_DIR/rootfs

cd $INITRAMFS_DIR || exit 1

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

chmod a+x init

chmod -R a+rw $WORK_DIR

find . -print0 | cpio --null -ov --format=newc | gzip -9 > initramfs.cpio.gz

# Boot Linux
qemu-system-x86_64 \
    -kernel $KERNEL_DIR/arch/x86_64/boot/bzImage \
    -initrd $INITRAMFS_DIR/initramfs.cpio.gz \
    -append "init=/bin/sh console=ttyS0" \
    -nographic

