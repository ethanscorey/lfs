#!/bin/bash
if [ "$LFS" == "" ]; then
    echo "LFS not defined"
    exit i
fi
sudo umount $LFS/dev/pts
sudo umount $LFS/{sys,proc,run,dev}
pushd $LFS
tar -cJpf $HOME/lfs-temp-tools-11.2.tar.xz .
popd
sudo mount -v --bind /dev $LFS/dev
sudo mount -v --bind /dev/pts $LFS/dev/pts
sudo mount -vt proc proc $LFS/proc
sudo mount -vt sysfs sysfs $LFS/sys
sudo mount -vt tmpfs tmps $LFS/run
if [ -h $LFS/dev/shm ]; then
	mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi
