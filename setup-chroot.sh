#!/bin/bash
# Set up the chroot environment
export LFS=$1
if [ "$LFS" == ""]; then
    echo "LFS is not defined."
    exit 1
fi
chown -R root:root $LFS/{usr,lib,var,etc,bin,sbin,tools}
case $(uname -m) in
	x86_64) chown -R root:root $LFS/lib64 ;;
esac
mkdir -pv $LFS/{dev,proc,sys,run}
mount -v --bind /dev $LFS/dev
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmps $LFS/run
if [ -h $LFS/dev/shm ]; then
	mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi
chmod ugo+x inside-chroot.sh
chmod ugo+x inside-chroot2.sh
mkdir -pv $LFS/sources/lfs
cp -rf . $LFS/sources/lfs
for script in "inside-chroot.sh" "inside-chroot2.sh"; do
    chroot "$LFS" /usr/bin/env -i \
        HOME=/root \
        TERM="$TERM" \
        PS1='(lfs chroot) \u:\w$ ' \
        PATH=/usr/bin:/usr/sbin \
        /bin/bash --login +h -c /sources/$script
