DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configure --prefix=/usr --disable-static
make
make check
make docdir=/usr/share/doc/check-$VERSION install
popd
