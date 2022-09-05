DIRNAME=$1
pushd $DIRNAME
./configure --prefix=/usr
make
make install
popd
