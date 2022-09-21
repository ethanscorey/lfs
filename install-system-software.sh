#!/bin/bash
export LFS=$1
if [ "$LFS" == "" ]; then
    echo "LFS is not defined."
    exit 1
fi
for script in \
    "chapter8/install-packages.sh" \
    "installation-cleanup.sh" \
    "system-config.sh"; do
    ./run-in-chroot.sh $LFS $script
