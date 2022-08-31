export LFS=/mnt/LFS
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=$1

if ! grep -q "$LFS" /proc/mounts; then
	source setup-disk.sh "$LFS_DISK"
	mount "$(LFS_DISK)p3" "$LFS"
	/sbin/swapon "$(LFS_DISK)p2"
fi

mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources
wget https://www.linuxfromscratch.org/lfs/view/stable/wget-list
sed -e "s/https:\/\/zlib\.net\/zlib-1\.2\.11\.tar\.xz/https:\/\/zlib.net\/zlib-1.2.12.tar.xz/" -i wget-list
wget --input-file=wget-list --continue --directory-prefix=$LFS/sources
wget https://www.linuxfromscratch.org/lfs/view/stable/md5sums --directory-prefix=$LFS/sources
sed -e "s/^.\+zlib-1\.2\.11\.tar\.xz//" -i $LFS/sources/md5sums
pushd $LFS/sources
    #md5sum -c md5sums
popd
