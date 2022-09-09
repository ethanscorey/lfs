VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./config \
    --prefix=/usr \
    --openssldir=/etc/ssl \
    --libdir=lib \
    shared \
    zlib-dynamic
make
make test
sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
make MANSUFFIX=ssl install
mv -v /usr/share/doc/openssl /usr/share/doc/openssl-$VERSION
cp -vfr doc/* /usr/share/doc/openssl-$VERSION
