#!/bin/sh
sudo sed "/jammy main restricted/a deb http:\/\/archive.ubuntu.com\/ubuntu\/ jammy universe" -i /etc/apt/sources.list
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
GH_KEYRING=/usr/share/keyrings/githubcli-archive-keyring.gpg
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=$GH_KEYRING \
    && sudo chmod go+r $GH_KEYRING \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=$GH_KEYRING] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
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
