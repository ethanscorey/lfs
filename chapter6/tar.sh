DIRNAME=$1
pushd $DIRNAME
cd tar-1.34
./configure \
	--prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)
make
make DESTDIR=$LFS install
popd
