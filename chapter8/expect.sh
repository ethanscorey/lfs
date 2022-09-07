./configure \
    --prefix=/usr \
    --with-tcl=/usr/lib \
    --enable-shared \
    --mandir=/usr/share/man \
    --with-tcl-include=/usr/include
make
make test
make install
ln -svf expect$VERSION/libexpect$VERSION.so /usr/lib
