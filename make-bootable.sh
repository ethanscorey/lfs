#!/bin/bash
pushd /sources/lfs
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
popd
