#!/bin/bash
ls ~
if ! [ -e ~/.bash_profile ]; then
cat > ~/.bash_profile << EOF
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w$ ' /bin/bash
EOF
fi
if ! [ -e ~/.bashrc ]; then
cat > ~/.bashrc << EOF
set +h
umask 022
LFS=$LFS
LC_ALL=POSIX
LFS_TGT=$LFS_TGT
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF
fi
