VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/mpc-$VERSION
make
make html
make check
make install
make install-html
