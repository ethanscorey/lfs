DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configure \
    --prefix=/usr \
    --enable-shared \
    --with-system-expat \
    --with-system-ffi \
    --enable-optimizations
make
make install
cat > /etc/pip.conf << EOF
[global]
root-user-action = ignore
disable-pip-version-check = true
EOF
install -v -dm755 /usr/share/doc/python-$VERSION/html
tar --strip-components=1 \
    --no-same-owner \
    --no-same-permissions \
    -C /usr/share/doc/python-$VERSION/html \
    -xvf ../python-$VERSION-docs-html.tar.bz
popd
