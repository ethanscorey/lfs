DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
MAJOR_MINOR=$(python -c "print('$VERSION'[:-2])")
export BUILD_ZLIB=False
export BUILD_BZIP2=0
sh Configure \
    -des \
    -Dprefix=/usr \
    -Dvendorprefix=/usr \
    -Dprivlib=/usr/lib/perl5/$MAJOR_MINOR/core_perl \
    -Darchlib=/usr/lib/perl5/$MAJOR_MINOR/core_perl \
    -Dsitelib=/usr/lib/perl5/$MAJOR_MINOR/site_perl \
    -Dsitearch=/usr/lib/perl5/$MAJOR_MINOR/site_perl \
    -Dvendorlib=/usr/lib/perl5/$MAJOR_MINOR/vendor_perl \
    -Dvendorarch=/usr/lib/perl5/$MAJOR_MINOR/vendor_perl \
    -Dman1dir=/usr/share/man/man1 \
    -Dman3dir=/usr/share/man/man3 \
    -Dpager="/usr/bin/less -isR" \
    -Duseshrplib \
    -Dusethreads
make
make test
make install
unset BUILD_ZLIB BUILD_BZIP2
popd
