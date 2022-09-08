VERSION=$(echo $DIRNAME | cut -d"-" -f2)
./configure \
    --prefix=/usr \
    --docdic=/usr/share/doc/bash-$VERSION \
    --without-bash-malloc \
    --with-installed-readme
make
chown -Rv tester .
su -s /usr/bin/expect tester << EOF
set timeout -1
spawn make tests
export eof
lassign [wait] ___ value
exit $value
EOF
make install
exec /usr/bin/bash --login
