# Bootable Linux image via QEMU
**(Tested on Ubuntu 20.04 LTS)**

Please ensure that [kernel.config](https://github.com/charlesvt/hello-world-QEMU/blob/debug/kernel.config) and [busybox.config](https://github.com/charlesvt/hello-world-QEMU/blob/debug/busybox.config) are located within the same directory as the other shell scripts. Please run the scripts as root (```sudo sh "shellscript.sh"```). The following steps outline the execution order of the scripts

1. [install_dep.sh](https://github.com/charlesvt/hello-world-QEMU/blob/debug/install_dep.sh)
    - Installs all relevant dependencies that are needed for execution:
        - git
        - fakeroot, ncurses-dev, libssl-dev, bc, libelf-dev, zstd
        - build-essential, flex, lzop, libncurses-dev, bison, xz-utils
        - qemu, qemu-system-x86
2. [gen_kernel.sh](https://github.com/charlesvt/hello-world-QEMU/blob/debug/gen_kernel.sh)
    - Downloads and extracts the kernel version indicated in the script
    - Builds a minimal kernel using the custom kernel.config file
3. [gen_disk.sh](https://github.com/charlesvt/hello-world-QEMU/blob/debug/gen_disk.sh)
    - Uses BusyBox to build a root filesystem for the linux system based on busybox.config 
    - Creates a initramfs to allow filesystem to mount hard disk on root 
    - Creates init that will execute immediately after bootloader completion
4. [qemu.sh](https://github.com/charlesvt/hello-world-QEMU/blob/debug/qemu.sh)
    - Runs the minimal linux environment via QEMU using custom built kernel, initramfs, append serial terminal, and nographic options
