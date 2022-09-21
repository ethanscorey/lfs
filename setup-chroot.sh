#!/bin/bash
export LFS=$1
if [ "$LFS" == "" ]; then
    echo "LFS is not defined."
    exit 1
fi
for script in \
    "lfs/inside-chroot.sh" \
    "lfs/inside-chroot2.sh" \
    "lfs/inside-chroot3.sh"; do
    ./run-in-chroot.sh $LFS $script
