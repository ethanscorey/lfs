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
    readline \
    bc \
    flex \
    tcl \
    expect \
    dejagnu \
    binutils \
    gmp \
    mpfr \
    mpc \
    attr \
    acl \
    ; do
    source /sources/lfs/compile-package.sh 8 $package
done
popd
