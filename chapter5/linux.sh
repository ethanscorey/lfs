DIRNAME=$1
pushd $DIRNAME
make mrproper
make headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $LFS/usr
popd
