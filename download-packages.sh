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
cd $SOURCE_DIR
cat packages.csv | while read line; do
   NAME="`echo $line | cut -d\, -f1`"
   URL="`echo $line | cut -d\, -f2`"
   MD5SUM="`echo $line | cut -d\, -f3`"
   if ! [ -e $NAME ]; then
       echo "Downloading $NAME from $URL"
       wget $URL
   fi
 done
 md5sum -c md5sums
