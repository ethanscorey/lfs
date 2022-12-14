DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f2)
mkdir -v build
cd build
../libstdc++-v3/configure \
	--host=$LFS_TGT \
	--build=$(../config.guess) \
	--prefix=/usr \
	--disable-multilib \
	--disable-nls \
	--disable-libstdcxx-pch \
	--with-gxx-include-dir=/tools/$LFS_TGT/include/c++/$VERSION
make
make DESTDIR=$LFS install
rm -v $LFS/usr/lib/lib{stdc++,stdc++fs,supc++}.la
popd
