DIRNAME=$1
pushd $DIRNAME
./configure --prefix=/usr
make
make check
make install
popd
