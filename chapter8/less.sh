DIRNAME=$1
pushd $DIRNAME
./configure --prefix=/usr --sysconfdir=/etc
make
make install
popd
