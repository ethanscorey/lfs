DIRNAME=$1
pushd $DIRNAME
echo "Compiling binutils!!! from within $(pwd)"
mkdir -v build
cd build
../configure --prefix=$LFS/tools \
	    --with-sysroot=$LFS \
	    --target=$LFS_TGT \
	    --disable-nls \
	    --disable-werror
make
make install
popd
