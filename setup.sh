#!/bin/bash
export LFS=/mnt/LFS
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=$1
export LFS_USER_PW=$2

source install-development-packages.sh

if [ "$LFS_DISK" == "" ]; then
    echo "Must provide value for LFS_DISK"
    exit 1
fi

# If disks aren't formatted and mounted, then set up and mount disks
if ! [ -e $(echo $LFS_DISK)p3 ]; then
    source setup-disk.sh "$LFS_DISK"
fi
if ! grep -q "$LFS" /proc/mounts; then
	mount "$(echo $LFS_DISK)p3" "$LFS"
	/sbin/swapon "$(echo $LFS_DISK)p2"
fi
if ! [ -e $(echo $LFS_DISK)p3 ]; then
    echo "$LFS_DISK failed to mount."
    exit 1
fi

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

# Add the LFS user if it doesn't exist and give ownership of files
if ! grep -q lfs /etc/passwd; then
	addgroup lfs
	adduser -s /bin/bash -G lfs -h /home/lfs -k /dev/null lfs
	passwd lfs << EOF
$LFS_USER_PW
$LFS_USER_PW
EOF
chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools,sources}
case $(uname -m) in
    x86_64) chown -v lfs $LFS/lib64 ;;
esac
fi
#su - lfs
