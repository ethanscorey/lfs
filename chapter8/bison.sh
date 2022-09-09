DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configure --prefix=/usr --docdir=/usr/share/doc/bison-$VERSION
make
make check
make install
popd
