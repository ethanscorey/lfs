DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
patch -Np1 -i ../zstd-$VERSION-upstream-fixes-1.patch
make prefix=/usr
make check
make prefix=/usr install
rm -v /usr/lib/libstd.a
popd
