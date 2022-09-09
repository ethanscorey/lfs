DIRNAME=$1
pushd $DIRNAME
./configure \
    --prefix=/usr \
    --disable-static \
    --enable-libgdbm-compat
make
make check
make install
popd
