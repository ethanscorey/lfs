DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configure --prefix=/usr --docdir=/usr/share/doc/automake-$VERSION
make
make -j4 check
make install
popd
