DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
patch -Np1 -i ../sysvinit-$VERSION-consolidated-1.patch
make
make install
popd
