echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
READELF_OUTPUT=$(readelf -l a.out | grep ': /lib')
if ! echo $READELF_OUTPUT | grep "/lib64/ld-linux-x86-64.so.2"; then
    echo "Dynamic linker not found"
    exit 1
fi
START_FILES=$(grep -o '/usr.lib/*./crt[1in].*succeeded' dummy.log)
for $file in "crt1.o" "crti.o" "crtn.o"; do
    if ! echo $START_FILES | grep "/usr/lib/gcc/.*$file succeeded"; then
        echo "$file not found"
        exit 1
    fi 
done
INCLUDE_PATH=$(grep -B4 '^ /usr/include' dummy.log)
for $path in "/usr/lib/gcc/.*/include" "/usr/local/include" "/usr/lib/gcc.*/include-fixed" "/usr/include"; do
    if ! echo $INCLUDE_PATH | grep $path; then
        echo "$path not found"
        exit 1
    fi
done
LINKER_PATH=$(grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g')
for $path in \
    "/usr/x86_64.*/lib64" \
    "/usr/local/lib64" \
    "/lib64" \
    "/usr/lib64" \
    "/usr/x86_64.*/lib\"" \
    "/usr/local/lib" \
    "/lib" \
    "/usr/lib"; do
    if ! echo $LINKER_PATH | grep $path; then
        echo "$path not found"
        exit 1
    fi
done
LIBC=$(grep "/lib.*/libc.so.6 " dummy.log)
if ! echo $LIBC | grep "attempt to open /usr/lib/libc.so.6 succeeded"; then
    echo "libc failed"
    exit 1
fi
$DYNAMIC_LINKER=$(grep found dummy.log)
if ! echo $DYNAMIC_LINKER | grep "found ld-linux-.*so\.2 at /usr/lib/ld-linux-.*so.2"; then
    echo "dynamic linker not found"
    exit 1
fi
rm -v dummy.c a.out dummy.log
mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
