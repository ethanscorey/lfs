for package in binutils gcc linux glibc libstdc++; do
    source ./compile-package.sh 5 $package
done
