CHAPTER=$1
PACKAGE=$2
KEEP=$3

# Hard code file for libstdc++ and remove Tcl doc archive
echo "libstdc++-12.2.0.tar.xz" | \
    cat - $LFS/sources/packages.csv \
    | cut -d\, -f1 \
    | sed "s/tcl.*html.*//" \
    | grep "^$PACKAGE.*tar" \
    | grep -v "\.patch," \
    | while read line; do

    TARNAME="$LFS/sources/`echo $line | cut -d\, -f1`"
    DIRNAME="$(echo "$TARNAME" | sed 's/\(.*\)\.tar\..*/\1/')"
    if ! [ -e "$DIRNAME" ]; then
        echo "Extracting $TARNAME"
        mkdir -pv "$DIRNAME"
        tar -xf "$TARNAME" -C "$DIRNAME"
        pushd "$DIRNAME"
        if [ "$(ls -lA | grep "^[d-]" | wc -l)" == "1" ]; then
            echo "Unpacking"
            (shopt -s dotglob; mv $(ls -A)/* ./)
        fi
        popd
    fi
    echo "Compiling $PACKAGE"
    sleep 5
    mkdir -pv "$LFS/logs/chapter$CHAPTER"
    if ! source "./chapter$CHAPTER/$PACKAGE.sh" $DIRNAME 2>&1 | tee "$LFS/logs/chapter$CHAPTER/$PACKAGE.log"; then
        echo "Compiling $PACKAGE FAILED."
        exit 1
    fi
    echo "Done compiling $PACKAGE"
    if ! [ "$KEEP" == "KEEP" ]; then
        rm -rf $DIRNAME
    fi
done
