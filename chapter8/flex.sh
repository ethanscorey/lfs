DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/flex-$VERSION \
    --disable-static
make
make check
make install
ln -sv flex /usr/bin/lex
popd
