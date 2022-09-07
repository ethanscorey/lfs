VERSION=$(echo $DIRNAME | cut -d"-" -f2)
tar -xf ../tcl$VERSION-html.tar.gz --strip-components=1
SRCDIR=$(pwd)
cd unix
./configure \
    --prefix=/usr \
    --mandir=/usr/share/man
make
sed -e "s|$SRCDIR/unix|/usr/lib|" \
    -e "s|$SRCDIR|/usr/include|" \
    -i tclConfig.sh
sed -e "s|$SRCDIR/unix/pkgs/tdbc|/usr/lib/tdbc|" \
    -e "s|$SRCDIR/pkgs/tdbc[0-9]*\.[0-9]*\.[0-9]*/generic|/usr/include|" \
    -e "s|$SRCDIR/pkgs/tdbc[0-9]*\.[0-9]*\.[0-9]*/library|/usr/lib/tcl$(echo $VERSION | sed "s/\.[0-9]*$//")|" \
    -e "s|$SRCDIR/pkgs/tdbc[0-9]*\.[0-9]*\.[0-9]*|/usr/include|" \
    -i pkgs/tdbc[0-9]*.[0-9]*.[0-9]*/tdbcConfig.sh
sed -e "s|$SRCDIR/unix/pkgs/itcl|/usr/lib/itcl|" \
    -e "s|$SRCDIR/pkgs/itcl[0-9]*.[0-9]*.[0-9]*/generic|/usr/include|" \
    -e "s|$SRCDIR/pkgs/itcl[0-9]*.[0-9]*.[0-9]*|/usr/include|" \
    -i pkgs/itcl[0-9]*.[0-9]*.[0-9]*/itclConfig.sh
unset SRCDIR
make test
make install
chmod -v u+w /usr/lib/libtcl$(echo $VERSION | sed "s/\.[0-9]*$//")
make install-private-headers
ln -sfv tclsh$(echo $VERSION | sed "s/\.[0-9]*$//") /usr/bin/tclsh
mv /usr/share/man/man3/{Thread,Tcl_Thread}.3
mkdir -v -p /usr/share/doc/tcl-$VERSION
cp -v -r ../html/* /usr/share/doc/tcl-$VERSION
