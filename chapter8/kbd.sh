DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
patch -Np1 -i ../kbd-$VERSION-backspace-1.patch
sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
./configure --prefix=/usr --disable-vlock
make
make check
make install
mkdir -pv           /usr/share/doc/kbd-$VERSION
cp -R -v docs/doc/* /usr/share/doc/kbd-$VERSION
popd
