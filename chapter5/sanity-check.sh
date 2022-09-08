echo 'int main(){}' | gcc -xc -
readelf -l a.out | grep '/ld-linux'
rm a.out
