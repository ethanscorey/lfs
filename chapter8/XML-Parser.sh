DIRNAME=$1
pushd $DIRNAME
perl Makefile.PL
make
make test
make install
popd
