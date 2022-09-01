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

# Download package sources and patches
mkdir -pv $LFS/sources
chmod -v a+wt $LFS/sources
if ! [ -e ./wget-list ]; then
	wget https://www.linuxfromscratch.org/lfs/view/stable/wget-list
	sed -e "s/https:\/\/zlib\.net\/zlib-1\.2\.11\.tar\.xz/https:\/\/zlib.net\/zlib-1.2.12.tar.xz/" -i wget-list
	wget --input-file=wget-list --continue --directory-prefix=$LFS/sources
	wget https://www.linuxfromscratch.org/lfs/view/stable/md5sums --directory-prefix=$LFS/sources
	sed -e "s/^.\+zlib-1\.2\.11\.tar\.xz//" -i $LFS/sources/md5sums
	pushd $LFS/sources
	    #md5sum -c md5sums
	popd
fi

# Create directories for build
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}
for i in bin lib sbin; do
	ln -svf usr/$i $LFS/$i
done
if echo $LFS_TGT | grep -qs '64'; then
	mkdir -pv $LFS/lib64
fi
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
if echo $LFS_TGT | grep -qs '64'; then 
	chown -v lfs $LFS/lib64 
fi
fi
su - lfs
