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
    libcap \
    shadow \
    gcc; do
    source /sources/lfs/compile-package.sh 8 $package
done
if ! bash /sources/lfs/chapter8/sanity-check.sh; then
    echo "Failed sanity check"
    exit 1
fi
for package in \
    pkg-config \
    ncurses \
    sed \
    psmisc \
    gettext \
    bison \
    grep \
    bash \
    libtool \
    gdbm \
    gperf \
    expat \
    ; do
    source /sources/lfs/compile-package.sh 8 $package
done
popd
