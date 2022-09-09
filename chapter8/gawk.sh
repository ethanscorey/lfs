DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
sed -i 's/extras//' Makefile.in
./configure --prefix=/usr
make
make check
make install
mkdir -pv /usr/share/doc/gawk-$VERSION
cp -v doc/{awkforai.txt,*.{eps,pdf,jpg)} /usr/share/doc/gawk-$VERSION
popd
