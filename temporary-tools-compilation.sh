#!/bin/bash

# Setup the environment
source /lfs/setup-env.sh
cd $LFS/sources

# Install M4
if ! [ -e m4-1.4.19 ]; then
	tar xvf m4-1.4.19.tar.xz
fi
cd m4-1.4.19
./configure \
	--prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)
make
make DESTDIR=$LFS install
cd $LFS/sources
rm -rvf m4-1.4.19

# Install Ncurses
if ! [ -e ncurses-6.3 ]; then
	tar xvf ncurses-6.3.tar.gz
fi
cd ncurses-6.3
sed -i s/mawk// configure
mkdir build
pushd build
	../configure
	make -C include
	make -C progs tic
popd
./configure \
	--prefix=/usr \
	--host=$LFS_TGT \
	--build=$(./config.guess) \
	--mandir=/usr/share/man \
	--with-manpage-format=normal \
	--with-shared \
	--without-debug \
	--without-ada \
	--without-normal \
	--disable-stripping \
	--enable-widec
make
make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so
cd $LFS/sources
rm -rvf ncurses-6.3

# Install Bash
if ! [ -e bash-5.1.16 ]; then
	tar xvf bash-5.1.16.tar.gz
fi
cd bash-5.1.16
./configure \
	--prefix=/usr \
	--build=$(support/config.guess) \
	--host=$LFS_TGT \
	--without-bash-malloc
make
make DESTDIR=$LFS install
ln -sv bash $LFS/bin/sh
cd $LFS/sources
rm -rvf bash-5.1.16

# Install Coreutils
if ! [ -e coreutils-9.0 ]; then
	tar xvf coreutils-9.0.tar.xz
fi
cd coreutils-9.0
./configure \
	--prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess) \
	--enable-install-program=hostname \
	--enable-no-install-program=kill,uptime
make
make DESTDIR=$LFS install
mv -v $LFS/usr/bin/chroot $LFS/usr/sbin
mkdir -pv $LFS/usr/share/man/man8
mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' $LFS/usr/share/man/man8/chroot.8
cd $LFS/sources
rm -rvf coreutils-9.0

# Install Diffutils
if ! [ -e diffutils-3.8 ]; then
	tar -xvf diffutils-3.8.tar.xz
fi
cd diffutils-3.8
./configure \
	--prefix=/usr \
	--host=$LFS_TGT
make
make DESTDIR=$LFS install
cd $LFS/sources
rm -rvf diffutils-3.8

# Install File
if ! [ -e file-5.41 ]; then
	tar -xvf file-5.41.tar.gz
fi
cd file-5.41
mkdir build
pushd build
	../configure \
		--disable-bzlib \
		--disable-libseccomp \
		--disable-xzlib \
		--disable-zlib
	make
popd
./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)
make FILE_COMPILE=$(pwd)/build/src/file
make DESTDIR=$LFS install
cd $LFS/sources
rm -rvf file-5.41

# Install Findutils
if ! [ -e findutils-4.9.0 ]; then
	tar -xvf findutils-4.9.0.tar.xz
fi
cd findutils-4.9.0
./configure \
	--prefix=/usr \
	--localstatedir=/var/lib/locate \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)
make
make DESTDIR=$LFS install
cd $LFS/sources
rm -rvf findutils-4.9.0

# Install Gawk
if ! [ -e gawk-5.1.1 ]; then
	tar -xvf gawk-5.1.1.tar.xz
fi
cd gawk-5.1.1
sed -i 's/extras//' Makefile.in
./configure \
	--prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)
make
make DESTDIR=$LFS install
cd $LFS/sources
rm -rvf gawk-5.1.1

# Install Grep
if ! [ -e grep-3.7 ]; then
	tar -xvf grep-3.7.tar.xz
fi
cd grep-3.7
./configure \
	--prefix=/usr \
	--host=$LFS_TGT
make
make DESTDIR=$LFS install
cd $LFS/sources
rm -rvf grep-3.7

# Install Gzip
if ! [ -e gzip-1.11 ]; then
	tar -xvf gzip-1.11.tar.xz
fi
cd gzip-1.11
./configure --prefix=/usr --host=$LFS_TGT
nake
make DESTDIR=$LFS install
cd $LFS/sources
rm -rvf gzip-1.11

# Install Make
if ! [ -e make-4.3 ]; then
	tar -xvf make-4.3.tar.gz
fi
cd make-4.3
./configure \
	--prefix=/usr \
	--without-guile \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)
make
make DESTDIR=$LFS install
cd $LFS/sources
rm -rvf make-4.3

# Install Patch
if ! [ -e patch-2.7.6 ]; then
	tar -xvf patch-2.7.6.tar.xz
fi
cd patch-2.7.6
./configure \
	--prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)
make
make DESTDIR=$LFS install
cd $LFS/sources
rm -rvf patch-2.7.6

# Install Sed
if ! [ -e sed-4.8 ]; then
	tar -xvf sed-4.8.tar.xz
fi
cd sed-4.8
./configure \
	--prefix=/usr \
	--host=$LFS_TGT
make
make DESTDIR=$LFS install
cd $LFS/sources
rm -rvf sed-4.8

# Install Tar
if ! [ -e tar-1.34 ]; then
	tar -xvf tar-1.34.tar.xz
fi
cd tar-1.34
./configure \
	--prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)
make
make DESTDIR=$LFS install
cd $LFS/sources
rm -rvf tar-1.34

# Install Xz
if ! [ -e xz-5.2.5 ]; then
	tar -xvf xz-5.2.5.tar.xz
fi
cd xz-5.2.5
./configure \
	--prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess) \
	--disable-static \
	--docdir=/usr/share/doc/xz-5.2.5
make
make DESTDIR=$LFS install
cd $LFS/sources
rm -rvf xz-5.2.5

# Install Binutils (pass 2)
if ! [ -e binutils-2.38 ]; then
	tar -xvf binutils-2.38.tar.xz
fi
cd binutils-2.38
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
cd $LFS/sources
rm -rvf gcc-11.2.0
