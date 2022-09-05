DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
sh Configure \
    -des \
    -Dprefix=/usr \
    -Dvendorprefix=/usr \
    -Dprivlib=/usr/lib/perl5/$VERSION/core_perl \
    -Darchlib=/usr/lib/perl5/$VERSION/core_perl \
    -Dsitelib=/usr/lib/perl5/$VERSION/site_perl \
    -Dsitearch=/usr/lib/perl5/$VERSION/site_perl \
    -Dvendorlib=/usr/lib/perl5/$VERSION/vendor_perl \
    -Dvendorarch=/usr/llib/perl5/$VERSION/vendor_perl
make
make install
popd
