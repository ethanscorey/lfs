#!/bin/bash
SOURCE_DIR=$1
echo "Downloading source code"
if ! [ -e packages.csv ]; then
    wget https://www.linuxfromscratch.org/lfs/view/stable/wget-list-sysv
    wget https://www.linuxfromscratch.org/lfs/view/stable/md5sums
    python3 create_pkg_csv.py wget-list-sysv md5sums
fi
cp -f packages.csv $SOURCE_DIR
cp -f md5sums $SOURCE_DIR
pushd $SOURCE_DIR
cat packages.csv | while read line; do
   NAME="`echo $line | cut -d\, -f1`"
   URL="`echo $line | cut -d\, -f2`"
   if ! [ -e $NAME ]; then
       echo "Downloading $NAME from $URL"
       wget $URL
   fi
done
if md5sum -c md5sums >/dev/null; then
    cat md5sums | while read line; do
        if echo $line | md5sum -c >/dev/null; then
            NAME="`echo $line | cut -d' ' -f2`"
            EXPECTED="`echo $line | cut -d' ' -f1`"
            ACTUAL="`echo $(md5sum $NAME | cut -d' ' -f1)`"
            # We do another check because one line is buggy
            if ! [ "$EXPECTED" == "$ACTUAL" ]; then
                echo "Verification of $NAME failed. MD5 mismatch."
                echo "Expected $EXPECTED"
                echo "Got $ACTUAL"
                rm -rf $NAME
                exit 1
            fi
        fi
    done
fi
popd
