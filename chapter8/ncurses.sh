DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configure \
    --prefix=/usr \
    --mandir=/usr/share/man \
    --with-shared \
    --without-debug \
    --without-normal \
    --with-cxx-shared \
    --enable-pc-files \
    --enable-widec \
    --with-pkg-config-libdir=/usr/lib/pkgconfig
make
make DESTDIR=$PWD/dest install
install -vm755 dest/usr/lib/libcursesw.so.$VERSION /usr/lib
rm -v dest/usr/lib/libncursesw.so.$VERSION
cp -av dest/* /
for lib in ncurses form panel menu ; do
    rm -vf /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc /usr/lib/pkgconfig/${lib}.pc
done
rm -vf /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sfv libncurses.so /usr/lib/libcurses.so
mkdir -pv  /usr/share/doc/ncurses-$VERSION
cp -v -R doc/* /usr/share/doc/ncurses-$VERSION
make distclean
./configure \
    --prefix=/usr \
    --with-shared \
    --without-normal \
    --without-debug \
    --without-cxx-binding \
    --with-abi-version=5
make sources libs
cp -av lib/lib*.so.5* /usr/lib
popd
