DIRNAME=$1
pushd $DIRNAME
VERSION=$(echo $DIRNAME | cut -d"-" -f3)
./configure \
    ADJTIME_PATH=/var/lib/hwclock/adjtime \
    --libdir=/usr/lib \
    --docdir=/usr/share/doc/util-linux-$VERSION \
    --disable-chfn-chsh \
    --disable-login \
    --disable-nologin \
    --disable-su \
    --disable-setpriv \
    --disable-runuser \
    --disable-pylibmount \
    --disable-static \
    --without-python \
   runstatedir=/run
make
make install
popd
