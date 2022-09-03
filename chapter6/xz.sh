DIRNAME=$1
pushd $DIRNAME
./configure \
	--prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess) \
	--disable-static \
	--docdir=/usr/share/doc/$DIRNAME
make
make DESTDIR=$LFS install
rm -v $LFS/usr/lib/liblzma.la
popd
