#!/bin/bash
if [ "$LFS" == "" ]; then
    echo "LFS not defined"
    exit i
fi
sudo umount $LFS/dev/pts
sudo umount $LFS/{sys,proc,run,dev}
cd $LFS
tar -cJpf $HOME/lfs-temp-tools-11.2.tar.xz .
