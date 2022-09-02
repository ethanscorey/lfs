DIRNAME=$1
pushd $DIRNAME
#make mrproper
#make headers
ls
#find usr/include -name '.*' -delete
#rm usr/include/Makefile
#cp -rv usr/include $LFS/usr
popd
