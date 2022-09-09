DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/expat-$VERSION
make
make check
make install
install -v -m644 doc/*.{html,css} /usr/share/doc/expat-$VERSION
popd
