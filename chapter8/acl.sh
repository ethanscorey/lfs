VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/acl-$VERSION
make
make install
