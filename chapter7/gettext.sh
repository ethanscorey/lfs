DIRNAME=$1
pushd $DIRNAME
./configure --disable-shared
make
cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin
popd
