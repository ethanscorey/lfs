DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configre \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/xz-$VERSION
make
make check
make install
popd
