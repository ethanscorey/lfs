echo 'int main(){}' | gcc -xc -
readelf -l a.out | grep '/ld-linux'
rm a.out
#$LFS/tools/libexec/gcc/$LFS_TGT/11.2.0/install-tools/mkheaders
