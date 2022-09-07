#!/bin/bash
pushd /sources/lfs
for package in \
    man-pages \
    iana-etc \
    glibc \
    zlib \
    bzip2 \
    xz \
    zstd \
    file \
    readline; do
    source /sources/lfs/compile-package.sh 8 $package
done
popd
