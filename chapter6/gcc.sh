DIRNAME=$1
pushd $DIRNAME
mkdir -pv mpfr
mkdir -pv mpc
mkdir -pv gmp
tar -xvf ../mpfr-*.tar.xz -C mpfr --strip-components=1
tar -xvf ../mpc-*.tar.gz -C mpc --strip-components=1
tar -xvf ../gmp-*.tar.xz -C gmp --strip-components=1
if echo $LFS_TGT | grep -qs '64'; then
	sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
fi
sed '/thread_header =/s/@.*@/gthr-posix.h' \
    -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in
mkdir -v build
cd build
../configure \
	--build=$(../config.guess) \
	--host=$LFS_TGT \
    --target=$LFS_TGT \
    LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc \
	--prefix=/usr \
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
	--enable-languages=c,c++
make
make DESTDIR=$LFS install
ln -sv gcc $LFS/usr/bin/cc
popd
