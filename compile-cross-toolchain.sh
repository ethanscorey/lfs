#!/bin/bash

# Setup the environment
source /lfs/setup-env.sh

# Install Binutils
cd $LFS/sources
if ! [ -e binutils-2.38 ]; then
tar -xvf binutils-2.38.tar.xz
fi
cd binutils-2.38
mkdir -v build
cd build
../configure --prefix=$LFS/tools \
	    --with-sysroot=$LFS \
	    --target=$LFS_TGT \
	    --disable-nls \
	    --disable-werror
make
make install
cd $LFS/sources
rm binutils-2.38

# Install gcc
if ! [ -e gcc-11.2.0 ]; then
tar -xvf gcc-11.2.0.tar.xz
fi
cd gcc-11.2.0
tar -xvf ../mpfr-4.1.0.tar.xz
mv -v mpfr-4.1.0 mpfr
tar -xvf ../mpc-1.2.1.tar.gz
mv -v mpc-1.2.1 mpc
tar -xvf ../gmp-6.2.1.tar.xz
mv -v gmp-6.2.1 gmp
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
cd $LFS/sources
rm -rvf gcc-11.2.0

# Install Linux headers
if ! [ -e linux-5.16.9 ]; then
tar -xvf linux-5.16.9.tar.xz
fi
cd linux-5.16.9
make mrproper
make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include $LFS/usr
cd $LFS/sources
rm -rvf linux-5.16.9

# Install Glibc
if ! [ -e glibc-2.35 ]; then
tar -xvf glibc-2.35.tar.xz
fi
cd glibc-2.35
case $(uname -m) in
	i?86) ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
	;;
	x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
		ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
	;;
esac
patch -Np1 -i ../glibc-2.35-fhs-1.patch
mkdir -v build
cd build
echo "rootsbindir=/usr/sbin" > configparms
../configure \
	--prefix=/usr \
	--host=$LFS_TGT \
	--build=$(../scripts/config.guess) \
	--enable-kernel=3.2 \
	--with-headers=$LFS/usr/include \
	libc_cv_slibdir=/usr/lib
make
make DESTDIR=$LFS install
# Fix hardcoded path to the executable loader in ldd script
sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

# Sanity check compiling and linking
echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep '/ld-linux'
cd $LFS/sources
rm -rf glibc-2.35
