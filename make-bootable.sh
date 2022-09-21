#!/bin/bash
export LFS_DISK=$1
pushd /sources/lfs
VERSION=$(ls /sources/linux*.tar.xz | sed "s/\.tar\.xz//" | cut -d"-" -f2)
cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system                mount-point  type     options             dump  fsck
#                                                                            order

/dev/$(echo $LFS_DISK)p3     /            ext4     defaults            1     1
/dev/$(echo $LFS_DISK)p2     swap         swap     pri=1               0     0
/dev/$(echo $LFS_DISK)p4     /home        ext4     default             0     0
proc                         /proc        proc     nosuid,noexec,nodev 0     0
sysfs                        /sys         sysfs    nosuid,noexec,nodev 0     0
devpts                       /dev/pts     devpts   gid=5,mode=620      0     0
tmpfs                        /run         tmpfs    defaults            0     0
devtmpfs                     /dev         devtmpfs mode=0755,nosuid    0     0

# End /etc/fstab
EOF
source /sources/lfs/compile-package.sh 10 linux
grub-install --target i386-pc /dev/$LFS_DISK
cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod ext2
set root=(hd0,2)

menuentry "GNU/Linux, Linux $VERSION-lfs-11.2" {
        linux   /boot/vmlinuz-$VERSION-lfs-11.2 root=$(echo $LFS_DISK)p3 ro
}
EOF
echo 11.2 > /etc/lfs-release
cat > /etc/lsb-release << "EOF"
DISTRIB_ID="Linux From Scratch"
DISTRIB_RELEASE="11.2"
DISTRIB_CODENAME="Ethan"
DISTRIB_DESCRIPTION="Linux From Scratch"
EOF
cat > /etc/os-release << "EOF"
NAME="Linux From Scratch"
VERSION="11.2"
ID=lfs
PRETTY_NAME="Linux From Scratch 11.2"
VERSION_CODENAME="Ethan"
EOF
popd
