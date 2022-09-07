VERSION = $(echo $DIRNAME | cut -d"-" -f2)
mkdir -v build
cd build
../configure --prefix=/usr
makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
makeinfo --plaintext -o doc/dejagnu.txt ../doc/dejagnu.texi
make install
install -v -dm755 /usr/share/doc/dejagnu-$VERSION
install -v m644 doc/dejagnu.{html,txt} /usr/share/dic/dejagnu-$VERSION
make check
