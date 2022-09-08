VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configure --prefix=/usr --docdir=/usr/share/doc/gperf-$VERSION
make
make -j1 check
make install
