DIRNAME=$1
pushd $DIRNAME
./configure \
    --prefix=/usr \
    --disable-static \
    --with-gcc-arch=native \
    --disable-exec-static-tramp
make
make check
make install
popd
