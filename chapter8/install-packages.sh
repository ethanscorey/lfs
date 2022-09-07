#!/bin/bash
pushd /sources/lfs
for package in \
    man-pages \
    iana-etc; do
    source /sources/lfs/compile-package.sh 8 $package
done
popd
