mkdir -pv mpfr
mkdir -pv mpc
mkdir -pv gmp
tar -xvf ../mpfr-*.tar.xz -C mpfr --strip-components=1
tar -xvf ../mpc-*.tar.gz -C mpc --strip-components=1
tar -xvf ../gmp-*.tar.xz -C gmp --strip-components=1
if echo $LFS_TGT | grep -qs '64'; then
	sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
fi
mkdir -v build
cd build
mkdir -pv $LFS_TGT/libgcc
ln -s ../../../libgcc/gthr-posix.h $LFS_TGT/libgcc/gthr-default.h
../configure \
	--build=$(../config.guess) \
	--host=$LFS_TGT \
	--prefix=/usr \
	CC_FOR_TARGET=$LFS_TGT-gcc \
	--with-build-sysroot=$LFS \
	--enable-initfini-array \
	--disable-nls \
	--disable-multilib \
	--disable-decimal-float \
	--disable-libatomic \
	--disable-libgomp \
	--disable-libquadmath \
	--disable-libssp \
	--disable-libvtv \
	--disable-libstdcxx \
	--enable-languages=c,c++
make
make DESTDIR=$LFS install
ln -sv gcc $LFS/usr/bin/cc
