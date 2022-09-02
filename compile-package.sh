CHAPTER=$1
PACKAGE=$2

cat $LFS/sources/packages.csv \
    | grep -i "$PACKAGE" \
    | grep -i -v "\.patch," \
    | while read line; do

    TARNAME="$LFS/sources/`echo $line | cut -d\, -f1`"
    DIRNAME="$(echo "$TARNAME" | sed 's/\(.*\)\.tar\..*/\1/')"
    if ! [ -e "$DIRNAME" ]; then
        echo "Extracting $TARNAME"
        mkdir -pv "$DIRNAME"
        tar -xvf "$TARNAME" -C "$DIRNAME"
        pushd "$DIRNAME"
        if [ "$(ls -lA | grep "^[d-]" | wc -l)" == "1" ]; then
            echo "Unpacking"
            mv $(ls -A)/* ./
        fi
        popd
    fi
    echo "Compiling $PACKAGE"
    sleep 5
    pushd "$DIRNAME"
        mkdir -pv "./logs/chapter$CHAPTER"
        if ! source "./chapter$CHAPTER/$PACKAGE.sh" 2>&1 | tee "./logs/chapter$CHAPTER/$PACKAGE.log"; then
            echo "Compiling $PACKAGE FAILED."
            popd
            exit 1
        fi
    popd
    echo "Done compiling $PACKAGE"
    rm -rf $DIRNAME
done
