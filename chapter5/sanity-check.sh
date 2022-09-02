echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep '/ld-linux'
$LFS/tools/libexec/gcc/$LFS_TGT/11.2.0/install-tools/mkheaders
