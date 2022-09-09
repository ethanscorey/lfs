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
    inet-utils \
    less \
    perl \
    XML-Parser \
    intltool \
    autoconf \
    automake \
    openssl \
    kmod \
    elfutils \
    libffi \
    Python \
    wheel \
    ninja \
    meson \
    coreutils \
    check \
    diffutils \
    gawk \
    findutils \
    groff \
    grub \
    gzip \
    iproute2 \
    kbd \
    libpipeline \
    make \
    patch \
    tar \
    texinfo \
    vim \
    eudev \
    man-db \
    procps-ng \
    util-linux \
    e2fsprogs \
    sysklogd \
    sysvinit; do
    source /sources/lfs/compile-package.sh 8 $package
done
popd
