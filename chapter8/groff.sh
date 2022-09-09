DIRNAME=$1
pushd $DIRNAME
PAGE=letter ./configure --prefix=/usr
make -j1
make install
popd
