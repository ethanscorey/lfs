DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/gettext-$VERSION
make
make check
make install
chmod -v 0755 /usr/lib/preloadable_libintl.so
popd
