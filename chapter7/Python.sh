DIRNAME=$1
pushd $DIRNAME
./configure --prefix=/usr \
    --enabled-shared \
    --without-ensurepip

make
make install
popd
