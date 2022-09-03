for package in binutils gcc linux glibc; do
    source ./compile-package.sh 5 $package
done

if ! bash ./chapter5/sanity-check.sh | grep "/lib64/ld-linux-x86-64.so.2"; then
    echo "Failed sanity check"
    exit 1
fi
source ./compile-package.sh 5 libstdc++
