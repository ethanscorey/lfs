#!/bin/sh
if ! grep "jammy universe" /etc/apt/sources.list; then
    sudo sed "/ubuntu\/ jammy main restricted/a deb http:\/\/archive.ubuntu.com\/ubuntu\/ jammy universe" -i /etc/apt/sources.list
fi
sudo apt update
sudo apt upgrade -y
sudo apt install -y \
    bash \
    binutils \
    bison \
    build-essential \
    coreutils \
    curl \
    diffutils \
    e2fsprogs \
    findutils \
    gawk \
    info \
    install-info \
    make \
    manpages-dev \
    grep \
    gzip \
    m4 \
    patch \
    perl \
    python3 \
    sed \
    tar \
    texinfo \
    xz-utils
sudo ln -svf bash /bin/sh
sudo apt install -y vim
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
