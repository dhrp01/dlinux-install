#!/bin/bash
# Install/Setup vim

function echo_caption() {   echo -ne "\033[0;1;44m${*}\033[0m\n"; }

function vim_setup() {
    sudo apt install vim -y
    mkdir -p ~/.vim ~/.vim/autoload ~/.vim/backup ~/.vim/colors ~/.vim/plugged
    # Install vim-plug, plugin manager for vim
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    cd ~/.vim/colors
    curl -o molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
    cd -
    cd .vim/plugged
    git clone https://github.com/ycm-core/YouCompleteMe.git
    cd -
    cd .vim/plugged/YouCompleteMe
    git submodule update --init --recursive
    apt install build-essential cmake vim-nox python3-dev -y
    apt install mono-complete golang nodejs default-jdk npm -y
    python3 install.py --all
    cd -
    cp -u .vimrc ~/
    echo set editing-mode vi >> ~/.inputrc
    echo_caption "Open Vim and run 'PlugInstall' to install all the plugins"
}

vim_setup





