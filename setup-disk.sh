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
mkfs.ext4 "$(LFS_DISK)p3"
mkswap "$(LFS_DISK)p2"
