#!/bin/bash
export LFS=$1
export SCRIPT=$2
shift
shift
if [ "$LFS" == "" ]; then
    echo "LFS is not defined."
    exit 1
fi
sudo chown -R root:root $LFS/{usr,lib,var,etc,bin,sbin}
case $(uname -m) in
	x86_64) sudo chown -R root:root $LFS/lib64 ;;
esac
sudo mkdir -pv $LFS/{dev,proc,sys,run}
if ! grep "$LFS/dev" /proc/mounts; then
    sudo mount -v --bind /dev $LFS/dev
fi
if ! grep "$LFS/dev/pts" /proc/mounts; then
    sudo mount -v --bind /dev/pts $LFS/dev/pts
fi
if ! grep "$LFS/proc" /proc/mounts; then
    sudo mount -vt proc proc $LFS/proc
fi
if ! grep "$LFS/sys" /proc/mounts; then
    sudo mount -vt sysfs sysfs $LFS/sys
fi
if ! grep "$LFS/run" /proc/mounts; then
    sudo mount -vt tmpfs tmps $LFS/run
fi
if [ -h $LFS/dev/shm ]; then
	sudo mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi
chmod ugo+x $SCRIPT
sudo mkdir -pv $LFS/sources/lfs
sudo cp -rf . $LFS/sources/lfs
sudo chroot "$LFS" /usr/bin/env -i \
	HOME=/root \
	TERM="$TERM" \
	PS1='(lfs  chroot) \u:\w$ ' \
	PATH=/usr/bin:/usr/sbin \
	/bin/bash --login +h -c "/sources/lfs/$SCRIPT $@"
sudo rm -rf $LFS/sources/lfs
sudo chown -R lfs:lfs $LFS/{usr,lib,var,etc,bin,sbin}
case $(uname -m) in
	x86_64) sudo chown -R lfs:lfs $LFS/lib64 ;;
esac
