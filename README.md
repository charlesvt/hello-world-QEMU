# Bootable Linux image via QEMU
**(Tested on Ubuntu 20.04 LTS)**
## Description
Creates and runs an AMD64 Linux filesystem image using QEMU that prints "hello world" on startup. The script should not require any user input and/or management other that root permission once script is run. Kernel version that is used in this scipt is 5.15.173 although that version can be changed in the script if desired.

## Dependencies
[run.sh](https://github.com/charlesvt/hello-world-QEMU/blob/master/run.sh) should automatically download all relevant dependencies that are needed for execution. For manual installation, please run the following script as root:
- ```sudo apt install git fakeroot, ncurses-dev libssl-dev bc libelf-dev zstd build-essential flex lzop libncurses-dev bison xz-utils qemu qemu-system-x86```

## Running Script
Please ensure that [kernel.config](https://github.com/charlesvt/hello-world-QEMU/blob/debug/kernel.config) and [busybox.config](https://github.com/charlesvt/hello-world-QEMU/blob/debug/busybox.config) are located within the same directory as the other shell scripts. Please run the script as root:
- ```sudo sh run.sh```

## Output
On successful execution, the AMD64 Linux filesystem image should display text-based messages the terminal. Running ```uname -snrmo``` on QEMU should confirm Kernel name, Host name, Kernel release, machine architecture, and operating system:
- ```Linux helloWorld 5.15.173 x86_64 GNU/Linux```

## References
- Shell script greatly inspired by [EmbeddedCraft's Bare-Minimum Linux on QEMU](https://www.youtube.com/watch?v=MBx3JPgHYfI).
