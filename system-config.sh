#!/bin/bash
pushd /sources/lfs
source /sources/lfs/compile-package.sh 9 lfs-bootscripts
if ! [ -e /etc/modprob.d/blacklist.conf ]; then
    mkdir -pv /etc/modprob.d
    touch /etc/modprob.d/blacklist.conf
fi
echo "blacklist forte" >> /etc/modprob.d/blacklist.conf
bash /usr/lib/udev/init-net-rules.sh
NAME=$(cat /etc/udev/rules.d/70-persistent-net.rules | grep SUBSYSTEM | sed -e 's/^.*NAME="//' -e 's/"//')
echo $NAME
popd
