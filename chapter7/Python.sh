DIRNAME=$1
pushd $DIRNAME
./configure --prefix=/usr \
    --enable-shared \
    --without-ensurepip

make
make install
popd
