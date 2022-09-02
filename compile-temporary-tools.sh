for package in \
    m4 \
    ncurses \
    bash \
    coreutils \
    diffutils \
    file \
    findutils \
    gawk \
    grep \
    gzip \
    make \
    patch \
    sed \
    tar \
    xz \
    binutils \
    gcc; do
    source ./compile-package.sh 6 $package
done
