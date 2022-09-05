CHAPTER=$1
PACKAGE=$2

# Hard code file for libstdc++
echo "libstdc++-12.2.0.tar.xz" | \
    cat - $LFS/sources/packages.csv \
    | cut -d\, -f1 \
    | grep -i "^$PACKAGE.*tar" \
    | grep -i -v "\.patch," \
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
    mkdir -pv "./logs/chapter$CHAPTER"
    if ! source "./chapter$CHAPTER/$PACKAGE.sh" $DIRNAME 2>&1 | tee "./logs/chapter$CHAPTER/$PACKAGE.log"; then
        echo "Compiling $PACKAGE FAILED."
        exit 1
    fi
    echo "Done compiling $PACKAGE"
    rm -rf $DIRNAME
done
