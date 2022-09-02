MD5SUM=$1
NAME=$2

echo $NAME
echo $MD5SUM
echo "$MD5SUM  $NAME"
if ! echo "$MD5SUM  $NAME" | md5sum -c>/dev/null; then
    echo "Verification of $NAME failed. MD5 mismatch."
    echo "Got $(md5sum $NAME)"
    echo "Expected $MD5SUM"
    rm -rf $NAME
    exit 1
fi
