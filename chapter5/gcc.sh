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
../configure \
	--target=$LFS_TGT \
	--prefix=$LFS/tools \
	--with-glibc-version=2.35 \
	--with-sysroot=$LFS \
	--with-newlib \
	--without-headers \
	--enable-initfini-array \
	--disable-nls \
	--disable-shared \
	--disable-multilib \
	--disable-decimal-float \
	--disable-threads \
	--disable-libatomic \
	--disable-libgomp \
	--disable-libquadmath \
	--disable-libssp \
	--disable-libvtv \
	--disable-libstdcxx \
	--enable-languages=c,c++
make
make install
cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
	`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h
