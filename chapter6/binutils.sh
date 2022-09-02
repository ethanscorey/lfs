sed '6009s/$add_dir//' -i ltmain.sh
mkdir -v build
cd build
../configure \
	--prefix=/usr \
	--build=$(../config.guess) \
	--host=$LFS_TGT \
	--disable-nls \
	--enable-shared \
	--disable-werror \
	--enable-64-bit-bfd
make
make DESTDIR=$LFS install
#cd $LFS/sources
#rm -rvf binutils-2.38

 Install gcc (Pass 2)
if ! [ -e gcc-11.2.0 ]; then
	tar -xvf gcc-11.2.0.tar.xz
fi
cd gcc-11.2.0
tar -xvf ../mpfr-4.1.0.tar.xz
mv -v mpfr-4.1.0 mpfr
tar -xvf ../gmp-6.2.1.tar.xz
mv -v gmp-6.2.1 gmp
tar -xvf ../mpc-1.2.1.tar.gz
mv -v mpc-1.2.1 mpc
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
