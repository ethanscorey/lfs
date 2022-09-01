#!/bin/sh
sed -e 's/^# *//' /etc/apk/repositories -i
apk update
apk upgrade
apk add \
    bash \
    binutils \
    bison \
    coreutils \
    diffutils \
    findutils \
    gawk \
    gcc \
    g++
    grep \
    gzip \
    grep \
    m4 \
    make \
    patch \
    perl \
    python3 \
    sed \
    tar \
    texinfo \
    xz
ln -svf bash /bin/sh
apk add github-cli vim
cat > ~/.vimrc << EOF
filetype plugin indent on
inoremap jk <ESC>
vnoremap . :norm.<CR>
set autoindent
set hlsearch
set tabstop=4
set expandtab
set number
set shiftwidth=4
EOF
bash version-check.sh
