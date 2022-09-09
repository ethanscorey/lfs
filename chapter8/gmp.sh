DIRNAME=$1
pushd $DIRNAME
VERSION = $(echo $DIRNAME | cut -d"-" -f2)
./configure \
    --prefix=/usr \
    --enable-cxx \
    --disable-static \
    --docdir=/usr/share/doc/gmp-$VERSION
make
make html
make check 2>&1 | tee gmp-check-log
awk '# PASS:/{total+=$3} l END{print total}' gmp-check-log
make install
make install-html
popd
