#!/bin/bash
LFS_USER=$1
export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu

if ! [ $USER == $LFS_USER ]; then
    if ! grep -q $LFS_USER /etc/passwd; then
        sudo useradd -s /bin/bash -d /home/$LFS_USER -k /dev/null -mU $LFS_USER
        sudo passwd -d $LFS_USER
        sudo usermod -aG sudo $LFS_USER
        sudo cp -rf . /home/$LFS_USER/lfs
        sudo cp -f ./lfs_bashrc /home/$LFS_USER/.bashrc
        sudo sed -e "s|\$LFS_TGT|$LFS_TGT|" -i /home/$LFS_USER/.bashrc
        sudo sed -e "s|\$LFS|$LFS|" -i /home/$LFS_USER/.bashrc
        sudo cp -f ./lfs_bash_profile /home/$LFS_USER/.bash_profile
        sudo sed -e "s|\$HOME|/home/$LFS_USER|" -i /home/$LFS_USER/.bash_profile
        sudo sed -e "s|\$TERM|$TERM|" -i /home/$LFS_USER/.bash_profile
        sudo cp -f ./lfs_vimrc /home/$LFS_USER/.vimrc
        sudo chown -R $LFS_USER:$LFS_USER /home/$LFS_USER
    fi
    su - $LFS_USER
fi
