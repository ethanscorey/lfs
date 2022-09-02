if ! [ -e grep-3.7 ]; then
	tar -xvf grep-3.7.tar.xz
fi
cd grep-3.7
./configure \
	--prefix=/usr \
	--host=$LFS_TGT
make
make DESTDIR=$LFS install
