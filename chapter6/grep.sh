DIRNAME=$1
pushd $DIRNAME
./configure \
	--prefix=/usr \
	--host=$LFS_TGT
make
make DESTDIR=$LFS install
popd
