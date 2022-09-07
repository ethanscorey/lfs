#!/bin/bash
export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=$1

source install-development-packages.sh

if [ "$LFS_DISK" == "" ]; then
    echo "Must provide value for LFS_DISK"
    exit 1
fi

# If disks aren't formatted and mounted, then set up and mount disks
if ! [ -e $(echo $LFS_DISK)p3 ]; then
    source setup-disk.sh $LFS_DISK
fi
if ! grep -q "$LFS" /proc/mounts; then
    sudo mkdir -pv $LFS
    sudo mount -v -t ext4 "$(echo $LFS_DISK)p3" "$LFS"
    sudo mkdir -pv $LFS/home
    sudo mount -v -t ext4 "$(echo $LFS_DISK)p4" "$LFS/home"
    sudo /sbin/swapon "$(echo $LFS_DISK)p2"
fi
if ! grep -q "$LFS" /proc/mounts; then
    echo "$LFS_DISK failed to mount."
    exit 1
fi
sudo chown -R lfs:lfs $LFS

# Download package sources and patches
mkdir -pv $LFS/sources
chmod -v a+wt $LFS/sources
source download-packages.sh $LFS/sources

# Create directories for build
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}
for i in bin lib sbin; do
	ln -svf usr/$i $LFS/$i
done
case $(uname -m) in
    x86_64) mkdir -pv $LFS/lib64 ;;
esac
mkdir -pv $LFS/tools
