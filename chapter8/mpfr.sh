VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configure \
    --prefix=/usr \
    --disable-static \
    --enable-thread-safe \
    --docdir=/usr/share/doc/mpfr-$VERSION
make
make html
make check
make install
make install-html
