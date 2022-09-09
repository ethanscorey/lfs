DIRNAME=$1
pushd $DIRNAME
pip3 install --no-index $PWD
popd
