VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configure \
    --prefix=/usr \
    --disable-static \
    --sysconfdir=/etc \
    --docdir=/usr/share/doc/attr-$VERSION
make
make check
make install
