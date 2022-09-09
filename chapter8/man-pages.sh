DIRNAME=$1
pushd $DIRNAME
make prefix=/usr install
popd
