LFS_DISK=$1
fdisk $LFS_DISK << EOF
o
n
p
1

+100M
a
1
n
p
p
2

+8G
n
p
3


p
v
w
q
EOF
