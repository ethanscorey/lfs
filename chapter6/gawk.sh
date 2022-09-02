DIRNAME=$1
pushd $DIRNAME
sed -i 's/extras//' Makefile.in
./configure \
	--prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)
make
make DESTDIR=$LFS install
popd
