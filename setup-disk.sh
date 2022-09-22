LFS_DISK=$1
sudo fdisk $LFS_DISK << EOF
g
n
1

+512M
t
1
4
n
2

+8G
t
2
19
n
3

+30G
n
4


p
v
w
q
EOF
sudo mkfs.ext4 "$(echo $LFS_DISK)p3"
sudo mkfs.ext4 "$(echo $LFS_DISK)p4"
sudo mkswap "$(echo $LFS_DISK)p2"
